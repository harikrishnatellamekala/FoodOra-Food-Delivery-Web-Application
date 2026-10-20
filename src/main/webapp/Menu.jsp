<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="java.util.List"%>

<%!
    /* Trash icon (shown instead of "-" when quantity is 1) */
    private static final String TRASH_ICON =
        "<svg viewBox=\"0 0 24 24\" width=\"16\" height=\"16\" fill=\"none\" "
      + "stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" "
      + "stroke-linejoin=\"round\" aria-hidden=\"true\">"
      + "<path d=\"M3 6h18\"/><path d=\"M8 6V4h8v2\"/>"
      + "<path d=\"M19 6l-1 14H6L5 6\"/><path d=\"M10 11v6M14 11v6\"/></svg>";

    /* 120.0 -> 120   |   120.5 -> 120.50 */
    private static String money(double v) {
        if (v == Math.rint(v)) {
            return String.valueOf((long) v);
        }
        return String.format("%.2f", v);
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodora | Menu</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/menu.css">

</head>


<body>

<%
    String ctx = request.getContextPath();

    /* Restaurant + menu list come from MenuController */
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<Menu> menusByRestaurant = (List<Menu>) request.getAttribute("menu");

    /* Session cart */
    Cart cart = (Cart) session.getAttribute("cart");

    int cartCount = 0;

    if (cart != null) {
        for (CartItem ci : cart.getItems().values()) {
            cartCount += ci.getQuantity();
        }
    }

    /* One-time error (e.g. items from another restaurant) */
    String cartError = (String) session.getAttribute("cartError");

    if (cartError != null) {
        session.removeAttribute("cartError");
    }
%>


<!-- =========================================================
     NAVBAR
========================================================= -->

<jsp:include page="/Navbar.jsp" />

<!-- =========================================================
     MAIN MENU PAGE
========================================================= -->

<main class="menu-page">

    <a href="<%= ctx %>/restaurant" class="back-button">
        &larr; Back to Restaurants
    </a>


    <!-- ================= RESTAURANT HEADER ================= -->

    <section class="restaurant-header">

        <div class="restaurant-cover">
            <img src="<%= ctx %>/<%= restaurant.getImagePath() %>"
                 alt="<%= restaurant.getName() %>">
        </div>

        <div class="restaurant-info">

            <p class="restaurant-label">RESTAURANT</p>

            <h1><%= restaurant.getName() %></h1>

            <p><%= restaurant.getAddress() %></p>

            <div class="restaurant-meta">
                <span>&#9733; <%= restaurant.getRating() %></span>
                <span>&bull;</span>
                <span><%= restaurant.getDeliveryTime() %> min</span>
            </div>

        </div>

    </section>


    <!-- ================= MENU HEADING ================= -->

    <section class="menu-heading">

        <p>OUR MENU</p>

        <h2>Popular dishes</h2>

        <span>Choose your favourites and add them to your cart.</span>

    </section>


    <!-- ================= MENU GRID ================= -->

    <section class="menu-grid">

        <%
            if (menusByRestaurant != null && !menusByRestaurant.isEmpty()) {

                for (Menu menu : menusByRestaurant) {

                    /* 0 = item is not in the cart */
                    int quantity = 0;

                    if (cart != null) {

                        CartItem cartItem =
                                cart.getItems().get(menu.getMenuId());

                        if (cartItem != null) {
                            quantity = cartItem.getQuantity();
                        }
                    }

                    /*
                     * quantity == 1  -> left button is DELETE (trash)
                     * quantity  > 1  -> left button is MINUS
                     */
                    String minusAction = (quantity == 1) ? "remove" : "update";
        %>

        <article class="food-card"
                 id="menu-item-<%= menu.getMenuId() %>">

            <div class="food-image">
                <img src="<%= ctx %>/<%= menu.getImagePath() %>"
                     alt="<%= menu.getItemName() %>">
            </div>


            <div class="food-info">

                <h3><%= menu.getItemName() %></h3>

                <p class="food-description">
                    <%= menu.getDescription() != null
                            ? menu.getDescription()
                            : "Delicious " + menu.getItemName()
                              + " prepared specially for you." %>
                </p>


                <div class="food-bottom">

                    <strong class="food-price">
                        &#8377;<%= money(menu.getPrice()) %>
                    </strong>


                    <!-- ===== THIS SLOT IS UPDATED WITHOUT PAGE RELOAD ===== -->
                    <div class="qty-slot">

                    <% if (quantity == 0) { %>

                        <!-- STATE 1 : not in cart  ->  [ + ] -->

                        <form action="<%= ctx %>/cart" method="post"
                              class="js-cart-form">

                            <input type="hidden" name="action"       value="add">
                            <input type="hidden" name="menuId"       value="<%= menu.getMenuId() %>">
                            <input type="hidden" name="source"       value="menu">
                            <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">

                            <button type="submit" class="add-button"
                                    aria-label="Add <%= menu.getItemName() %>">+</button>

                        </form>

                    <% } else { %>

                        <!--
                             STATE 2 : quantity = 1  ->  [ trash | 1 | + ]
                             STATE 3 : quantity > 1  ->  [  -    | 2 | + ]
                        -->

                        <div class="qty-pill">

                            <!-- DELETE / MINUS -->
                            <form action="<%= ctx %>/cart" method="post"
                                  class="js-cart-form">

                                <input type="hidden" name="action"       value="<%= minusAction %>">
                                <input type="hidden" name="menuId"       value="<%= menu.getMenuId() %>">
                                <input type="hidden" name="quantity"     value="<%= quantity - 1 %>">
                                <input type="hidden" name="source"       value="menu">
                                <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">

                                <button type="submit"
                                        class="qty-btn<%= quantity == 1 ? " is-delete" : "" %>"
                                        aria-label="<%= quantity == 1 ? "Remove item" : "Decrease quantity" %>">
                                    <%= quantity == 1 ? TRASH_ICON : "&minus;" %>
                                </button>

                            </form>


                            <span class="qty-num"><%= quantity %></span>


                            <!-- PLUS -->
                            <form action="<%= ctx %>/cart" method="post"
                                  class="js-cart-form">

                                <input type="hidden" name="action"       value="update">
                                <input type="hidden" name="menuId"       value="<%= menu.getMenuId() %>">
                                <input type="hidden" name="quantity"     value="<%= quantity + 1 %>">
                                <input type="hidden" name="source"       value="menu">
                                <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">

                                <button type="submit" class="qty-btn"
                                        aria-label="Increase quantity">+</button>

                            </form>

                        </div>

                    <% } %>

                    </div>
                    <!-- ===== END SLOT ===== -->

                </div>

            </div>

        </article>

        <%
                }

            } else {
        %>

            <div class="empty-menu">
                No menu items available for this restaurant.
            </div>

        <%
            }
        %>

    </section>

</main>


<!-- =========================================================
     FOOTER
========================================================= -->

<footer class="footer">

    <div class="footer-container">

        <div class="footer-brand">

            <a href="index.jsp" class="footer-logo">
                <span class="logo-mark">FO</span>
                <span class="logo-text">Food<span>ora</span></span>
            </a>

            <p>
                Delicious food from your favourite
                restaurants, delivered to your door.
            </p>

        </div>


        <div class="footer-column">
            <h4>Quick Links</h4>
            <a href="index.jsp">Home</a>
            <a href="<%= ctx %>/restaurant">Restaurants</a>
            <a href="myOrders">My Orders</a>
            <a href="<%= ctx %>/cart">Cart</a>
        </div>


        <div class="footer-column">
            <h4>Customer</h4>
            <a href="#">Help &amp; Support</a>
            <a href="#">Contact Us</a>
            <a href="#">Privacy</a>
            <a href="#">Terms</a>
        </div>


        <div class="footer-column">
            <h4>Account</h4>
            <a href="login.html">Login</a>
            <a href="register.html">Register</a>
            <a href="myOrders">Orders</a>
            <a href="<%= ctx %>/cart">Cart</a>
        </div>

    </div>

    <div class="footer-bottom">
        &copy; 2026 Foodora. All rights reserved.
    </div>

</footer>


<!-- =========================================================
     SCRIPT
     1. Mobile menu toggle
     2. + / - / delete WITHOUT page reload (page never jumps)
     3. Toast auto-hide
========================================================= -->

<script>
(function () {

    /* ---------- mobile menu ---------- */

    var burger = document.getElementById("mobileMenu");
    var mobileNav = document.getElementById("mobileNav");

    if (burger && mobileNav) {
        burger.addEventListener("click", function () {
            mobileNav.classList.toggle("show");
        });
    }


    /* ---------- toast ---------- */

    function armToast() {
        var t = document.querySelector("#toast-holder .toast");
        if (!t) { return; }
        setTimeout(function () {
            t.classList.add("hide");
            setTimeout(function () { t.remove(); }, 400);
        }, 3500);
    }

    armToast();


    /* ---------- AJAX cart ---------- */

    var busy = false;

    document.addEventListener("submit", function (e) {

        var form = e.target;

        if (!form.classList || !form.classList.contains("js-cart-form")) {
            return;
        }

        e.preventDefault();

        if (busy) { return; }           // ignore double clicks while saving
        busy = true;

        var card = form.closest(".food-card");
        if (card) { card.classList.add("is-loading"); }

        /*
         * POST to /cart. The servlet answers with a redirect back to the
         * menu page; fetch follows it and gives us the fresh HTML.
         * We copy only the pieces that changed, so nothing reloads.
         */
        fetch(form.action, {
            method: "POST",
            body: new URLSearchParams(new FormData(form)),
            credentials: "same-origin",
            cache: "no-store"
        })
        .then(function (res) {
            if (!res.ok) { throw new Error("HTTP " + res.status); }
            return res.text();
        })
        .then(function (html) {

            var doc = new DOMParser().parseFromString(html, "text/html");

            if (!doc.querySelector(".menu-grid")) {
                throw new Error("Unexpected response");
            }

            /* 1. every card's button area (covers all changes) */
            doc.querySelectorAll(".food-card").forEach(function (freshCard) {

                var current = document.getElementById(freshCard.id);
                if (!current) { return; }

                var oldSlot = current.querySelector(".qty-slot");
                var newSlot = freshCard.querySelector(".qty-slot");

                if (oldSlot && newSlot &&
                    oldSlot.innerHTML.trim() !== newSlot.innerHTML.trim()) {

                    oldSlot.innerHTML = newSlot.innerHTML;
                    oldSlot.classList.remove("updated");
                    void oldSlot.offsetWidth;          // restart animation
                    oldSlot.classList.add("updated");
                }
            });

            /* 2. cart count in navbar */
            var freshNav = doc.querySelector(".nav-actions");
            var nav = document.querySelector(".nav-actions");
            if (freshNav && nav) { nav.innerHTML = freshNav.innerHTML; }

            /* 3. toast (different restaurant, etc.) */
            var freshToast = doc.getElementById("toast-holder");
            var toast = document.getElementById("toast-holder");
            if (freshToast && toast) {
                toast.innerHTML = freshToast.innerHTML;
                armToast();
            }
        })
        .catch(function () {
            /* anything went wrong -> normal form submit as a safety net */
            form.submit();
        })
        .finally(function () {
            busy = false;
            if (card) { card.classList.remove("is-loading"); }
        });
    });

})();
</script>


</body>

</html>
