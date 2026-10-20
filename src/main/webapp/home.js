
document.addEventListener("DOMContentLoaded", function () {

    // Mobile navigation
    const mobileMenu = document.getElementById("mobileMenu");
    const mobileNav = document.getElementById("mobileNav");

    if (mobileMenu && mobileNav) {
        mobileMenu.addEventListener("click", function () {
            mobileNav.classList.toggle("active");
        });
    }

    // Clicking a food card opens its restaurant menu
    document.querySelectorAll(".food-card").forEach(function (card) {
        card.addEventListener("click", function (event) {
            if (event.target.closest("a, button")) {
                return;
            }

            const itemName = card.dataset.item;

            if (!itemName) {
                window.location.href = "restaurant";
                return;
            }

            window.location.href =
                "home?itemName=" + encodeURIComponent(itemName);
        });
    });

    // Explore Food button
    const heroButton = document.querySelector(".hero-button");

    if (heroButton) {
        heroButton.addEventListener("click", function (event) {
            event.preventDefault();

            const morningTrack =
                document.getElementById("morningTrack");

            if (morningTrack) {
                morningTrack.scrollIntoView({
                    behavior: "smooth",
                    block: "center"
                });
            }
        });
    }

    // Carousel left/right arrows
    document.querySelectorAll(".scroll-button").forEach(function (button) {
        button.addEventListener("click", function () {
            const targetId = button.dataset.target;
            const track = document.getElementById(targetId);

            if (!track) {
                return;
            }

            const isLeft =
                button.classList.contains("left") ||
                button.classList.contains("prev") ||
                button.textContent.trim() === "←";

            track.scrollBy({
                left: (isLeft ? -1 : 1) * track.clientWidth * 0.8,
                behavior: "smooth"
            });
        });
    });

});
