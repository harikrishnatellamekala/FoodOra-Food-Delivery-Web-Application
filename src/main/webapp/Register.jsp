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

    // When the controller forwards back with an error, the POST
    // parameters are still available, so the form keeps what was typed
    // (passwords are never refilled).
    String usernameValue = request.getParameter("username");
    String phoneValue    = request.getParameter("phone");
    String emailValue    = request.getParameter("email");
    String addressValue  = request.getParameter("address");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | Create Account</title>

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
        <div class="auth-card register-card">

            <!-- BRAND -->
            <div class="brand">
                <div class="brand-mark">FO</div>
                <div class="brand-name">Food<span>ora</span></div>
            </div>

            <!-- HEADING -->
            <div class="auth-heading">
                <p class="welcome-label">WELCOME TO FOODORA</p>
                <h1>Create Account</h1>
                <p class="subtitle">Create your account and start ordering</p>
            </div>

            <% if (error != null) { %>
                <div class="error-message"><%= esc(error) %></div>
            <% } %>

            <!-- REGISTER FORM  (POST /register -> RegisterController)
                 Field names = controller parameters = users table columns:
                 username, phone, email, password, address -->
            <form id="registerForm" action="<%= ctx %>/register" method="post">

                <input type="hidden" name="returnUrl" value="<%= esc(returnUrl) %>">

                <!-- USERNAME + PHONE -->
                <div class="form-row">

                    <div class="form-group">
                        <label for="username">Full Name</label>
                        <div class="input-container">
                            <input type="text"
                                   id="username"
                                   name="username"
                                   value="<%= esc(usernameValue) %>"
                                   placeholder="Enter your full name"
                                   autocomplete="name"
                                   maxlength="100"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <div class="input-container">
                            <input type="tel"
                                   id="phone"
                                   name="phone"
                                   value="<%= esc(phoneValue) %>"
                                   placeholder="Enter phone number"
                                   autocomplete="tel"
                                   inputmode="numeric"
                                   pattern="[0-9+ ]{10,15}"
                                   title="Enter a valid phone number (10 to 15 digits)"
                                   maxlength="15"
                                   required>
                        </div>
                    </div>

                </div>

                <!-- EMAIL -->
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-container">
                        <input type="email"
                               id="email"
                               name="email"
                               value="<%= esc(emailValue) %>"
                               placeholder="Enter your email address"
                               autocomplete="email"
                               maxlength="150"
                               required>
                    </div>
                </div>

                <!-- ADDRESS -->
                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <div class="input-container">
                        <input type="text"
                               id="address"
                               name="address"
                               value="<%= esc(addressValue) %>"
                               placeholder="House no, street, area, city"
                               autocomplete="street-address"
                               maxlength="255"
                               required>
                    </div>
                </div>

                <!-- PASSWORD + CONFIRM PASSWORD -->
                <div class="form-row">

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-container">
                            <input type="password"
                                   id="password"
                                   name="password"
                                   placeholder="Create password"
                                   autocomplete="new-password"
                                   minlength="6"
                                   maxlength="255"
                                   required>

                            <button type="button"
                                    class="password-toggle"
                                    data-target="password">
                                Show
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <div class="input-container">
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   placeholder="Confirm password"
                                   autocomplete="new-password"
                                   maxlength="255"
                                   required>

                            <button type="button"
                                    class="password-toggle"
                                    data-target="confirmPassword">
                                Show
                            </button>
                        </div>
                    </div>

                </div>

                <button type="submit" class="auth-button" id="registerButton">
                    <span class="button-text">Create Account</span>
                    <span class="button-arrow">→</span>
                </button>

            </form>

            <!-- LOGIN LINK (returnUrl is carried forward) -->
            <div class="auth-switch">
                <span>Already have an account?</span>
                <a href="<%= ctx %>/login?returnUrl=<%= java.net.URLEncoder.encode(returnUrl, "UTF-8") %>">
                    Sign In
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

    // Confirm-password check (done in the browser, controller is untouched)
    var form    = document.getElementById("registerForm");
    var pass    = document.getElementById("password");
    var confirm = document.getElementById("confirmPassword");

    function checkMatch() {
        confirm.setCustomValidity(
            confirm.value !== pass.value ? "Passwords do not match" : ""
        );
    }
    pass.addEventListener("input", checkMatch);
    confirm.addEventListener("input", checkMatch);

    // Prevent double submit
    form.addEventListener("submit", function () {
        var b = document.getElementById("registerButton");
        b.disabled = true;
        b.querySelector(".button-text").textContent = "Creating...";
    });

    // Re-enable button if the page is restored from the back button
    window.addEventListener("pageshow", function (e) {
        if (e.persisted) {
            var b = document.getElementById("registerButton");
            b.disabled = false;
            b.querySelector(".button-text").textContent = "Create Account";
        }
    });
</script>

</body>
</html>
