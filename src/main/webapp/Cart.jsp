<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="java.util.Map"%>

<%!
    /* Trash icon (shown instead of "-" when quantity is 1) */
    private static final String TRASH_ICON =
        "<svg viewBox=\"0 0 24 24\" width=\"17\" height=\"17\" fill=\"none\" "
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

    <title>Foodora | Cart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/Cart.css">

</head>


<body>

<%
    String ctx = request.getContextPath();

    Cart cart = (Cart) session.getAttribute("cart");

    boolean hasItems =
            cart != null
            && cart.getItems() != null
            && !cart.getItems().isEmpty();

    int cartCount = 0;

    if (hasItems) {
        for (CartItem ci : cart.getItems().values()) {
            cartCount += ci.getQuantity();
        }
    }

    double itemTotal   = hasItems ? cart.getTotal() : 0;
    double deliveryFee = 40;
    double platformFee = 5;
    double grandTotal  = itemTotal + deliveryFee + platformFee;
%>


<!-- ================= NAVBAR ================= -->

<jsp:include page="/Navbar.jsp" />

<!-- ================= CART ================= -->

<main class="cart-page">

    <div class="cart-container">

        <p class="section-label">YOUR SELECTION</p>

        <h1>Your Cart</h1>

        <p class="cart-subtitle">
            Review your items before placing your order.
        </p>


        <!-- ===== EVERYTHING INSIDE THIS DIV IS REFRESHED WITHOUT RELOAD ===== -->
        <div id="cart-dynamic">

        <% if (hasItems) { %>

        <div class="cart-layout">

            <!-- ================= ITEMS ================= -->

            <section class="cart-items">

                <div class="cart-items-head">

                    <h2>
                        Items
                        <span>(<%= cartCount %>)</span>
                    </h2>

                    <form action="<%= ctx %>/cart" method="post"
                          class="js-cart-form">

                        <input type="hidden" name="action" value="clear">

                        <button type="submit" class="clear-button">
                            Clear cart
                        </button>

                    </form>

                </div>


                <%
                    for (Map.Entry<Integer, CartItem> entry :
                         cart.getItems().entrySet()) {

                        CartItem item = entry.getValue();

                        int menuId     = item.getMenu().getMenuId();
                        int quantity   = item.getQuantity();
                        double subtotal = item.getSubtotal();

                        /*
                         * quantity == 1  -> left button is DELETE (trash)
                         * quantity  > 1  -> left button is MINUS
                         */
                        String minusAction = (quantity == 1) ? "remove" : "update";
                %>

                <article class="cart-item"
                         id="cart-item-<%= menuId %>">

                    <!-- IMAGE -->

                    <div class="cart-image">
                        <img src="<%= ctx %>/<%= item.getMenu().getImagePath() %>"
                             alt="<%= item.getMenu().getItemName() %>">
                    </div>


                    <!-- DETAILS -->

                    <div class="cart-info">

                        <h3><%= item.getMenu().getItemName() %></h3>

                        <p class="cart-description">
                            <%= item.getMenu().getDescription() != null
                                    ? item.getMenu().getDescription()
                                    : "Delicious " + item.getMenu().getItemName()
                                      + " prepared specially for you." %>
                        </p>

                        <p class="cart-price">
                            &#8377;<%= money(item.getMenu().getPrice()) %>
                            <small>each</small>
                        </p>

                    </div>


                    <!-- QUANTITY + SUBTOTAL -->

                    <div class="cart-side">

                        <!--
                             quantity = 1  ->  [ trash | 1 | + ]
                             quantity > 1  ->  [  -    | 2 | + ]
                        -->

                        <div class="qty-pill">

                            <!-- DELETE / MINUS -->
                            <form action="<%= ctx %>/cart" method="post"
                                  class="js-cart-form">

                                <input type="hidden" name="action"   value="<%= minusAction %>">
                                <input type="hidden" name="menuId"   value="<%= menuId %>">
                                <input type="hidden" name="quantity" value="<%= quantity - 1 %>">
                                <input type="hidden" name="source"   value="cart">

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

                                <input type="hidden" name="action"   value="update">
                                <input type="hidden" name="menuId"   value="<%= menuId %>">
                                <input type="hidden" name="quantity" value="<%= quantity + 1 %>">
                                <input type="hidden" name="source"   value="cart">

                                <button type="submit" class="qty-btn"
                                        aria-label="Increase quantity">+</button>

                            </form>

                        </div>


                        <div class="item-subtotal">
                            &#8377;<%= money(subtotal) %>
                        </div>

                    </div>

                </article>

                <%
                    }
                %>

            </section>


            <!-- ================= BILL ================= -->

            <aside class="bill-section">

                <h2>Bill Details</h2>

                <div class="bill-row">
                    <span>Item Total</span>
                    <strong>&#8377;<%= money(itemTotal) %></strong>
                </div>

                <div class="bill-row">
                    <span>Delivery Fee</span>
                    <strong>&#8377;<%= money(deliveryFee) %></strong>
                </div>

                <div class="bill-row">
                    <span>Platform Fee</span>
                    <strong>&#8377;<%= money(platformFee) %></strong>
                </div>

                <div class="bill-divider"></div>

                <div class="bill-total">
                    <span>Total</span>
                    <strong>&#8377;<%= money(grandTotal) %></strong>
                </div>

            
             <a href="<%= ctx %>/proceed"  class="proceed-button">
    			Proceed to Pay
             </a>

            </aside>

        </div>

        <% } else { %>

        <!-- ================= EMPTY CART ================= -->

        <section class="empty-cart">

            <div class="empty-icon">&#128722;</div>

            <h2>Your cart is empty</h2>

            <p>Add some delicious food from our restaurants.</p>

            <a href="<%= ctx %>/restaurant" class="browse-button">
                Browse Restaurants
            </a>

        </section>

        <% } %>

        </div>
        <!-- ===== END DYNAMIC ===== -->

    </div>

</main>


<!-- =========================================================
     + / - / delete / clear  WITHOUT page reload
========================================================= -->

<script>
(function () {

    var busy = false;

    document.addEventListener("submit", function (e) {

        var form = e.target;

        if (!form.classList || !form.classList.contains("js-cart-form")) {
            return;
        }

        e.preventDefault();

        if (busy) { return; }           // ignore double clicks while saving
        busy = true;

        var box = document.getElementById("cart-dynamic");
        if (box) { box.classList.add("is-loading"); }

        /*
         * POST to /cart. The servlet redirects back to /cart, fetch follows
         * it and returns the fresh cart page. We swap only the changed parts.
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

            var freshBox = doc.getElementById("cart-dynamic");
            if (!freshBox || !box) { throw new Error("Unexpected response"); }

            /* items + bill (or empty state) */
            box.innerHTML = freshBox.innerHTML;

            /* navbar cart count */
            var freshNav = doc.querySelector(".nav-actions");
            var nav = document.querySelector(".nav-actions");
            if (freshNav && nav) { nav.innerHTML = freshNav.innerHTML; }
        })
        .catch(function () {
            form.submit();              // safety net: normal submit
        })
        .finally(function () {
            busy = false;
            var b = document.getElementById("cart-dynamic");
            if (b) { b.classList.remove("is-loading"); }
        });
    });

})();
</script>


</body>

</html>
