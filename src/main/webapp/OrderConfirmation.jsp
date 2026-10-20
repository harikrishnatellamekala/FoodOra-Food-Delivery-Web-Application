
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tap.model.Order" %>

<%
    String ctx = request.getContextPath();

    Order order = (Order) request.getAttribute("order");

    if (order == null) {
        response.sendRedirect(ctx + "/restaurant");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodora | Order Confirmed</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f8fa;
            color: #222;
        }

        .navbar {
            background: white;
            padding: 18px 7%;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
        }

        .logo {
            color: #e23744;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
        }

        .logo span {
            color: #222;
        }

        .confirmation-container {
            max-width: 620px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .confirmation-card {
            background: white;
            padding: 40px 30px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.06);
        }

        .success-icon {
            width: 75px;
            height: 75px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #e5f8eb;
            color: #239b56;
            font-size: 42px;
            line-height: 75px;
        }

        h1 {
            margin-bottom: 12px;
            font-size: 30px;
        }

        .subtitle {
            color: #666;
            line-height: 1.6;
        }

        .order-details {
            margin-top: 30px;
            padding: 20px;
            background: #fafafa;
            border-radius: 10px;
            text-align: left;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 13px 0;
            border-bottom: 1px solid #eee;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-row span {
            color: #666;
        }

        .detail-row strong {
            text-align: right;
            overflow-wrap: anywhere;
        }

        .status {
            color: #239b56;
        }

        .total {
            font-size: 19px;
        }

        .home-button {
            display: inline-block;
            margin-top: 28px;
            padding: 14px 25px;
            background: #e23744;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .home-button:hover {
            background: #c92534;
        }

        @media (max-width: 480px) {
            .confirmation-container {
                margin: 30px auto;
            }

            .confirmation-card {
                padding: 30px 20px;
            }

            h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

    <header class="navbar">
        <a href="<%= ctx %>/restaurant" class="logo">
            FO<span>odora</span>
        </a>
    </header>

    <main class="confirmation-container">

        <section class="confirmation-card">

            <div class="success-icon">&#10003;</div>

            <h1>Order Confirmed!</h1>

            <p class="subtitle">
                Thank you for ordering with Foodora.
                Your order has been placed successfully.
            </p>

            <div class="order-details">

                <div class="detail-row">
                    <span>Order ID</span>
                    <strong>#<%= order.getOrderId() %></strong>
                </div>

                <div class="detail-row">
                    <span>Order Status</span>
                    <strong class="status">
                        <%= order.getStatus() %>
                    </strong>
                </div>

                <div class="detail-row">
                    <span>Payment Method</span>
                    <strong>
                        <%= order.getPaymentMode() %>
                    </strong>
                </div>

                <div class="detail-row total">
                    <span>Total Amount</span>
                    <strong>
                        &#8377;<%= String.format("%.2f",
                            order.getTotalAmount()) %>
                    </strong>
                </div>

            </div>

            <a href="<%= ctx %>/restaurant" class="home-button">
                Continue Shopping
            </a>

        </section>

    </main>

</body>
</html>
