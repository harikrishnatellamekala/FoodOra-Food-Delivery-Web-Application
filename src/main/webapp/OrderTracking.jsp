<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List,com.tap.model.Order,com.tap.model.CartItem" %>

<%
    String ctx = request.getContextPath();

    Order order = (Order) session.getAttribute("trackingOrder");

    List<CartItem> trackingItems =
        (List<CartItem>) session.getAttribute("trackingItems");

    Double itemTotal =
        (Double) session.getAttribute("trackingItemTotal");

    Double deliveryFee =
        (Double) session.getAttribute("trackingDeliveryFee");

    Double platformFee =
        (Double) session.getAttribute("trackingPlatformFee");

    Double grandTotal =
        (Double) session.getAttribute("trackingGrandTotal");

    if (order == null || trackingItems == null) {
        response.sendRedirect(ctx + "/restaurant");
        return;
    }

    if (itemTotal == null) itemTotal = 0.0;
    if (deliveryFee == null) deliveryFee = 40.0;
    if (platformFee == null) platformFee = 5.0;
    if (grandTotal == null) {
        grandTotal = itemTotal + deliveryFee + platformFee;
    }

    String status = order.getStatus() == null
        ? "PLACED" : order.getStatus().toUpperCase();

    String paymentMode = order.getPaymentMode() == null
        ? "COD" : order.getPaymentMode();

    String paymentLabel = paymentMode;

    if ("COD".equals(paymentMode)) {
        paymentLabel = "Cash on Delivery";
    } else if ("UPI".equals(paymentMode)) {
        paymentLabel = "UPI";
    } else if ("CARD".equals(paymentMode)) {
        paymentLabel = "Credit / Debit Card";
    }

    int currentStep = 1;

    if ("CONFIRMED".equals(status)) currentStep = 1;
    else if ("PREPARING".equals(status)) currentStep = 2;
    else if ("OUT_FOR_DELIVERY".equals(status)) currentStep = 3;
    else if ("DELIVERED".equals(status)) currentStep = 4;

    String displayStatus = status.replace("_", " ");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Tracking | FoodOra</title>
    <link rel="stylesheet" href="<%= ctx %>/OrderTracking.css">
</head>

<body>

<jsp:include page="/Navbar.jsp" />

<main class="page-container">

    <section class="success-banner">
        <div class="success-icon">&#10003;</div>

        <div class="success-content">
            <p class="eyebrow">ORDER CONFIRMED</p>
            <h1>Your food is on the way!</h1>
            <p>
                Thank you for ordering with FoodOra.
                Sit back and enjoy your meal.
            </p>
        </div>
    </section>

    <section class="tracking-card">

        <div class="order-summary">

            <div class="summary-item">
                <span class="summary-label">ORDER ID</span>
                <strong>FO<%= order.getOrderId() %></strong>
            </div>

            <div class="summary-item">
                <span class="summary-label">PAYMENT</span>
                <strong><%= paymentLabel %></strong>
            </div>

            <div class="summary-item">
                <span class="summary-label">STATUS</span>
                <span class="status-badge">
                    <%= displayStatus %>
                </span>
            </div>

        </div>

        <div class="tracking-timeline">

            <div class="timeline-step <%= currentStep >= 1 ? "completed" : "" %>">
                <div class="step-circle">
                    <% if (currentStep >= 1) { %>
                        &#10003;
                    <% } else { %>
                        1
                    <% } %>
                </div>
                <span>Order Placed</span>
            </div>

            <div class="timeline-line <%= currentStep >= 2 ? "line-completed" : "" %>"></div>

            <div class="timeline-step <%= currentStep >= 2 ? "completed" : "" %>">
                <div class="step-circle">2</div>
                <span>Preparing</span>
            </div>

            <div class="timeline-line <%= currentStep >= 3 ? "line-completed" : "" %>"></div>

            <div class="timeline-step <%= currentStep >= 3 ? "completed" : "" %>">
                <div class="step-circle">3</div>
                <span>Out for Delivery</span>
            </div>

            <div class="timeline-line <%= currentStep >= 4 ? "line-completed" : "" %>"></div>

            <div class="timeline-step <%= currentStep >= 4 ? "completed" : "" %>">
                <div class="step-circle">4</div>
                <span>Delivered</span>
            </div>

        </div>

        <section class="order-items-section">

            <div class="section-heading">
                <div>
                    <p class="eyebrow">YOUR ORDER</p>
                    <h2>Order Items</h2>
                </div>

                <span class="item-count">
                    <%= trackingItems.size() %>
                    <%= trackingItems.size() == 1 ? "item" : "items" %>
                </span>
            </div>

            <div class="ordered-items">

                <% for (CartItem cartItem : trackingItems) {
                    if (cartItem == null || cartItem.getMenu() == null) {
                        continue;
                    }

                    String imagePath = cartItem.getMenu().getImagePath();

                    if (imagePath == null || imagePath.trim().isEmpty()) {
                        imagePath = "images/food-placeholder.jpg";
                    } else if (!imagePath.startsWith("http://")
                            && !imagePath.startsWith("https://")
                            && !imagePath.startsWith("/")) {
                        imagePath = ctx + "/" + imagePath;
                    }
                %>

                <article class="ordered-item">

                    <img
                        class="food-image"
                        src="<%= imagePath %>"
                        alt="<%= cartItem.getMenu().getItemName() %>"
                        onerror="this.style.display='none';">

                    <div class="food-details">
                        <h3><%= cartItem.getMenu().getItemName() %></h3>

                        <p>
                            <%= cartItem.getMenu().getDescription() == null
                                ? "" : cartItem.getMenu().getDescription() %>
                        </p>
                    </div>

                    <span class="quantity">
                        &times; <%= cartItem.getQuantity() %>
                    </span>

                    <strong class="item-price">
                        &#8377;<%= String.format("%.0f", cartItem.getSubtotal()) %>
                    </strong>

                </article>

                <% } %>

            </div>
        </section>

        <section class="bill-section">
            <h2>Bill Details</h2>

            <div class="bill-row">
                <span>Item Total</span>
                <strong>&#8377;<%= String.format("%.2f", itemTotal) %></strong>
            </div>

            <div class="bill-row">
                <span>Delivery Fee</span>
                <strong>&#8377;<%= String.format("%.2f", deliveryFee) %></strong>
            </div>

            <div class="bill-row">
                <span>Platform Fee</span>
                <strong>&#8377;<%= String.format("%.2f", platformFee) %></strong>
            </div>

            <div class="bill-divider"></div>

            <div class="bill-row grand-total">
                <span>Grand Total</span>
                <strong>&#8377;<%= String.format("%.2f", grandTotal) %></strong>
            </div>
        </section>

        <div class="action-buttons">
            <a class="primary-button" href="<%= request.getContextPath() %>/restaurant">
                Order More Food
            </a>
            
          

            <a class="secondary-button" href="<%= ctx %>/index.jsp">
                Back to Home
            </a>
        </div>

    </section>

</main>

</body>
</html>