<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>

<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<%
    String ctx = request.getContextPath();

    Cart cart = (Cart) request.getAttribute("cart");

    Double itemTotalValue =
        (Double) request.getAttribute("itemTotal");
    Double deliveryFeeValue =
        (Double) request.getAttribute("deliveryFee");
    Double platformFeeValue =
        (Double) request.getAttribute("platformFee");
    Double grandTotalValue =
        (Double) request.getAttribute("grandTotal");

    if (cart == null || cart.getItems().isEmpty()
            || itemTotalValue == null
            || deliveryFeeValue == null
            || platformFeeValue == null
            || grandTotalValue == null) {
        response.sendRedirect(ctx + "/cart");
        return;
    }

    double itemTotal = itemTotalValue;
    double deliveryFee = deliveryFeeValue;
    double platformFee = platformFeeValue;
    double grandTotal = grandTotalValue;

    DecimalFormat moneyFormat = new DecimalFormat("#,##0.00");

    // error saved by ConfirmOrderController (shown once)
    String paymentError = (String) session.getAttribute("paymentError");
    if (paymentError != null) {
        session.removeAttribute("paymentError");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | Payment</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">

    <link rel="stylesheet" href="<%= ctx %>/pay.css">
</head>
<body>

<!-- ================= CHECKOUT HEADER ================= -->
<header class="co-header">
    <div class="co-header-inner">

        <a class="co-brand" href="<%= ctx %>/index.jsp">
            <span class="co-logo">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     aria-hidden="true">
                    <path d="M7 3v7a2 2 0 0 0 2 2v9"/>
                    <path d="M11 3v7a2 2 0 0 1-2 2"/>
                    <path d="M9 3v5"/>
                    <path d="M17 21V3c-2.5 1.5-3.5 4.5-3.5 8 0 1.7 1 3 3.5 3"/>
                </svg>
            </span>
            <span class="co-brand-text">Food<span>ora</span></span>
        </a>

        <ol class="co-steps" aria-label="Checkout progress">
            <li class="done"><span>&#10003;</span> Cart</li>
            <li class="line"></li>
            <li class="current"><span>2</span> Payment</li>
            <li class="line"></li>
            <li><span>3</span> Confirmation</li>
        </ol>

        <a class="co-back" href="<%= ctx %>/cart">&larr; Back to cart</a>
    </div>
</header>

<main class="co-page">

    <!-- ================= LEFT: PAYMENT ================= -->
    <section class="co-main">

        <p class="eyebrow">CHECKOUT</p>
        <h1>Complete your order</h1>

        <div class="co-card">

            <div class="co-card-head">
                <h2>Payment method</h2>
                
            </div>

            <% if (paymentError != null) { %>
                <div class="server-error"><%= esc(paymentError) %></div>
            <% } %>

            <form id="paymentForm" action="<%= ctx %>/confirmOrder"
                  method="post" novalidate>

                <!-- UPI -->
                <label class="pay-option">
                    <input type="radio" name="paymentMethod" value="UPI" checked>
                    <span class="pay-icon">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="1.8"
                             stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="5" y="2" width="14" height="20" rx="2" ry="2"/>
                            <path d="M12 18h.01"/>
                        </svg>
                    </span>
                    <span class="pay-text">
                        <strong>UPI</strong>
                        <small>Google Pay / PhonePe / Paytm</small>
                    </span>
                    <span class="pay-check"></span>
                </label>

                <div id="upiBox" class="pay-panel">
                    <input type="text" id="upiInput" class="field"
                           placeholder="Enter UPI ID (example: name@okaxis)"
                           autocomplete="off" autocapitalize="off" spellcheck="false">
                    <div class="upi-chips">
                        <button type="button" class="upi-chip" data-handle="@okaxis">@okaxis</button>
                        <button type="button" class="upi-chip" data-handle="@ybl">@ybl</button>
                        <button type="button" class="upi-chip" data-handle="@paytm">@paytm</button>
                        <button type="button" class="upi-chip" data-handle="@oksbi">@oksbi</button>
                    </div>
                    <p class="field-error" id="upiError"></p>
                </div>

                <!-- CARD -->
                <label class="pay-option">
                    <input type="radio" name="paymentMethod" value="CARD">
                    <span class="pay-icon">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="1.8"
                             stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/>
                            <path d="M1 10h22"/>
                        </svg>
                    </span>
                    <span class="pay-text">
                        <strong>Credit / Debit Card</strong>
                        <small>Visa / Mastercard / RuPay</small>
                    </span>
                    <span class="pay-check"></span>
                </label>

                <div id="cardBox" class="pay-panel hidden">

                    <div class="demo-note">
                        <span>
                            Demo checkout &ndash; no payment is processed.
                            Use test card <b>4111 1111 1111 1111</b>,
                            any future expiry, any 3-digit CVV.
                        </span>
                        <button type="button" id="fillTestCard">Fill test card</button>
                    </div>

                    <div class="field-wrap">
                        <input type="text" id="cardNumber" class="field"
                               placeholder="Card number" inputmode="numeric"
                               maxlength="19" autocomplete="off">
                        <span class="card-brand" id="cardBrand"></span>
                    </div>
                    <p class="field-error" id="cardNumberError"></p>

                    <div class="card-row">
                        <div>
                            <input type="text" id="cardExpiry" class="field"
                                   placeholder="MM/YY" inputmode="numeric"
                                   maxlength="5" autocomplete="off">
                            <p class="field-error" id="cardExpiryError"></p>
                        </div>
                        <div>
                            <input type="password" id="cardCvv" class="field"
                                   placeholder="CVV" inputmode="numeric"
                                   maxlength="4" autocomplete="off">
                            <p class="field-error" id="cardCvvError"></p>
                        </div>
                    </div>
                </div>

                <!-- COD -->
                <label class="pay-option">
                    <input type="radio" name="paymentMethod" value="COD">
                    <span class="pay-icon">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="1.8"
                             stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="2" y="6" width="20" height="12" rx="2"/>
                            <circle cx="12" cy="12" r="2.5"/>
                            <path d="M6 12h.01M18 12h.01"/>
                        </svg>
                    </span>
                    <span class="pay-text">
                        <strong>Cash on Delivery</strong>
                        <small>Pay when your food arrives</small>
                    </span>
                    <span class="pay-check"></span>
                </label>

                <div id="codBox" class="pay-panel hidden">
                    <p class="cod-note">
                        Please keep the exact amount ready.
                        Our delivery partner may not carry change.
                    </p>
                </div>

                <button type="submit" id="placeOrderBtn" class="place-order"
                        data-total="<%= moneyFormat.format(grandTotal) %>">
                    <span id="placeOrderLabel">Pay &#8377;<%= moneyFormat.format(grandTotal) %></span>
                </button>

            </form>
        </div>
    </section>

    <!-- ================= RIGHT: SUMMARY ================= -->
    <aside class="co-summary">
        <h2>Order summary</h2>

        <div class="sum-items">
            <% for (Map.Entry<Integer, CartItem> entry
                    : cart.getItems().entrySet()) {

                CartItem item = entry.getValue();
            %>
                <div class="sum-item">
                    <span class="sum-name">
                        <%= esc(item.getMenu().getItemName()) %>
                        <em>&times; <%= item.getQuantity() %></em>
                    </span>
                    <strong>&#8377;<%= moneyFormat.format(item.getSubtotal()) %></strong>
                </div>
            <% } %>
        </div>

        <div class="sum-line">
            <span>Item total</span>
            <strong>&#8377;<%= moneyFormat.format(itemTotal) %></strong>
        </div>

        <div class="sum-line">
            <span>Delivery fee</span>
            <strong>&#8377;<%= moneyFormat.format(deliveryFee) %></strong>
        </div>

        <div class="sum-line">
            <span>Platform fee</span>
            <strong>&#8377;<%= moneyFormat.format(platformFee) %></strong>
        </div>

        <div class="sum-total">
            <span>To pay</span>
            <strong>&#8377;<%= moneyFormat.format(grandTotal) %></strong>
        </div>
    </aside>

</main>

<script src="<%= ctx %>/pay.js"></script>

</body>
</html>
