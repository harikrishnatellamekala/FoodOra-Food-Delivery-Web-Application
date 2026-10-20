package com.tap.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.tap.dao.OrderDao;
import com.tap.dao.UserDao;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDao userDao;
    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String ctx = req.getContextPath();
        HttpSession session = req.getSession(false);

        if (session == null || !(session.getAttribute("user") instanceof User)) {
            resp.sendRedirect(ctx + "/login?returnUrl="
                    + URLEncoder.encode(ctx + "/profile", StandardCharsets.UTF_8));
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // get fresh details from the database
        User profileUser = userDao.getUser(sessionUser.getUserId());

        if (profileUser == null) {
            profileUser = sessionUser;
        }

        int orderCount = orderDao.getOrdersByUser(sessionUser.getUserId()).size();

        req.setAttribute("profileUser", profileUser);
        req.setAttribute("orderCount", orderCount);

        req.getRequestDispatcher("/Profile.jsp").forward(req, resp);
    }
}