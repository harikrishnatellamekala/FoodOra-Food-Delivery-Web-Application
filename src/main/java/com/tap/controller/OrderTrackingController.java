package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.dao.MenuDao;
import com.tap.dao.OrderDao;
import com.tap.dao.OrderItemDao;
import com.tap.dao.RestaurantDao;
import com.tap.daoImpl.MenuDaoImpl;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.OrderItemDaoImpl;
import com.tap.daoImpl.RestaurantDaoImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/orderTracking", "/myOrders"})
public class OrderTrackingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDao orderDao;
    private OrderItemDao orderItemDao;
    private MenuDao menuDao;
    private RestaurantDao restaurantDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
        orderItemDao = new OrderItemDaoImpl();
        menuDao = new MenuDaoImpl();
        restaurantDao = new RestaurantDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String ctx = req.getContextPath();
        HttpSession session = req.getSession(false);

        boolean loggedIn = session != null
                && session.getAttribute("user") instanceof User;

        // ===== MY ORDERS PAGE =====
        if ("/myOrders".equals(req.getServletPath())) {

            req.setAttribute("loggedIn", loggedIn);

            // Not logged in: show the page with a "please login" message
            if (!loggedIn) {
                req.getRequestDispatcher("/Orders.jsp").forward(req, resp);
                return;
            }

            User user = (User) session.getAttribute("user");

            List<Order> orders =
                    new ArrayList<>(orderDao.getOrdersByUser(user.getUserId()));

            // newest order first
            orders.sort(Comparator.comparingInt(Order::getOrderId).reversed());

            Map<Integer, List<OrderItem>> itemsByOrder = new HashMap<>();
            Map<Integer, String> menuNames = new HashMap<>();
            Map<Integer, String> restaurantNames = new HashMap<>();

            for (Order o : orders) {

                List<OrderItem> items =
                        orderItemDao.getOrderItemsByOrder(o.getOrderId());
                itemsByOrder.put(o.getOrderId(), items);

                for (OrderItem item : items) {
                    int menuId = item.getMenuId();
                    if (!menuNames.containsKey(menuId)) {
                        Menu m = menuDao.getMenu(menuId);
                        menuNames.put(menuId,
                                m == null ? "Item #" + menuId : m.getItemName());
                    }
                }

                int restId = o.getRestaurantId();
                if (!restaurantNames.containsKey(restId)) {
                    Restaurant r = restaurantDao.getRestaurant(restId);
                    restaurantNames.put(restId,
                            r == null ? "Restaurant #" + restId : r.getName());
                }
            }

            req.setAttribute("orders", orders);
            req.setAttribute("itemsByOrder", itemsByOrder);
            req.setAttribute("menuNames", menuNames);
            req.setAttribute("restaurantNames", restaurantNames);

            req.getRequestDispatcher("/Orders.jsp").forward(req, resp);
            return;
        }

        // ===== SINGLE ORDER TRACKING (/orderTracking?orderId=..) =====
        if (!loggedIn) {
            resp.sendRedirect(ctx + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String orderIdParam = req.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            resp.sendRedirect(ctx + "/myOrders");
            return;
        }

        int orderId;

        try {
            orderId = Integer.parseInt(orderIdParam.trim());
        } catch (NumberFormatException e) {
            resp.sendRedirect(ctx + "/myOrders");
            return;
        }

        if (orderId <= 0) {
            resp.sendRedirect(ctx + "/myOrders");
            return;
        }

        Order order = orderDao.getOrder(orderId);

        if (order == null || order.getUserId() != user.getUserId()) {
            resp.sendRedirect(ctx + "/myOrders");
            return;
        }

        req.setAttribute("order", order);
        req.getRequestDispatcher("/OrderTracking.jsp").forward(req, resp);
    }
}