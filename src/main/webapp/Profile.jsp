<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>

<%!
    private String esc(String s) {
        if (s == null || s.trim().isEmpty()) return "Not provided";
        return s.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<%
    String ctx = request.getContextPath();
    User profileUser = (User) request.getAttribute("profileUser");

    if (profileUser == null) {
        response.sendRedirect(ctx + "/profile");
        return;
    }

    Integer orderCountObj = (Integer) request.getAttribute("orderCount");
    int orderCount = orderCountObj == null ? 0 : orderCountObj;

    String name = profileUser.getUsername();
    String initial = (name == null || name.trim().isEmpty())
            ? "U" : name.trim().substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | My Profile</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #fff9f3;
            color: #38251d;
        }

        .profile-page {
            max-width: 700px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .profile-card {
            background: white;
            border: 1px solid #eadbca;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
        }

        .profile-top {
            display: flex;
            align-items: center;
            gap: 18px;
            padding-bottom: 22px;
            border-bottom: 1px solid #f0e4d8;
        }

        .avatar {
            width: 68px;
            height: 68px;
            border-radius: 50%;
            background: #d86e2c;
            color: white;
            font-size: 30px;
            font-weight: bold;
            display: grid;
            place-items: center;
        }

        .profile-top h1 { margin: 0 0 4px; font-size: 26px; }
        .profile-top p { margin: 0; color: #8a7a6d; }

        .detail-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 16px 0;
            border-bottom: 1px solid #f7efe6;
        }

        .detail-row span:first-child { color: #8a7a6d; }
        .detail-row span:last-child {
            font-weight: bold;
            text-align: right;
            overflow-wrap: anywhere;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 26px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-primary { background: #d86e2c; color: white; }
        .btn-logout { background: #fdecea; color: #d93025; }
    </style>
</head>

<body>

    <jsp:include page="/Navbar.jsp" />

    <main class="profile-page">
        <section class="profile-card">

            <div class="profile-top">
                <div class="avatar"><%= initial %></div>
                <div>
                    <h1><%= esc(profileUser.getUsername()) %></h1>
                    <p>Foodora customer</p>
                </div>
            </div>

            <div class="detail-row">
                <span>Name</span>
                <span><%= esc(profileUser.getUsername()) %></span>
            </div>

            <div class="detail-row">
                <span>Email</span>
                <span><%= esc(profileUser.getEmail()) %></span>
            </div>

            <div class="detail-row">
                <span>Phone</span>
                <span><%= esc(profileUser.getPhone()) %></span>
            </div>

            <div class="detail-row">
                <span>Address</span>
                <span><%= esc(profileUser.getAddress()) %></span>
            </div>

            <div class="detail-row">
                <span>Total orders</span>
                <span><%= orderCount %></span>
            </div>

            <div class="actions">
                <a href="<%= ctx %>/myOrders" class="btn btn-primary">My Orders</a>
                <a href="<%= ctx %>/logout" class="btn btn-logout">Logout</a>
            </div>

        </section>
    </main>

</body>
</html>