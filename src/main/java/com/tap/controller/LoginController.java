package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String returnUrl = req.getParameter("returnUrl");

        req.setAttribute("returnUrl", returnUrl);

        req.getRequestDispatcher("Login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String returnUrl = req.getParameter("returnUrl");

        try {

            UserDaoImpl userDao = new UserDaoImpl();

            User user = userDao.getUserByEmail(email);

            if (user != null && user.getPassword().equals(password)) {

                HttpSession session = req.getSession();

                session.setAttribute("user", user);

                if (returnUrl != null
                        && !returnUrl.isBlank()
                        && returnUrl.startsWith(req.getContextPath())
                        && !returnUrl.startsWith(req.getContextPath() + "//")) {

                    resp.sendRedirect(returnUrl);

                } else {

                    resp.sendRedirect(req.getContextPath() + "/restaurant");
                }

            } else {

                req.setAttribute("error", "Invalid email or password.");
                req.setAttribute("returnUrl", returnUrl);

                req.getRequestDispatcher("Login.jsp")
                   .forward(req, resp);
            }

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("error", "Something went wrong. Please try again.");
            req.setAttribute("returnUrl", returnUrl);

            req.getRequestDispatcher("Login.jsp")
               .forward(req, resp);
        }
    }
}