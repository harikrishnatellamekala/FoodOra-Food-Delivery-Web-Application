package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String returnUrl = req.getParameter("returnUrl");

        req.setAttribute("returnUrl", returnUrl);

        req.getRequestDispatcher("Register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        String returnUrl = req.getParameter("returnUrl");

        try {

            UserDaoImpl userDao = new UserDaoImpl();

            User existingUser = userDao.getUserByEmail(email);

            if (existingUser != null) {

                req.setAttribute("error", "Email already registered.");
                req.setAttribute("returnUrl", returnUrl);

                req.getRequestDispatcher("Register.jsp")
                   .forward(req, resp);

                return;
            }

            User user = new User();

            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole("USER");

            userDao.addUser(user);

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login?returnUrl="
                    + java.net.URLEncoder.encode(
                            returnUrl == null ? "" : returnUrl,
                            "UTF-8")
                    + "&registered=true"
            );

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("error",
                    "Registration failed. Please try again.");

            req.setAttribute("returnUrl", returnUrl);

            req.getRequestDispatcher("Register.jsp")
               .forward(req, resp);
        }
    }
}