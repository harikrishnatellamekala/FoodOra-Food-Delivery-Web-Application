package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {

            // =====================================================
            // ADD TO CART
            // =====================================================

            if ("add".equals(action)) {

                int menuId =
                        Integer.parseInt(
                                req.getParameter("menuId")
                        );

                MenuDaoImpl menuDao =
                        new MenuDaoImpl();

                Menu menu =
                        menuDao.getMenu(menuId);

                if (menu != null && menu.isAvailable()) {

                    HttpSession session =
                            req.getSession();

                    Cart cart =
                            (Cart) session.getAttribute("cart");

                    if (cart == null) {

                        cart = new Cart();

                        session.setAttribute(
                                "cart",
                                cart
                        );
                    }

                    boolean added =
                            cart.addItem(menu);

                    if (added) {

                        updateCartCount(
                                session,
                                cart
                        );

                        resp.sendRedirect(
                                req.getContextPath()
                                + "/menu?restaurantId="
                                + menu.getRestaurantId()
                                + "#menu-item-"
                                + menu.getMenuId()
                        );

                    } else {

                        session.setAttribute(
                                "cartError",
                                "You can add items only from the same restaurant."
                        );

                        resp.sendRedirect(
                                req.getContextPath()
                                + "/menu?restaurantId="
                                + menu.getRestaurantId()
                        );
                    }

                } else {

                    resp.sendRedirect(
                            req.getContextPath()
                            + "/restaurant"
                    );
                }
            }


            // =====================================================
            // UPDATE QUANTITY
            // =====================================================

            else if ("update".equals(action)) {

                int menuId =
                        Integer.parseInt(
                                req.getParameter("menuId")
                        );

                int quantity =
                        Integer.parseInt(
                                req.getParameter("quantity")
                        );

                String source =
                        req.getParameter("source");

                HttpSession session =
                        req.getSession();

                Cart cart =
                        (Cart) session.getAttribute("cart");

                if (cart != null) {

                    cart.updateQuantity(
                            menuId,
                            quantity
                    );

                    session.setAttribute(
                            "cart",
                            cart
                    );

                    updateCartCount(
                            session,
                            cart
                    );
                }


                // FROM MENU

                if ("menu".equals(source)) {

                    String restaurantId =
                            req.getParameter("restaurantId");

                    resp.sendRedirect(
                            req.getContextPath()
                            + "/menu?restaurantId="
                            + restaurantId
                            + "#menu-item-"
                            + menuId
                    );
                }


                // FROM CART

                else {

                    resp.sendRedirect(
                            req.getContextPath()
                            + "/cart#cart-item-"
                            + menuId
                    );
                }
            }


            // =====================================================
            // REMOVE
            // =====================================================

            else if ("remove".equals(action)) {

                int menuId =
                        Integer.parseInt(
                                req.getParameter("menuId")
                        );

                String source =
                        req.getParameter("source");

                String restaurantId =
                        req.getParameter("restaurantId");

                HttpSession session =
                        req.getSession();

                Cart cart =
                        (Cart) session.getAttribute("cart");

                if (cart != null) {

                    cart.removeItem(menuId);

                    session.setAttribute(
                            "cart",
                            cart
                    );

                    updateCartCount(
                            session,
                            cart
                    );
                }


                if ("menu".equals(source)) {

                    resp.sendRedirect(
                            req.getContextPath()
                            + "/menu?restaurantId="
                            + restaurantId
                    );

                } else {

                    resp.sendRedirect(
                            req.getContextPath()
                            + "/cart"
                    );
                }
            }


            // =====================================================
            // CLEAR CART
            // =====================================================

            else if ("clear".equals(action)) {

                HttpSession session =
                        req.getSession();

                Cart cart =
                        (Cart) session.getAttribute("cart");

                if (cart != null) {

                    cart.clearCart();

                    session.setAttribute(
                            "cart",
                            cart
                    );
                }

                session.setAttribute(
                        "count",
                        0
                );

                resp.sendRedirect(
                        req.getContextPath()
                        + "/cart"
                );
            }


            // =====================================================
            // INVALID ACTION
            // =====================================================

            else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/cart"
                );
            }

        } catch (NumberFormatException e) {

            resp.sendRedirect(
                    req.getContextPath()
                    + "/cart"
            );
        }
    }


    // =============================================================
    // UPDATE CART COUNT
    // =============================================================

    private void updateCartCount(HttpSession session,
                                 Cart cart) {

        int count = 0;

        for (CartItem item :
             cart.getItems().values()) {

            count += item.getQuantity();
        }

        session.setAttribute(
                "count",
                count
        );
    }


    // =============================================================
    // OPEN CART
    // =============================================================

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        RequestDispatcher rd =
                req.getRequestDispatcher("Cart.jsp");

        rd.forward(req, resp);
    }
}