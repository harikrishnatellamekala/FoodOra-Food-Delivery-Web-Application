package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.daoImpl.RestaurantDaoImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        int restaurantId =
                Integer.parseInt(
                        req.getParameter("restaurantId")
                );

        RestaurantDaoImpl restaurantDao =
                new RestaurantDaoImpl();

        MenuDaoImpl menuDao =
                new MenuDaoImpl();

        Restaurant restaurant =
                restaurantDao.getRestaurant(
                        restaurantId
                );

        List<Menu> menusByRestaurant =
                menuDao.getMenusByRestaurant(
                        restaurantId
                );

        req.setAttribute(
                "restaurant",
                restaurant
        );

        req.setAttribute(
                "menu",
                menusByRestaurant
        );

        RequestDispatcher rd =
                req.getRequestDispatcher(
                        "Menu.jsp"
                );

        rd.forward(req, resp);
    }
}