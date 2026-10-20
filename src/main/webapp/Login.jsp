<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
    // Escapes user-controlled text before printing it into HTML
    private static String esc(Object value) {
        if (value == null) return "";
        return value.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
%>

<%
    String ctx = request.getContextPath();

    String returnUrl = (String) request.getAttribute("returnUrl");
    if (returnUrl == null) returnUrl = "";

    String error = (String) request.getAttribute("error");
    boolean registered = "true".equals(request.getParameter("registered"));

    // keep the typed email if login failed (password is never refilled)
    String emailValue = request.getParameter("email");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | Login</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="<%= ctx %>/both.css">
</head>
<body>

<main class="auth-page">

    <!-- Background image : webapp/images/login.png (set in account.css) -->
    <div class="background-image"></div>

    <section class="auth-wrapper">
        <div class="auth-card">

            <!-- BRAND -->
            <div class="brand">
                <div class="brand-mark">FO</div>
                <div class="brand-name">Food<span>ora</span></div>
            </div>

            <!-- HEADING -->
            <div class="auth-heading">
                <p class="welcome-label">WELCOME BACK</p>
                <h1>Sign in</h1>
                <p class="subtitle">Enter your details to continue</p>
            </div>

            <% if (registered) { %>
                <div class="success-message">
                    Registration successful. Please login.
                </div>
            <% } %>

            <% if (error != null) { %>
                <div class="error-message"><%= esc(error) %></div>
            <% } %>

            <!-- LOGIN FORM  (POST /login -> LoginController) -->
            <form id="loginForm" action="<%= ctx %>/login" method="post">

                <input type="hidden" name="returnUrl" value="<%= esc(returnUrl) %>">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-container">
                        <input type="email"
                               id="email"
                               name="email"
                               value="<%= esc(emailValue) %>"
                               placeholder="Enter your email"
                               autocomplete="email"
                               maxlength="150"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-container">
                        <input type="password"
                               id="password"
                               name="password"
                               placeholder="Enter your password"
                               autocomplete="current-password"
                               required>

                        <button type="button"
                                class="password-toggle"
                                data-target="password">
                            Show
                        </button>
                    </div>
                </div>

                <button type="submit" class="auth-button" id="loginButton">
                    <span class="button-text">Sign In</span>
                    <span class="button-arrow">→</span>
                </button>

            </form>

            <!-- REGISTER LINK (returnUrl is carried forward) -->
            <div class="auth-switch">
                <span>Don't have an account?</span>
                <a href="<%= ctx %>/register?returnUrl=<%= java.net.URLEncoder.encode(returnUrl, "UTF-8") %>">
                    Create Account
                </a>
            </div>

            <a class="secure-text" href="<%= ctx %>/restaurant">
                ← Back to Restaurants
            </a>

        </div>
    </section>

</main>

<script>
    // Show / Hide password
    document.querySelectorAll(".password-toggle").forEach(function (btn) {
        btn.addEventListener("click", function () {
            var input = document.getElementById(btn.getAttribute("data-target"));
            if (input.type === "password") {
                input.type = "text";
                btn.textContent = "Hide";
            } else {
                input.type = "password";
                btn.textContent = "Show";
            }
        });
    });

    // Prevent double submit
    document.getElementById("loginForm").addEventListener("submit", function () {
        var b = document.getElementById("loginButton");
        b.disabled = true;
        b.querySelector(".button-text").textContent = "Signing in...";
    });

    // Re-enable button if the page is restored from the back button
    window.addEventListener("pageshow", function (e) {
        if (e.persisted) {
            var b = document.getElementById("loginButton");
            b.disabled = false;
            b.querySelector(".button-text").textContent = "Sign In";
        }
    });
</script>

</body>
</html>
