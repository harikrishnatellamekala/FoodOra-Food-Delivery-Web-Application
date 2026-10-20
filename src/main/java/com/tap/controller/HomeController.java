package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private MenuDaoImpl menuDao;

    @Override
    public void init() {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String itemName = req.getParameter("itemName");

        try {
            Menu menu = null;

            if (itemName != null && !itemName.trim().isEmpty()) {
                menu = menuDao.getMenuByItemName(itemName);
            } else {
                String menuIdParam = req.getParameter("menuId");

                if (menuIdParam != null) {
                    int menuId = Integer.parseInt(menuIdParam);
                    menu = menuDao.getMenu(menuId);
                }
            }

            if (menu == null) {
                resp.sendRedirect(req.getContextPath() + "/restaurant");
                return;
            }

            resp.sendRedirect(
                req.getContextPath()
                + "/menu?restaurantId="
                + menu.getRestaurantId()
                + "#menu-item-"
                + menu.getMenuId()
            );

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/restaurant");
        }
    }
}