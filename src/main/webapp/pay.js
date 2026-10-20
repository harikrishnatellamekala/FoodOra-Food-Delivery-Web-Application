document.addEventListener("DOMContentLoaded", function () {

    var form = document.getElementById("paymentForm");
    if (!form) return;

    var radios = form.querySelectorAll('input[name="paymentMethod"]');
    var options = form.querySelectorAll(".pay-option");

    var upiBox = document.getElementById("upiBox");
    var cardBox = document.getElementById("cardBox");
    var codBox = document.getElementById("codBox");

    var upiInput = document.getElementById("upiInput");
    var cardNumber = document.getElementById("cardNumber");
    var cardExpiry = document.getElementById("cardExpiry");
    var cardCvv = document.getElementById("cardCvv");

    var upiError = document.getElementById("upiError");
    var numberError = document.getElementById("cardNumberError");
    var expiryError = document.getElementById("cardExpiryError");
    var cvvError = document.getElementById("cardCvvError");

    var brandBadge = document.getElementById("cardBrand");
    var testCardBtn = document.getElementById("fillTestCard");
    var placeBtn = document.getElementById("placeOrderBtn");
    var btnLabel = document.getElementById("placeOrderLabel");
    var total = placeBtn.getAttribute("data-total");

    /* ---------------- helpers ---------------- */

    function selectedMode() {
        var checked = form.querySelector('input[name="paymentMethod"]:checked');
        return checked ? checked.value : "";
    }

    function setError(input, errorEl, message) {
        errorEl.textContent = message || "";
        if (input) input.classList.toggle("invalid", !!message);
    }

    function clearErrors() {
        setError(upiInput, upiError, "");
        setError(cardNumber, numberError, "");
        setError(cardExpiry, expiryError, "");
        setError(cardCvv, cvvError, "");
    }

    // Luhn check - every real card number passes this
    function luhnValid(digits) {
        var sum = 0, alt = false;

        for (var i = digits.length - 1; i >= 0; i--) {
            var n = parseInt(digits.charAt(i), 10);
            if (alt) {
                n *= 2;
                if (n > 9) n -= 9;
            }
            sum += n;
            alt = !alt;
        }
        return digits.length > 0 && sum % 10 === 0;
    }

    function detectBrand(digits) {
        if (/^4/.test(digits)) return "VISA";
        if (/^(5[1-5]|2[2-7])/.test(digits)) return "MASTERCARD";
        if (/^3[47]/.test(digits)) return "AMEX";
        if (/^(60|65|81|82|508)/.test(digits)) return "RUPAY";
        return "";
    }

    function updateView() {
        var mode = selectedMode();

        upiBox.classList.toggle("hidden", mode !== "UPI");
        cardBox.classList.toggle("hidden", mode !== "CARD");
        codBox.classList.toggle("hidden", mode !== "COD");

        options.forEach(function (opt) {
            var input = opt.querySelector("input");
            opt.classList.toggle("selected", input.checked);
        });

        btnLabel.textContent = mode === "COD"
            ? "Place Order"
            : "Pay \u20B9" + total;

        clearErrors();
    }

    radios.forEach(function (radio) {
        radio.addEventListener("change", updateView);
    });

    updateView();

    /* ---------------- input formatting ---------------- */

    cardNumber.addEventListener("input", function () {
        var digits = cardNumber.value.replace(/\D/g, "").slice(0, 16);
        cardNumber.value = digits.replace(/(.{4})/g, "$1 ").trim();

        var brand = detectBrand(digits);
        brandBadge.textContent = brand;
        brandBadge.classList.toggle("show", !!brand);

        setError(cardNumber, numberError, "");
    });

    cardExpiry.addEventListener("input", function () {
        var digits = cardExpiry.value.replace(/\D/g, "").slice(0, 4);
        cardExpiry.value = digits.length > 2
            ? digits.slice(0, 2) + "/" + digits.slice(2)
            : digits;

        setError(cardExpiry, expiryError, "");
    });

    cardCvv.addEventListener("input", function () {
        cardCvv.value = cardCvv.value.replace(/\D/g, "").slice(0, 4);
        setError(cardCvv, cvvError, "");
    });

    upiInput.addEventListener("input", function () {
        setError(upiInput, upiError, "");
    });

    // UPI quick-fill chips (@okaxis, @ybl ...)
    document.querySelectorAll(".upi-chip").forEach(function (chip) {
        chip.addEventListener("click", function () {
            var handle = chip.getAttribute("data-handle");
            var value = upiInput.value.trim();
            var name = value.indexOf("@") > -1
                ? value.slice(0, value.indexOf("@"))
                : value;

            upiInput.value = name + handle;
            upiInput.focus();
        });
    });

    // Test card helper (demo mode only)
    if (testCardBtn) {
        testCardBtn.addEventListener("click", function () {
            cardNumber.value = "4111 1111 1111 1111";
            cardNumber.dispatchEvent(new Event("input"));

            var now = new Date();
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var year = String((now.getFullYear() + 3) % 100);
            cardExpiry.value = month + "/" + ("0" + year).slice(-2);

            cardCvv.value = "123";
            clearErrors();
        });
    }

    /* ---------------- validation ---------------- */

    function validateCard() {
        var ok = true;
        var digits = cardNumber.value.replace(/\s/g, "");

        if (digits.length < 13) {
            setError(cardNumber, numberError, "Enter your 16-digit card number.");
            ok = false;
        } else if (!luhnValid(digits)) {
            setError(cardNumber, numberError,
                "This card number looks invalid. Please check it.");
            ok = false;
        }

        var match = /^(0[1-9]|1[0-2])\/(\d{2})$/.exec(cardExpiry.value.trim());

        if (!match) {
            setError(cardExpiry, expiryError, "Enter expiry as MM/YY.");
            ok = false;
        } else {
            var expMonth = parseInt(match[1], 10);
            var expYear = 2000 + parseInt(match[2], 10);
            var now = new Date();
            var thisYear = now.getFullYear();
            var thisMonth = now.getMonth() + 1;

            if (expYear < thisYear ||
                (expYear === thisYear && expMonth < thisMonth)) {
                setError(cardExpiry, expiryError, "This card has expired.");
                ok = false;
            }
        }

        var cvvLength = detectBrand(digits) === "AMEX" ? 4 : 3;

        if (cardCvv.value.length !== cvvLength) {
            setError(cardCvv, cvvError,
                "CVV must be " + cvvLength + " digits.");
            ok = false;
        }

        return ok;
    }

    form.addEventListener("submit", function (event) {
        var mode = selectedMode();
        var valid = true;

        if (!mode) {
            event.preventDefault();
            return;
        }

        if (mode === "UPI") {
            var upi = upiInput.value.trim();

            if (!/^[\w.\-]{2,}@[a-zA-Z0-9.\-]{2,}$/.test(upi)) {
                setError(upiInput, upiError,
                    "Enter a valid UPI ID, for example name@okaxis.");
                upiInput.focus();
                valid = false;
            }
        }

        if (mode === "CARD") {
            valid = validateCard();
        }

        if (!valid) {
            event.preventDefault();
            return;
        }

        // stop double clicks
        placeBtn.disabled = true;
        btnLabel.textContent = "Processing...";
    });
});