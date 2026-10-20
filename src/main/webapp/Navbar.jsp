<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%
    String ctx = request.getContextPath();
    User user = (User) session.getAttribute("user");

    // ---------- cart count: always calculated from the real cart ----------
    int cartCount = 0;
    Object cartObj = session.getAttribute("cart");

    if (cartObj instanceof Cart) {
        Cart sessionCart = (Cart) cartObj;
        if (sessionCart.getItems() != null) {
            for (CartItem ci : sessionCart.getItems().values()) {
                cartCount += ci.getQuantity();
            }
        }
    }

    String cartBadge = cartCount > 99 ? "99+" : String.valueOf(cartCount);

    // ---------- which page are we on? (for the active link) ----------
    String uri = (String) request.getAttribute("jakarta.servlet.forward.request_uri");
    if (uri == null) uri = request.getRequestURI();
    String path = uri.startsWith(ctx) ? uri.substring(ctx.length()) : uri;

    boolean isHome   = path.isEmpty() || path.equals("/") || path.equals("/index.jsp");
    boolean isRest   = path.startsWith("/restaurant") || path.startsWith("/menu");
    boolean isOrders = path.startsWith("/myOrders") || path.startsWith("/orderTracking");
    boolean isCart   = path.startsWith("/cart");
    boolean isSearch = path.startsWith("/search");

    // search icon only on Home, Restaurants, Menu and the Search page
    boolean showSearch = isHome || isRest || isSearch;

    // ---------- safe text ----------
    String safeName = "";
    String safeEmail = "";

    if (user != null) {
        if (user.getUsername() != null) {
            safeName = user.getUsername().replace("&", "&amp;")
                .replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
        }
        if (user.getEmail() != null) {
            safeEmail = user.getEmail().replace("&", "&amp;")
                .replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
        }
    }

    String navQuery = request.getParameter("q");
    if (navQuery == null) navQuery = "";
    navQuery = navQuery.replace("&", "&amp;").replace("<", "&lt;")
                       .replace(">", "&gt;").replace("\"", "&quot;");
%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">

<div class="fd-nav-wrap">
    <header class="fd-nav">

        <!-- ================= LOGO ================= -->
        <a class="fd-brand" href="<%= ctx %>/index.jsp">
            <span class="fd-logo">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#fff"
                     stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     aria-hidden="true">
                    <path d="M7 3v7a2 2 0 0 0 2 2v9"/>
                    <path d="M11 3v7a2 2 0 0 1-2 2"/>
                    <path d="M9 3v5"/>
                    <path d="M17 21V3c-2.5 1.5-3.5 4.5-3.5 8 0 1.7 1 3 3.5 3"/>
                </svg>
            </span>
            <span class="fd-brand-text">Food<span>ora</span></span>
        </a>

        <!-- ================= LINKS ================= -->
        <nav class="fd-links" aria-label="Main">
            <a href="<%= ctx %>/index.jsp"
               class="fd-link<%= isHome ? " active" : "" %>">Home</a>
            <a href="<%= ctx %>/restaurant"
               class="fd-link<%= isRest ? " active" : "" %>">Restaurants</a>
            <a href="<%= ctx %>/myOrders"
               class="fd-link<%= isOrders ? " active" : "" %>">My Orders</a>
        </nav>

        <!-- ================= ICONS ================= -->
        <div class="fd-actions">

            <% if (showSearch) { %>
                <button type="button" class="fd-icon-btn" id="fdSearchOpen"
                        aria-label="Search food" title="Search (press /)">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" aria-hidden="true">
                        <circle cx="11" cy="11" r="7"/>
                        <path d="M20 20l-3.5-3.5"/>
                    </svg>
                </button>
            <% } %>

            <% if (user == null) { %>

                <a href="<%= ctx %>/login" class="fd-login">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" aria-hidden="true">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                        <circle cx="12" cy="7" r="4"/>
                    </svg>
                    <span>Login</span>
                </a>

            <% } else { %>

                <div class="fd-profile" id="fdProfile">
                    <button type="button" class="fd-icon-btn" id="fdProfileBtn"
                            aria-haspopup="true" aria-expanded="false"
                            aria-label="Account menu" title="<%= safeName %>">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round"
                             stroke-linejoin="round" aria-hidden="true">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                    </button>

                    <div class="fd-dropdown" id="fdProfileMenu">
                        <div class="fd-dd-head">
                            <strong><%= safeName %></strong>
                            <small><%= safeEmail %></small>
                        </div>
                        <a href="<%= ctx %>/profile">My Profile</a>
                        <a href="<%= ctx %>/myOrders">My Orders</a>
                        <a href="<%= ctx %>/logout" class="fd-logout">Logout</a>
                    </div>
                </div>

            <% } %>

            <a href="<%= ctx %>/cart"
               class="fd-icon-btn<%= isCart ? " active" : "" %>"
               aria-label="Cart, <%= cartCount %> items" title="Cart">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round"
                     stroke-linejoin="round" aria-hidden="true">
                    <circle cx="9" cy="21" r="1"/>
                    <circle cx="20" cy="21" r="1"/>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                </svg>
                <% if (cartCount > 0) { %>
                    <span class="fd-badge"><%= cartBadge %></span>
                <% } %>
            </a>

        </div>
    </header>
</div>

<% if (showSearch) { %>
<!-- ================= SEARCH OVERLAY ================= -->
<div class="fd-search" id="fdSearch" hidden>
    <div class="fd-search-backdrop" id="fdSearchBackdrop"></div>

    <div class="fd-search-panel" role="dialog" aria-modal="true" aria-label="Search food">

        <form class="fd-sform" id="fdSearchForm" action="<%= ctx %>/search"
              method="get" autocomplete="off" role="search">

            <svg width="22" height="22" viewBox="0 0 24 24" fill="none"
                 stroke="currentColor" stroke-width="2" stroke-linecap="round"
                 stroke-linejoin="round" aria-hidden="true">
                <circle cx="11" cy="11" r="7"/>
                <path d="M20 20l-3.5-3.5"/>
            </svg>

            <input type="text" name="q" id="fdSearchInput" value="<%= navQuery %>"
                   placeholder="Search for biryani, dosa, pizza..."
                   maxlength="100" autocomplete="off" aria-label="Search food">

            <button type="button" class="fd-sclear" id="fdSearchClear"
                    aria-label="Clear" hidden>&times;</button>

            <button type="submit" class="fd-ssubmit">Search</button>

            <button type="button" class="fd-sesc" id="fdSearchClose"
                    aria-label="Close search">Esc</button>
        </form>

        <div class="fd-sbody" id="fdSearchBody"></div>
    </div>
</div>
<% } %>

<style>
/* ===================== NAVBAR ===================== */
.fd-nav-wrap {
    position: sticky;
    top: 0;
    z-index: 1200;
    padding: 12px 4%;
    background: rgba(255, 250, 244, 0.65);
    -webkit-backdrop-filter: blur(10px);
    backdrop-filter: blur(10px);
    font-family: 'Inter', 'Segoe UI', Roboto, Arial, sans-serif;
}

.fd-nav {
    box-sizing: border-box;
    max-width: 1320px;
    min-height: 64px;
    margin: 0 auto;
    padding: 10px 14px 10px 18px;
    display: flex;
    align-items: center;
    gap: 18px;
    background: #ffffff;
    border: 1px solid #f0e4d8;
    border-radius: 20px;
    box-shadow: 0 8px 28px rgba(55, 31, 17, 0.08);
}

.fd-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    flex-shrink: 0;
}
.fd-logo {
    width: 38px;
    height: 38px;
    border-radius: 12px;
    display: grid;
    place-items: center;
    background: linear-gradient(135deg, #ff9a4d, #d86e2c);
    box-shadow: 0 6px 14px rgba(216, 110, 44, 0.35);
}
.fd-brand-text {
    font-size: 24px;
    font-weight: 800;
    letter-spacing: -0.6px;
    color: #2b1b14;
}
.fd-brand-text span { color: #d86e2c; }

.fd-links {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 6px;
}
.fd-link {
    padding: 10px 18px;
    border-radius: 999px;
    color: #3d2c24;
    font-size: 15px;
    font-weight: 600;
    text-decoration: none;
    white-space: nowrap;
    transition: background 0.2s, color 0.2s;
}
.fd-link:hover { background: #fff3ea; color: #d86e2c; }
.fd-link.active { background: #ffe9db; color: #d86e2c; }

.fd-actions {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-shrink: 0;
}

.fd-icon-btn {
    position: relative;
    width: 44px;
    height: 44px;
    padding: 0;
    border: 0;
    border-radius: 50%;
    display: grid;
    place-items: center;
    background: #f8f1e9;
    color: #3d2c24;
    text-decoration: none;
    cursor: pointer;
    font-family: inherit;
    transition: background 0.2s, color 0.2s, transform 0.15s;
}
.fd-icon-btn:hover { background: #ffe9db; color: #d86e2c; transform: translateY(-1px); }
.fd-icon-btn.active { background: #ffe9db; color: #d86e2c; }

.fd-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    box-sizing: border-box;
    min-width: 20px;
    height: 20px;
    padding: 0 5px;
    border: 2px solid #ffffff;
    border-radius: 999px;
    background: #d86e2c;
    color: #ffffff;
    font-size: 10.5px;
    font-weight: 700;
    line-height: 16px;
    text-align: center;
}

.fd-login {
    height: 44px;
    padding: 0 20px 0 15px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border-radius: 999px;
    background: #f8f1e9;
    color: #3d2c24;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
    transition: background 0.2s, color 0.2s;
}
.fd-login:hover { background: #d86e2c; color: #ffffff; }

.fd-profile { position: relative; }
.fd-dropdown {
    display: none;
    position: absolute;
    right: 0;
    top: calc(100% + 14px);
    min-width: 220px;
    padding: 8px;
    background: #ffffff;
    border: 1px solid #f0e4d8;
    border-radius: 14px;
    box-shadow: 0 16px 40px rgba(55, 31, 17, 0.16);
    z-index: 1250;
}
.fd-dropdown.show { display: block; }
.fd-dd-head {
    padding: 10px 12px 12px;
    margin-bottom: 6px;
    border-bottom: 1px solid #f3e8dc;
}
.fd-dd-head strong { display: block; color: #2b1b14; font-size: 15px; }
.fd-dd-head small { color: #8a7a6d; font-size: 12px; overflow-wrap: anywhere; }
.fd-dropdown a {
    display: block;
    padding: 11px 12px;
    border-radius: 9px;
    color: #3d2c24;
    font-size: 14px;
    font-weight: 500;
    text-decoration: none;
}
.fd-dropdown a:hover { background: #fff3ea; color: #d86e2c; }
.fd-dropdown .fd-logout { color: #d93025; font-weight: 700; }
.fd-dropdown .fd-logout:hover { background: #fdecea; color: #d93025; }

@media (max-width: 860px) {
    .fd-nav { flex-wrap: wrap; row-gap: 10px; }
    .fd-brand { flex: 1; }
    .fd-links {
        order: 3;
        flex-basis: 100%;
        overflow-x: auto;
    }
}

/* ===================== SEARCH OVERLAY ===================== */
.fd-search {
    position: fixed;
    inset: 0;
    z-index: 1300;
    font-family: 'Inter', 'Segoe UI', Roboto, Arial, sans-serif;
}
.fd-search[hidden] { display: none; }

.fd-search-backdrop {
    position: absolute;
    inset: 0;
    background: rgba(32, 20, 15, 0.5);
    -webkit-backdrop-filter: blur(3px);
    backdrop-filter: blur(3px);
}

.fd-search-panel {
    position: relative;
    box-sizing: border-box;
    width: calc(100% - 32px);
    max-width: 720px;
    margin: 9vh auto 0;
    background: #ffffff;
    border-radius: 22px;
    box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    animation: fdDrop 0.18s ease;
}
@keyframes fdDrop {
    from { opacity: 0; transform: translateY(-12px) scale(0.98); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
}

.fd-sform {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px 18px;
    border-bottom: 1px solid #f3e8dc;
    color: #d86e2c;
}
.fd-sform input {
    flex: 1;
    min-width: 0;
    border: 0;
    outline: 0;
    background: transparent;
    font-family: inherit;
    font-size: 18px;
    color: #2b1b14;
}
.fd-sclear {
    width: 26px;
    height: 26px;
    padding: 0;
    border: 0;
    border-radius: 50%;
    background: #f5e7d9;
    color: #7a6455;
    font-size: 18px;
    line-height: 26px;
    cursor: pointer;
}
.fd-sclear[hidden] { display: none; }
.fd-ssubmit {
    padding: 10px 20px;
    border: 0;
    border-radius: 12px;
    background: #d86e2c;
    color: #ffffff;
    font-family: inherit;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
}
.fd-ssubmit:hover { background: #c55f20; }
.fd-sesc {
    padding: 6px 10px;
    border: 1px solid #eadbca;
    border-radius: 8px;
    background: #ffffff;
    color: #8a7a6d;
    font-family: inherit;
    font-size: 12px;
    cursor: pointer;
}

.fd-sbody {
    max-height: min(60vh, 460px);
    overflow-y: auto;
    padding: 6px 0 8px;
}
.fd-stitle {
    padding: 12px 20px 8px;
    color: #8a7a6d;
    font-size: 11.5px;
    font-weight: 700;
    letter-spacing: 1.5px;
}
.fd-chips {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    padding: 4px 20px 14px;
}
.fd-chips a {
    padding: 9px 18px;
    border: 1px solid #eadbca;
    border-radius: 999px;
    background: #fffaf4;
    color: #604b3e;
    font-size: 14px;
    text-decoration: none;
}
.fd-chips a:hover { border-color: #d86e2c; color: #d86e2c; background: #fff3ea; }

.fd-srow {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 10px 20px;
    color: inherit;
    text-decoration: none;
}
.fd-srow:hover, .fd-srow.active { background: #fff4ec; }
.fd-srow img {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    object-fit: cover;
    background: #eee5de;
    flex-shrink: 0;
}
.fd-stext { flex: 1; min-width: 0; }
.fd-sname {
    color: #2b1b14;
    font-size: 15px;
    font-weight: 700;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.fd-sname b { color: #d86e2c; }
.fd-ssub { margin-top: 2px; color: #8a7a6d; font-size: 12px; }
.fd-sprice { color: #2b1b14; font-size: 14px; font-weight: 700; }
.fd-sfooter {
    display: block;
    padding: 13px 20px;
    border-top: 1px solid #f3e8dc;
    color: #d86e2c;
    font-size: 14px;
    font-weight: 700;
    text-decoration: none;
}
.fd-sfooter:hover { background: #fff4ec; }
.fd-sempty {
    padding: 28px 20px;
    text-align: center;
    color: #8a7a6d;
    font-size: 14px;
}
.fd-sempty strong { display: block; margin-bottom: 4px; color: #2b1b14; font-size: 16px; }

@media (max-width: 600px) {
    .fd-sesc { display: none; }
    .fd-ssubmit { padding: 10px 14px; }
}
</style>

<script>
(function () {

    /* ---------------- profile dropdown ---------------- */
    var pBtn = document.getElementById("fdProfileBtn");
    var pMenu = document.getElementById("fdProfileMenu");

    if (pBtn && pMenu) {
        var setMenu = function (open) {
            pMenu.classList.toggle("show", open);
            pBtn.setAttribute("aria-expanded", open ? "true" : "false");
        };

        pBtn.addEventListener("click", function (e) {
            e.stopPropagation();
            setMenu(!pMenu.classList.contains("show"));
        });

        document.addEventListener("click", function (e) {
            if (!pMenu.contains(e.target)) setMenu(false);
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") setMenu(false);
        });
    }

    /* ---------------- search overlay ---------------- */
    var openBtn = document.getElementById("fdSearchOpen");
    var overlay = document.getElementById("fdSearch");
    if (!openBtn || !overlay) return;

    var form = document.getElementById("fdSearchForm");
    var input = document.getElementById("fdSearchInput");
    var body = document.getElementById("fdSearchBody");
    var clearBtn = document.getElementById("fdSearchClear");
    var closeBtn = document.getElementById("fdSearchClose");
    var backdrop = document.getElementById("fdSearchBackdrop");

    var base = form.getAttribute("action");          // <ctx>/search
    var ctx = base.replace(/\/search$/, "");
    var popular = ["Biryani", "Dosa", "Idli", "Pizza", "Burger", "Chicken 65"];

    var timer = null, reqId = 0, active = -1;

    function el(tag, cls, text) {
        var e = document.createElement(tag);
        if (cls) e.className = cls;
        if (text != null) e.textContent = text;
        return e;
    }

    function toggleClear() { clearBtn.hidden = input.value.length === 0; }

    function showPopular() {
        body.textContent = "";
        active = -1;
        body.appendChild(el("div", "fd-stitle", "POPULAR SEARCHES"));

        var chips = el("div", "fd-chips");
        popular.forEach(function (word) {
            var a = el("a", null, word);
            a.href = base + "?q=" + encodeURIComponent(word);
            chips.appendChild(a);
        });
        body.appendChild(chips);
    }

    function highlight(target, text, q) {
        var at = q ? text.toLowerCase().indexOf(q.toLowerCase()) : -1;
        if (at < 0) { target.textContent = text; return; }
        target.appendChild(document.createTextNode(text.slice(0, at)));
        target.appendChild(el("b", null, text.slice(at, at + q.length)));
        target.appendChild(document.createTextNode(text.slice(at + q.length)));
    }

    function render(data, q) {
        body.textContent = "";
        active = -1;

        if (!data.items.length) {
            var empty = el("div", "fd-sempty");
            empty.appendChild(el("strong", null, "Item not found"));
            empty.appendChild(document.createTextNode(
                "We couldn\u2019t find \u201C" + q + "\u201D. Please search another item."));
            body.appendChild(empty);
            return;
        }

        data.items.forEach(function (it) {
            var row = el("a", "fd-srow");
            row.href = ctx + "/menu?restaurantId=" + it.restaurantId +
                       "#menu-item-" + it.menuId;

            var img = el("img");
            img.alt = "";
            img.src = ctx + "/" + it.image;
            img.onerror = function () { img.style.visibility = "hidden"; };
            row.appendChild(img);

            var text = el("div", "fd-stext");
            var name = el("div", "fd-sname");
            highlight(name, it.name, q);
            text.appendChild(name);
            text.appendChild(el("div", "fd-ssub",
                it.restaurant + (it.available ? "" : " \u2022 Unavailable")));
            row.appendChild(text);

            row.appendChild(el("div", "fd-sprice", "\u20B9" + it.price));
            body.appendChild(row);
        });

        var more = el("a", "fd-sfooter", "See all results for \u201C" + q + "\u201D \u2192");
        more.href = base + "?q=" + encodeURIComponent(q);
        body.appendChild(more);
    }

    function fetchSuggestions() {
        var q = input.value.trim();
        if (!q) { showPopular(); return; }

        var id = ++reqId;

        fetch(base + "?format=json&q=" + encodeURIComponent(q))
            .then(function (r) { return r.ok ? r.json() : Promise.reject(); })
            .then(function (data) { if (id === reqId) render(data, q); })
            .catch(function () { /* keep whatever is shown */ });
    }

    function openSearch() {
        overlay.hidden = false;
        document.documentElement.style.overflow = "hidden";
        toggleClear();
        fetchSuggestions();
        input.focus();
        input.select();
    }

    function closeSearch() {
        overlay.hidden = true;
        document.documentElement.style.overflow = "";
    }

    function mark(rows) {
        for (var i = 0; i < rows.length; i++) {
            rows[i].classList.toggle("active", i === active);
        }
        if (rows[active]) rows[active].scrollIntoView({ block: "nearest" });
    }

    openBtn.addEventListener("click", openSearch);
    closeBtn.addEventListener("click", closeSearch);
    backdrop.addEventListener("click", closeSearch);

    clearBtn.addEventListener("click", function () {
        input.value = "";
        toggleClear();
        showPopular();
        input.focus();
    });

    input.addEventListener("input", function () {
        toggleClear();
        clearTimeout(timer);
        timer = setTimeout(fetchSuggestions, 200);
    });

    input.addEventListener("keydown", function (e) {
        var rows = body.querySelectorAll(".fd-srow");

        if (e.key === "ArrowDown" && rows.length) {
            e.preventDefault();
            active = (active + 1) % rows.length;
            mark(rows);
        } else if (e.key === "ArrowUp" && rows.length) {
            e.preventDefault();
            active = (active - 1 + rows.length) % rows.length;
            mark(rows);
        } else if (e.key === "Enter" && active >= 0 && rows[active]) {
            e.preventDefault();
            window.location.href = rows[active].href;
        }
    });

    form.addEventListener("submit", function (e) {
        if (!input.value.trim()) { e.preventDefault(); input.focus(); }
    });

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape" && !overlay.hidden) {
            closeSearch();
            return;
        }

        var tag = (document.activeElement && document.activeElement.tagName) || "";
        if (e.key === "/" && overlay.hidden && !/INPUT|TEXTAREA|SELECT/.test(tag)) {
            e.preventDefault();
            openSearch();
        }
    });

})();
</script>
