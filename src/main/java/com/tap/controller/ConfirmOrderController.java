
package com.tap.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.dao.OrderItemDao;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.OrderItemDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/confirmOrder")
public class ConfirmOrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String ctx = request.getContextPath();
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(ctx + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            String returnUrl = ctx + "/payment";

            response.sendRedirect(
                ctx + "/login?returnUrl=" +
                URLEncoder.encode(
                    returnUrl,
                    StandardCharsets.UTF_8.name()
                )
            );
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(ctx + "/cart");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null ||
            !(paymentMethod.equals("UPI")
              || paymentMethod.equals("CARD")
              || paymentMethod.equals("COD"))) {

            response.sendRedirect(ctx + "/payment");
            return;
        }

        try {
            double itemTotal = cart.getTotal();
            double deliveryFee = 40.0;
            double platformFee = 5.0;
            double grandTotal = itemTotal + deliveryFee + platformFee;

            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setRestaurantId(cart.getRestaurantId());
            order.setOrderDate(
                new Timestamp(System.currentTimeMillis())
            );
            order.setTotalAmount(grandTotal);
            order.setStatus("PLACED");
            order.setPaymentMode(paymentMethod);

            int orderId = orderDao.addOrder(order);

            if (orderId <= 0) {
                response.sendRedirect(ctx + "/payment");
                return;
            }

            order.setOrderId(orderId);

            List<CartItem> orderedItems =
                new ArrayList<>(cart.getItems().values());

            session.setAttribute("lastOrderId", orderId);
            session.setAttribute("trackingOrder", order);
            session.setAttribute("trackingItems", orderedItems);
            session.setAttribute("trackingItemTotal", itemTotal);
            session.setAttribute("trackingDeliveryFee", deliveryFee);
            session.setAttribute("trackingPlatformFee", platformFee);
            session.setAttribute("trackingGrandTotal", grandTotal);

            for (CartItem cartItem : orderedItems) {
                OrderItem orderItem = new OrderItem();

                orderItem.setOrderId(orderId);
                orderItem.setMenuId(
                    cartItem.getMenu().getMenuId()
                );
                orderItem.setTotalAmount(
                    cartItem.getSubtotal()
                );

                orderItemDao.addOrderItem(orderItem);
            }

            cart.clearCart();
            session.setAttribute("cartCount", 0);

            // Correct: send order ID through the tracking controller.
            response.sendRedirect(
                ctx + "/orderTracking?orderId=" + orderId
            );

        } catch (Exception e) {
            throw new ServletException(
                "Unable to complete order processing.", e
            );
        }
    }
}
