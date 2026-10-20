<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.OrderItem" %>

<%
    String ctx = request.getContextPath();
	
	if (request.getAttribute("loggedIn") == null) {
    	response.sendRedirect(ctx + "/myOrders");
    	return;
	}


    Boolean loggedInAttr = (Boolean) request.getAttribute("loggedIn");
    boolean loggedIn = loggedInAttr != null && loggedInAttr;

    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Map<Integer, List<OrderItem>> itemsByOrder =
        (Map<Integer, List<OrderItem>>) request.getAttribute("itemsByOrder");
    Map<Integer, String> menuNames =
        (Map<Integer, String>) request.getAttribute("menuNames");
    Map<Integer, String> restaurantNames =
        (Map<Integer, String>) request.getAttribute("restaurantNames");

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodora | My Orders</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f8fa;
            color: #222;
        }

        .page-container {
            max-width: 950px;
            margin: 45px auto;
            padding: 0 20px;
        }

        h1 { margin-bottom: 8px; }

        .subtitle {
            color: #666;
            margin-bottom: 28px;
        }

        .order-card {
            background: white;
            padding: 24px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            flex-wrap: wrap;
            padding-bottom: 18px;
            border-bottom: 1px solid #eee;
        }

        .order-id { font-size: 18px; font-weight: bold; }

        .order-date {
            color: #777;
            font-size: 14px;
            margin-top: 7px;
        }

        .status {
            display: inline-block;
            padding: 7px 12px;
            border-radius: 20px;
            background: #e5f8eb;
            color: #218746;
            font-size: 13px;
            font-weight: bold;
        }

        .order-items {
            padding: 16px 0;
            border-bottom: 1px solid #eee;
        }

        .order-items h4 {
            margin: 0 0 10px;
            font-size: 14px;
            color: #777;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            padding: 6px 0;
            font-size: 15px;
        }

        .item-row span:last-child { font-weight: bold; }

        .order-details {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
            padding-top: 20px;
        }

        .detail-label {
            color: #777;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .detail-value {
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        .order-total {
            color: #d86e2c;
            font-size: 19px;
        }

        .empty-state {
            text-align: center;
            background: white;
            padding: 45px 20px;
            border-radius: 12px;
        }

        .empty-state p {
            color: #666;
            line-height: 1.6;
        }

        .shop-button {
            display: inline-block;
            margin-top: 15px;
            padding: 13px 22px;
            background: #d86e2c;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            .page-container { margin: 30px auto; }

            .order-details {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }
    </style>
</head>

<body>

    <jsp:include page="/Navbar.jsp" />

    <main class="page-container">

        <h1>My Orders</h1>

        <p class="subtitle">View your Foodora order history.</p>

        <% if (!loggedIn) { %>

            <section class="empty-state">
                <h2>Please login</h2>
                <p>Please login to see your orders.</p>
                <a href="<%= ctx %>/login?returnUrl=<%= ctx %>/myOrders"
                   class="shop-button">Login</a>
            </section>

        <% } else if (orders == null || orders.isEmpty()) { %>

            <section class="empty-state">
                <h2>No orders yet!</h2>
                <p>
                    You haven't placed any orders.
                    Explore restaurants and order your favourite food.
                </p>
                <a href="<%= ctx %>/restaurant" class="shop-button">
                    Explore Restaurants
                </a>
            </section>

        <% } else { %>

            <% for (Order order : orders) {

                List<OrderItem> items = itemsByOrder == null
                        ? null : itemsByOrder.get(order.getOrderId());

                String restaurantName = restaurantNames == null
                        ? null : restaurantNames.get(order.getRestaurantId());
            %>

                <section class="order-card">

                    <div class="order-header">
                        <div>
                            <div class="order-id">
                                Order #<%= order.getOrderId() %>
                            </div>
                            <div class="order-date">
                                <%= order.getOrderDate() == null
                                    ? "Date unavailable"
                                    : dateFormat.format(order.getOrderDate()) %>
                            </div>
                        </div>

                        <span class="status">
                            <%= order.getStatus() == null
                                ? "Unknown" : order.getStatus() %>
                        </span>
                    </div>

                    <% if (items != null && !items.isEmpty()) { %>
                        <div class="order-items">
                            <h4>Items</h4>
                            <% for (OrderItem item : items) {
                                String itemName = menuNames == null
                                    ? null : menuNames.get(item.getMenuId());
                            %>
                                <div class="item-row">
                                    <span><%= itemName == null
                                        ? "Item #" + item.getMenuId()
                                        : itemName %></span>
                                    <span>&#8377;<%= String.format("%.2f",
                                        item.getTotalAmount()) %></span>
                                </div>
                            <% } %>
                        </div>
                    <% } %>

                    <div class="order-details">
                        <div>
                            <div class="detail-label">Restaurant</div>
                            <div class="detail-value">
                                <%= restaurantName == null
                                    ? "#" + order.getRestaurantId()
                                    : restaurantName %>
                            </div>
                        </div>

                        <div>
                            <div class="detail-label">Payment Method</div>
                            <div class="detail-value">
                                <%= order.getPaymentMode() == null
                                    ? "Not available"
                                    : order.getPaymentMode() %>
                            </div>
                        </div>

                        <div>
                            <div class="detail-label">Total Amount</div>
                            <div class="detail-value order-total">
                                &#8377;<%= String.format("%.2f",
                                    order.getTotalAmount()) %>
                            </div>
                        </div>
                    </div>

                </section>

            <% } %>

        <% } %>

    </main>

</body>
</html>