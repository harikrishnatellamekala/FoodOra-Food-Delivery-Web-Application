<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodora | Food Delivery</title>

    <link rel="stylesheet" href="home.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>

<body>

    <!-- ================= NAVBAR (shared with all pages) ================= -->
    <jsp:include page="/Navbar.jsp" />

    <!-- ================= HERO VIDEO ================= -->
    <section class="hero-video-section">
        <div class="hero-video-wrapper">

            <video class="hero-video" autoplay muted loop playsinline>
                <source src="videos/pintrest_home_page.mp4" type="video/mp4">
                Your browser does not support video.
            </video>

            <div class="hero-overlay"></div>

            <div class="hero-copy">
                <p>CRAVINGS MEET THEIR MATCH.</p>
                <h1>
                    Discover your<br>
                    <span>next favourite.</span>
                </h1>
                <a href="#morningTrack" class="hero-button">Explore Food ↓</a>
            </div>

        </div>
    </section>

    <!-- ================= FOOD CONTENT ================= -->
    <main class="home-content">

        <!-- ================= MORNING TIFFINS ================= -->
        <section class="food-section">
            <div class="section-heading">
                <div>
                    <p class="section-label">START YOUR DAY</p>
                    <h2>Morning Tiffins</h2>
                </div>
                <div class="section-controls">
                    <button class="scroll-button" data-target="morningTrack" data-direction="left" type="button">←</button>
                    <button class="scroll-button" data-target="morningTrack" data-direction="right" type="button">→</button>
                </div>
            </div>

            <div class="food-track-wrapper">
                <div class="food-track" id="morningTrack">

                    <article class="food-card" data-item="Idli Sambar">
                        <div class="food-image"><img src="images/menu/morning/idly.jfif" alt="Idli Sambar"></div>
                        <div class="food-info">
                            <h3>Idli Sambar</h3>
                            <p>Soft steamed idlis with hot sambar</p>
                            <div class="food-bottom"><strong>₹60</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Masala Dosa">
                        <div class="food-image"><img src="images/menu/morning/masala_dosa.jfif" alt="Masala Dosa"></div>
                        <div class="food-info">
                            <h3>Masala Dosa</h3>
                            <p>Crispy dosa filled with potato masala</p>
                            <div class="food-bottom"><strong>₹90</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Plain Dosa">
                        <div class="food-image"><img src="images/menu/morning/plane_dosa.jfif" alt="Plain Dosa"></div>
                        <div class="food-info">
                            <h3>Plain Dosa</h3>
                            <p>Thin crispy South Indian dosa</p>
                            <div class="food-bottom"><strong>₹70</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Vada Sambar">
                        <div class="food-image"><img src="images/menu/morning/vada.jfif" alt="Vada Sambar"></div>
                        <div class="food-info">
                            <h3>Vada Sambar</h3>
                            <p>Crispy medu vada with sambar</p>
                            <div class="food-bottom"><strong>₹65</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Poori Masala">
                        <div class="food-image"><img src="images/menu/morning/poori.jfif" alt="Poori Masala"></div>
                        <div class="food-info">
                            <h3>Poori Masala</h3>
                            <p>Fluffy pooris with potato masala</p>
                            <div class="food-bottom"><strong>₹80</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Pongal">
                        <div class="food-image"><img src="images/menu/morning/pongal.jfif" alt="Pongal"></div>
                        <div class="food-info">
                            <h3>Pongal</h3>
                            <p>Creamy South Indian ven pongal</p>
                            <div class="food-bottom"><strong>₹75</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Upma">
                        <div class="food-image"><img src="images/menu/morning/upma.jfif" alt="Upma"></div>
                        <div class="food-info">
                            <h3>Upma</h3>
                            <p>Freshly prepared South Indian upma</p>
                            <div class="food-bottom"><strong>₹55</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Thatte Idli">
                        <div class="food-image"><img src="images/menu/morning/Thatte_idli.jfif" alt="Thatte Idli"></div>
                        <div class="food-info">
                            <h3>Thatte Idli</h3>
                            <p>Soft Karnataka-style plate idli</p>
                            <div class="food-bottom"><strong>₹70</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Pesarattu">
                        <div class="food-image"><img src="images/menu/morning/Pesarattu.jfif" alt="Pesarattu"></div>
                        <div class="food-info">
                            <h3>Pesarattu</h3>
                            <p>Green gram dosa with ginger chutney</p>
                            <div class="food-bottom"><strong>₹90</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Rava Dosa">
                        <div class="food-image"><img src="images/menu/morning/rava_dosa.jfif" alt="Rava Dosa"></div>
                        <div class="food-info">
                            <h3>Rava Dosa</h3>
                            <p>Thin crispy semolina dosa</p>
                            <div class="food-bottom"><strong>₹95</strong></div>
                        </div>
                    </article>

                </div>
            </div>
        </section>

        <!-- ================= AFTERNOON FOOD ================= -->
        <section class="food-section">
            <div class="section-heading">
                <div>
                    <p class="section-label">LUNCH TIME</p>
                    <h2>Afternoon Food</h2>
                </div>
                <div class="section-controls">
                    <button class="scroll-button" data-target="afternoonTrack" data-direction="left" type="button">←</button>
                    <button class="scroll-button" data-target="afternoonTrack" data-direction="right" type="button">→</button>
                </div>
            </div>

            <div class="food-track-wrapper">
                <div class="food-track" id="afternoonTrack">

                    <article class="food-card" data-item="Chicken Biryani">
                        <div class="food-image"><img src="images/menu/afternoon/biryani.jfif" alt="Chicken Biryani"></div>
                        <div class="food-info">
                            <h3>Chicken Biryani</h3>
                            <p>Fragrant basmati rice with tender chicken</p>
                            <div class="food-bottom"><strong>₹220</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Mutton Biryani">
                        <div class="food-image"><img src="images/menu/afternoon/Mutton Biryani.jfif" alt="Mutton Biryani"></div>
                        <div class="food-info">
                            <h3>Mutton Biryani</h3>
                            <p>Aromatic rice with slow-cooked mutton</p>
                            <div class="food-bottom"><strong>₹280</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Veg Biryani">
                        <div class="food-image"><img src="images/menu/afternoon/veg_biryani.jfif" alt="Veg Biryani"></div>
                        <div class="food-info">
                            <h3>Veg Biryani</h3>
                            <p>Fragrant rice cooked with fresh vegetables</p>
                            <div class="food-bottom"><strong>₹160</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Andhra Meals">
                        <div class="food-image"><img src="images/menu/afternoon/banana_leaf.jfif" alt="Andhra Meals"></div>
                        <div class="food-info">
                            <h3>Andhra Meals</h3>
                            <p>Traditional Andhra-style lunch</p>
                            <div class="food-bottom"><strong>₹180</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="South Indian Meals">
                        <div class="food-image"><img src="images/menu/afternoon/thali.jfif" alt="South Indian Meals"></div>
                        <div class="food-info">
                            <h3>South Indian Meals</h3>
                            <p>Complete traditional South Indian meal</p>
                            <div class="food-bottom"><strong>₹150</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Curry">
                        <div class="food-image"><img src="images/menu/afternoon/chicken_curry.jfif" alt="Chicken Curry"></div>
                        <div class="food-info">
                            <h3>Chicken Curry</h3>
                            <p>Spicy home-style chicken curry</p>
                            <div class="food-bottom"><strong>₹210</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Paneer Butter Masala">
                        <div class="food-image"><img src="images/menu/afternoon/panner_curry.jfif" alt="Paneer Butter Masala"></div>
                        <div class="food-info">
                            <h3>Paneer Butter Masala</h3>
                            <p>Creamy paneer in rich tomato gravy</p>
                            <div class="food-bottom"><strong>₹190</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Fried Rice">
                        <div class="food-image"><img src="images/menu/afternoon/chicken_fried_rice.jfif" alt="Chicken Fried Rice"></div>
                        <div class="food-info">
                            <h3>Chicken Fried Rice</h3>
                            <p>Wok-tossed rice with chicken</p>
                            <div class="food-bottom"><strong>₹200</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Veg Fried Rice">
                        <div class="food-image"><img src="images/menu/afternoon/veg_fried_rice.jfif" alt="Veg Fried Rice"></div>
                        <div class="food-info">
                            <h3>Veg Fried Rice</h3>
                            <p>Wok-tossed rice with vegetables</p>
                            <div class="food-bottom"><strong>₹160</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Fish Curry Rice">
                        <div class="food-image"><img src="images/menu/afternoon/fish_curry.jfif" alt="Fish Curry Rice"></div>
                        <div class="food-info">
                            <h3>Fish Curry Rice</h3>
                            <p>Coastal fish curry with steamed rice</p>
                            <div class="food-bottom"><strong>₹230</strong></div>
                        </div>
                    </article>

                </div>
            </div>
        </section>

        <!-- ================= EVENING SNACKS ================= -->
        <section class="food-section">
            <div class="section-heading">
                <div>
                    <p class="section-label">EVENING CRAVINGS</p>
                    <h2>Evening Snacks</h2>
                </div>
                <div class="section-controls">
                    <button class="scroll-button" data-target="eveningTrack" data-direction="left" type="button">←</button>
                    <button class="scroll-button" data-target="eveningTrack" data-direction="right" type="button">→</button>
                </div>
            </div>

            <div class="food-track-wrapper">
                <div class="food-track" id="eveningTrack">

                    <article class="food-card" data-item="Samosa">
                        <div class="food-image"><img src="images/menu/evening/samosa.jfif" alt="Samosa"></div>
                        <div class="food-info">
                            <h3>Samosa</h3>
                            <p>Crispy pastry filled with spiced potato</p>
                            <div class="food-bottom"><strong>₹45</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Onion Pakoda">
                        <div class="food-image"><img src="images/menu/evening/Onion Pakoda 🇮🇳.jfif" alt="Onion Pakoda"></div>
                        <div class="food-info">
                            <h3>Onion Pakoda</h3>
                            <p>Crispy onion fritters with spices</p>
                            <div class="food-bottom"><strong>₹70</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Mysore Bonda">
                        <div class="food-image"><img src="images/menu/evening/bonda.jfif" alt="Mysore Bonda"></div>
                        <div class="food-info">
                            <h3>Mysore Bonda</h3>
                            <p>Soft fluffy fried South Indian snack</p>
                            <div class="food-bottom"><strong>₹65</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Gobi Manchurian">
                        <div class="food-image"><img src="images/menu/evening/gobi.jfif" alt="Gobi Manchurian"></div>
                        <div class="food-info">
                            <h3>Gobi Manchurian</h3>
                            <p>Crispy cauliflower in Indo-Chinese sauce</p>
                            <div class="food-bottom"><strong>₹130</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken 65">
                        <div class="food-image"><img src="images/menu/evening/chicken65.jfif" alt="Chicken 65"></div>
                        <div class="food-info">
                            <h3>Chicken 65</h3>
                            <p>Crispy spicy fried chicken bites</p>
                            <div class="food-bottom"><strong>₹180</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Paneer Tikka">
                        <div class="food-image"><img src="images/menu/evening/tikka.jfif" alt="Paneer Tikka"></div>
                        <div class="food-info">
                            <h3>Paneer Tikka</h3>
                            <p>Char-grilled paneer with Indian spices</p>
                            <div class="food-bottom"><strong>₹190</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="French Fries">
                        <div class="food-image"><img src="images/menu/evening/french fries.jfif" alt="French Fries"></div>
                        <div class="food-info">
                            <h3>French Fries</h3>
                            <p>Golden crispy seasoned fries</p>
                            <div class="food-bottom"><strong>₹120</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Veg Sandwich">
                        <div class="food-image"><img src="images/menu/evening/Sandwich.jfif" alt="Veg Sandwich"></div>
                        <div class="food-info">
                            <h3>Veg Sandwich</h3>
                            <p>Grilled sandwich with fresh vegetables</p>
                            <div class="food-bottom"><strong>₹110</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Sandwich">
                        <div class="food-image"><img src="images/menu/evening/chicken_sand.jfif" alt="Chicken Sandwich"></div>
                        <div class="food-info">
                            <h3>Chicken Sandwich</h3>
                            <p>Grilled chicken with fresh vegetables</p>
                            <div class="food-bottom"><strong>₹160</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Burger">
                        <div class="food-image"><img src="images/menu/evening/chiken_burger.jfif" alt="Burger"></div>
                        <div class="food-info">
                            <h3>Burger</h3>
                            <p>Juicy burger with fresh toppings</p>
                            <div class="food-bottom"><strong>₹180</strong></div>
                        </div>
                    </article>

                </div>
            </div>
        </section>

        <!-- ================= NIGHT FOOD ================= -->
        <section class="food-section">
            <div class="section-heading">
                <div>
                    <p class="section-label">LATE NIGHT CRAVINGS</p>
                    <h2>Night Food</h2>
                </div>
                <div class="section-controls">
                    <button class="scroll-button" data-target="nightTrack" data-direction="left" type="button">←</button>
                    <button class="scroll-button" data-target="nightTrack" data-direction="right" type="button">→</button>
                </div>
            </div>

            <div class="food-track-wrapper">
                <div class="food-track" id="nightTrack">

                    <article class="food-card" data-item="Hyderabadi Biryani">
                        <div class="food-image"><img src="images/menu/night/hyd_biryani.jfif" alt="Hyderabadi Biryani"></div>
                        <div class="food-info">
                            <h3>Hyderabadi Biryani</h3>
                            <p>Aromatic rice with spicy chicken</p>
                            <div class="food-bottom"><strong>₹230</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Shawarma">
                        <div class="food-image"><img src="images/menu/night/Shawarma.jfif" alt="Chicken Shawarma"></div>
                        <div class="food-info">
                            <h3>Chicken Shawarma</h3>
                            <p>Juicy chicken wrapped with fresh salad</p>
                            <div class="food-bottom"><strong>₹160</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Kebab">
                        <div class="food-image"><img src="images/menu/night/kabab.jfif" alt="Chicken Kebab"></div>
                        <div class="food-info">
                            <h3>Chicken Kebab</h3>
                            <p>Char-grilled chicken kebab</p>
                            <div class="food-bottom"><strong>₹200</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Tandoori Chicken">
                        <div class="food-image"><img src="images/menu/night/tandoori.jfif" alt="Tandoori Chicken"></div>
                        <div class="food-info">
                            <h3>Tandoori Chicken</h3>
                            <p>Classic smoky tandoori chicken</p>
                            <div class="food-bottom"><strong>₹280</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Butter Chicken">
                        <div class="food-image"><img src="images/menu/night/butter_chicken.jfif" alt="Butter Chicken"></div>
                        <div class="food-info">
                            <h3>Butter Chicken</h3>
                            <p>Creamy tomato butter chicken</p>
                            <div class="food-bottom"><strong>₹240</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Noodles">
                        <div class="food-image"><img src="images/menu/night/Noodles.jfif" alt="Chicken Noodles"></div>
                        <div class="food-info">
                            <h3>Chicken Noodles</h3>
                            <p>Wok-tossed noodles with chicken</p>
                            <div class="food-bottom"><strong>₹190</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Fried Rice">
                        <div class="food-image"><img src="images/menu/night/Chicken Fried .jfif" alt="Chicken Fried Rice"></div>
                        <div class="food-info">
                            <h3>Chicken Fried Rice</h3>
                            <p>Smoky wok-fried rice with chicken</p>
                            <div class="food-bottom"><strong>₹200</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Pizza">
                        <div class="food-image"><img src="images/menu/night/pizza.jfif" alt="Pizza"></div>
                        <div class="food-info">
                            <h3>Pizza</h3>
                            <p>Freshly baked cheesy pizza</p>
                            <div class="food-bottom"><strong>₹220</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Burger">
                        <div class="food-image"><img src="images/menu/night/sandwitch_bugert.jfif" alt="Chicken Burger"></div>
                        <div class="food-info">
                            <h3>Chicken Burger</h3>
                            <p>Juicy chicken patty with fresh toppings</p>
                            <div class="food-bottom"><strong>₹190</strong></div>
                        </div>
                    </article>

                    <article class="food-card" data-item="Chicken Momos">
                        <div class="food-image"><img src="images/menu/night/momos.jfif" alt="Chicken Momos"></div>
                        <div class="food-info">
                            <h3>Chicken Momos</h3>
                            <p>Steamed momos with spicy dip</p>
                            <div class="food-bottom"><strong>₹150</strong></div>
                        </div>
                    </article>

                </div>
            </div>
        </section>

    </main>

    <!-- ================= FOOTER ================= -->
    <footer class="footer">

        <div class="footer-container">

            <div class="footer-brand">
                <a href="index.jsp" class="logo footer-logo">
                    <span class="logo-mark">FO</span>
                    <span class="logo-text">Food<span>ora</span></span>
                </a>
                <p>Delicious food from your favourite restaurants, delivered to your door.</p>
            </div>

            <div class="footer-column">
                <h4>Quick Links</h4>
                <a href="index.jsp">Home</a>
                <a href="restaurant">Restaurants</a>
                <a href="myOrders">My Orders</a>
                <a href="cart">Cart</a>
            </div>

            <div class="footer-column">
                <h4>Customer</h4>
                <a href="#">Help &amp; Support</a>
                <a href="#">Contact Us</a>
                <a href="#">Privacy</a>
                <a href="#">Terms</a>
            </div>

            <div class="footer-column">
                <h4>Follow Us</h4>
                <a href="#">Instagram</a>
                <a href="#">Facebook</a>
                <a href="#">LinkedIn</a>
            </div>

        </div>

        <div class="footer-bottom">
            <p>© 2026 Foodora. All rights reserved.</p>
            <p>Made for food lovers.</p>
        </div>

    </footer>

    <script src="home.js"></script>

</body>
</html>
