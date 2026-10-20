<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Menu" %>

<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<%
    String ctx = request.getContextPath();

    if (request.getAttribute("results") == null) {
        response.sendRedirect(ctx + "/search");
        return;
    }

    String query = (String) request.getAttribute("query");
    Boolean searchedObj = (Boolean) request.getAttribute("searched");
    boolean searched = searchedObj != null && searchedObj;

    List<Menu> results = (List<Menu>) request.getAttribute("results");
    Map<Integer, String> restaurantNames =
        (Map<Integer, String>) request.getAttribute("restaurantNames");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | Search</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: 'Inter', 'Segoe UI', Roboto, Arial, sans-serif;
            background: #fff9f3;
            color: #38251d;
        }

        .search-page {
            max-width: 1100px;
            margin: 28px auto 60px;
            padding: 0 20px;
        }

        .big-search {
            display: flex;
            gap: 10px;
            margin-bottom: 26px;
        }

        .big-search input {
            flex: 1;
            min-width: 0;
            padding: 15px 22px;
            border: 1px solid #eadbca;
            border-radius: 16px;
            background: white;
            font-family: inherit;
            font-size: 16px;
            color: #2b1b14;
            outline: none;
            box-shadow: 0 8px 28px rgba(55, 31, 17, 0.06);
        }

        .big-search input:focus { border-color: #d86e2c; }

        .big-search button {
            padding: 0 28px;
            border: 0;
            border-radius: 16px;
            background: #d86e2c;
            color: white;
            font-family: inherit;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .big-search button:hover { background: #c55f20; }

        .result-count {
            color: #8a7a6d;
            margin: 6px 0 20px;
            font-size: 15px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 20px;
        }

        .item-card {
            display: block;
            background: white;
            border: 1px solid #eadbca;
            border-radius: 18px;
            overflow: hidden;
            text-decoration: none;
            color: inherit;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 30px rgba(55, 31, 17, 0.12);
        }

        .item-card img {
            width: 100%;
            height: 170px;
            object-fit: cover;
            display: block;
            background: #eee5de;
        }

        .item-info { padding: 14px 16px 16px; }
        .item-info h3 { margin: 0 0 6px; font-size: 17px; }
        .item-info .rest { color: #8a7a6d; font-size: 13px; margin-bottom: 10px; }
        .item-info .price { font-weight: bold; color: #d86e2c; font-size: 17px; }

        .unavailable {
            display: inline-block;
            margin-left: 8px;
            padding: 3px 8px;
            border-radius: 10px;
            background: #fdecea;
            color: #d93025;
            font-size: 11px;
            font-weight: bold;
            vertical-align: middle;
        }

        .message-box {
            text-align: center;
            background: white;
            border: 1px solid #eadbca;
            border-radius: 18px;
            padding: 50px 20px;
        }

        .message-box h2 { margin-top: 0; }
        .message-box p { color: #8a7a6d; line-height: 1.6; }

        .chips {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-top: 18px;
        }

        .chips a {
            padding: 9px 18px;
            border: 1px solid #eadbca;
            border-radius: 999px;
            background: #fffaf4;
            color: #604b3e;
            text-decoration: none;
            font-size: 14px;
        }

        .chips a:hover { border-color: #d86e2c; color: #d86e2c; }
    </style>
</head>

<body>

    <jsp:include page="/Navbar.jsp" />

    <main class="search-page">

        <form class="big-search" action="<%= ctx %>/search" method="get" autocomplete="off">
            <input type="text" name="q" value="<%= esc(query) %>"
                   placeholder="Search for biryani, dosa, pizza..."
                   maxlength="100" aria-label="Search food">
            <button type="submit">Search</button>
        </form>

        <% if (!searched) { %>

            <section class="message-box">
                <h2>What are you craving?</h2>
                <p>Type a food item above, or try one of these:</p>
                <div class="chips">
                    <a href="<%= ctx %>/search?q=biryani">Biryani</a>
                    <a href="<%= ctx %>/search?q=dosa">Dosa</a>
                    <a href="<%= ctx %>/search?q=idli">Idli</a>
                    <a href="<%= ctx %>/search?q=pizza">Pizza</a>
                    <a href="<%= ctx %>/search?q=burger">Burger</a>
                </div>
            </section>

        <% } else if (results.isEmpty()) { %>

            <section class="message-box">
                <h2>Item not found</h2>
                <p>
                    Sorry, we couldn't find &ldquo;<%= esc(query) %>&rdquo;.<br>
                    Please search another item.
                </p>
                <div class="chips">
                    <a href="<%= ctx %>/search?q=biryani">Biryani</a>
                    <a href="<%= ctx %>/search?q=dosa">Dosa</a>
                    <a href="<%= ctx %>/search?q=idli">Idli</a>
                    <a href="<%= ctx %>/search?q=pizza">Pizza</a>
                </div>
            </section>

        <% } else { %>

            <p class="result-count">
                <%= results.size() %> result<%= results.size() == 1 ? "" : "s" %>
                for &ldquo;<%= esc(query) %>&rdquo;
            </p>

            <div class="grid">
            <% for (Menu m : results) {
                String restName = restaurantNames == null
                        ? null : restaurantNames.get(m.getRestaurantId());
            %>
                <a class="item-card"
                   href="<%= ctx %>/menu?restaurantId=<%= m.getRestaurantId() %>#menu-item-<%= m.getMenuId() %>">

                    <img src="<%= ctx %>/<%= esc(m.getImagePath()) %>"
                         alt="<%= esc(m.getItemName()) %>">

                    <div class="item-info">
                        <h3>
                            <%= esc(m.getItemName()) %>
                            <% if (!m.isAvailable()) { %>
                                <span class="unavailable">Unavailable</span>
                            <% } %>
                        </h3>
                        <div class="rest"><%= restName == null ? "" : esc(restName) %></div>
                        <div class="price">&#8377;<%= String.format("%.2f", m.getPrice()) %></div>
                    </div>

                </a>
            <% } %>
            </div>

        <% } %>

    </main>

</body>
</html>
