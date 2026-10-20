<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodora | Restaurants</title>

    <!-- Inter Font -->
    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <!-- Existing Restaurant CSS -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/restaurants.css">

</head>


<body>


<!-- =====================================================
     NAVBAR
===================================================== -->

<jsp:include page="/Navbar.jsp" />
<!-- =====================================================
     MOBILE NAVIGATION
===================================================== -->

<div class="mobile-nav"
     id="mobileNav">

    <a href="index.jsp">
        Home
    </a>

    <a href="restaurant">
        Restaurants
    </a>

    <a href="myOrders">
        My Orders
    </a>

    <a href="login.html">
        Login
    </a>

    <a href="cart.html">
        Cart
    </a>

</div>


<!-- =====================================================
     RESTAURANTS
===================================================== -->

<main class="restaurants-page">


    <section class="restaurants-heading">

        <p>
            BENGALURU'S FOOD STOPS
        </p>

        <h1>
            Restaurants
        </h1>

        <span>
            Discover food from some of Bengaluru's
            favourite restaurants.
        </span>

    </section>


    <!-- =================================================
         RESTAURANT LIST
    ================================================== -->

    <section class="restaurant-list">


        <%

            List<Restaurant> restaurants =
                (List<Restaurant>) request.getAttribute("restaurants");

            if (restaurants != null && !restaurants.isEmpty()) {

                for (Restaurant restaurant : restaurants) {

        %>


        <!-- =================================================
             RESTAURANT CARD
        ================================================== -->

        <article class="restaurant-card"
                 data-restaurant-id="<%= restaurant.getRestaurantId() %>">


            <!-- RESTAURANT IMAGE -->

            <div class="restaurant-photo">

                <img src="<%= request.getContextPath() %>/<%= restaurant.getImagePath() %>"
                     alt="<%= restaurant.getName() %>">

                <span class="delivery">

                    <%= restaurant.getDeliveryTime() %> min

                </span>

            </div>


            <!-- RESTAURANT CONTENT -->

            <div class="restaurant-content">


                <div class="restaurant-main">

                    <h2>
                        <%= restaurant.getName() %>
                    </h2>

                    <p class="restaurant-type">

                        <%= restaurant.getCuisineType() %>

                    </p>

                    <p class="restaurant-location">

                        <%= restaurant.getAddress() %>

                    </p>

                </div>


                <!-- RATING + VIEW MENU -->

                <div class="restaurant-side">


                    <span class="rating">

                        ★ <%= restaurant.getRating() %>

                    </span>


                    <!-- VIEW MENU BUTTON -->

                    <a href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>"
                       class="view-menu">

                        View Menu

                    </a>


                </div>


            </div>

        </article>


        <%

                }

            } else {

        %>


            <p>
                No restaurants available.
            </p>


        <%

            }

        %>


    </section>

</main>


<!-- =====================================================
     FOOTER
===================================================== -->

<footer class="footer">

    <div class="footer-container">


        <div class="footer-brand">


            <a href="index.jsp"
               class="footer-logo">

                <span class="logo-mark">
                    FO
                </span>

                <span class="logo-text">
                    Food<span>Ora</span>
                </span>

            </a>


            <p>

                Delicious food from your favourite
                restaurants, delivered to your door.

            </p>

        </div>


        <div class="footer-column">

            <h4>
                Quick Links
            </h4>

            <a href="index.jsp">
                Home
            </a>

            <a href="restaurant">
                Restaurants
            </a>

            <a href="myOrders">
                My Orders
            </a>

            <a href="cart.html">
                Cart
            </a>

        </div>


        <div class="footer-column">

            <h4>
                Customer
            </h4>

            <a href="#">
                Help & Support
            </a>

            <a href="#">
                Contact Us
            </a>

            <a href="#">
                Privacy
            </a>

            <a href="#">
                Terms
            </a>

        </div>


        <div class="footer-column">

            <h4>
                Account
            </h4>

            <a href="login.html">
                Login
            </a>

            <a href="register.html">
                Register
            </a>

            <a href="myOrders">
                Orders
            </a>

            <a href="cart.html">
                Cart
            </a>

        </div>

    </div>


    <div class="footer-bottom">

        © 2026 FoodOra . All rights reserved.

    </div>

</footer>


<!-- =====================================================
     JAVASCRIPT
===================================================== -->

<script>

    const mobileMenu =
        document.getElementById("mobileMenu");

    const mobileNav =
        document.getElementById("mobileNav");


    mobileMenu.addEventListener("click", function () {

        mobileNav.classList.toggle("show");

    });


    const restaurants =
        document.querySelectorAll(".restaurant-card");


    restaurants.forEach(function (restaurant) {

        restaurant.addEventListener("click", function () {

            const restaurantId =
                restaurant.dataset.restaurantId;

            window.location.href =
                "menu?restaurantId=" + restaurantId;

        });

    });

</script>


</body>

</html>