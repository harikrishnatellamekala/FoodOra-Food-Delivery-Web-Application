package com.tap.controller;

import java.io.IOException;

import com.tap.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/proceed")
public class ProceedController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        // No cart or empty cart
        if (cart == null || cart.getItems().isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath() + "/cart"
            );

            return;
        }

        // Check whether user is logged in
        Object user = session.getAttribute("user");

        if (user == null) {

            String returnUrl =
                    req.getContextPath() + "/payment";

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login?returnUrl="
                    + java.net.URLEncoder.encode(
                            returnUrl,
                            "UTF-8")
            );

            return;
        }

        // User is already logged in
        resp.sendRedirect(
                req.getContextPath() + "/payment"
        );
    }
}