
package com.tap.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.tap.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final double DELIVERY_FEE = 40.0;
    private static final double PLATFORM_FEE = 5.0;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String ctx = request.getContextPath();

        if (session == null) {
            response.sendRedirect(ctx + "/cart");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(ctx + "/cart");
            return;
        }

        if (session.getAttribute("user") == null) {
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

        double itemTotal = cart.getTotal();
        double grandTotal =
                itemTotal + DELIVERY_FEE + PLATFORM_FEE;

        request.setAttribute("cart", cart);
        request.setAttribute("itemTotal", itemTotal);
        request.setAttribute("deliveryFee", DELIVERY_FEE);
        request.setAttribute("platformFee", PLATFORM_FEE);
        request.setAttribute("grandTotal", grandTotal);

        request.getRequestDispatcher("/Payment.jsp")
               .forward(request, response);
    }
}
