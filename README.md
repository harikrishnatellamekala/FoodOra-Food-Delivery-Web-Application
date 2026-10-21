# 🍽️ Foodora – Food Delivery Web Application

A full-stack food delivery platform where users can browse restaurants, search dishes, add items to a cart, pay, and track their orders. Built from scratch with **Java Servlets, JSP, JDBC and MySQL** using a clean **MVC + DAO** architecture.

![Java](https://img.shields.io/badge/Java-21-orange) ![Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow) ![MySQL](https://img.shields.io/badge/MySQL-8-blue) ![JSP](https://img.shields.io/badge/JSP-Servlets-green)

> 
> 🎥 **Demo video:** `https://drive.google.com/file/d/1RjBl8r0Rtt0BN_Y36OxyIhj8WNpnuSpt/view?usp=sharing`

---

## 📌 Table of Contents
1. [Features](#-features)
2. [Tech Stack](#-tech-stack)
3. [Architecture](#-architecture)
4. [Project Structure](#-project-structure)
5. [Application Flow](#-application-flow)
6. [URL Routes](#-url-routes)
7. [Database Design](#-database-design)
8. [Getting Started](#-getting-started)
9. [3D UI Redesign](#-3d-ui-redesign)
10. [Future Improvements](#-future-improvements)
11. [What I Learned](#-what-i-learned)
12. [Author](#-author)

---

## ✨ Features

- **User accounts** – Register, login and logout with session management
- **Smart redirect** – If a logged-out user tries to pay, they are sent to login and brought back to exactly where they left off (`returnUrl`)
- **Restaurants** – Browse restaurants with cuisine, rating and delivery time
- **Menu** – View dishes per restaurant
- **Search** – Case-insensitive dish search
- **Cart** – Add, update and remove items
- **Payment** – UPI, Card and Cash on Delivery options with a bill breakdown (Item Total, Delivery Fee, Platform Fee, Total)
- **Orders** – Order confirmation, My Orders list and order tracking
- **Profile** – View registered account details
- **Responsive UI** – Works on desktop and mobile

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Java 21 |
| Backend | Servlets, JSP, JDBC |
| Server | Apache Tomcat 10.1 |
| Database | MySQL (`mysql-connector-j 9.2.0`) |
| Frontend | HTML, CSS, JavaScript |
| IDE | Eclipse (Dynamic Web Project) |

## 🏛️ Architecture

The project follows the **MVC** pattern with a separate **DAO layer** for database access.

```
Browser ──▶ Controller (Servlet) ──▶ DAO ──▶ MySQL
   ▲              │
   └──── JSP ◀────┘   (Model objects passed to the view)
```

| Layer | Package / Folder | Responsibility |
|-------|------------------|----------------|
| **Model** | `com.tap.model` | Plain Java objects: `User`, `Restaurant`, `Menu`, `Cart`, `CartItem`, `Order`, `OrderItem` |
| **View** | `webapp/*.jsp` | Pages the user sees |
| **Controller** | `com.tap.controller` | Servlets that handle requests, sessions and navigation |
| **DAO (interfaces)** | `com.tap.dao` | Contracts for database operations |
| **DAO (implementations)** | `com.tap.daoImpl` | JDBC code using `PreparedStatement` (protects against SQL injection) |
| **Util** | `com.tap.util` | `DBConnection` – creates the database connection |

## 📂 Project Structure

```
foodora/
├── src/main/java/com/tap/
│   ├── controller/   # Cart, ConfirmOrder, Home, Login, Logout, Menu, OrderTracking,
│   │                 # Payment, Proceed, Profile, Register, Restaurant, Search
│   ├── dao/          # UserDao, RestaurantDao, MenuDao, OrderDao, OrderItemDao
│   ├── daoImpl/      # JDBC implementations of the DAO interfaces
│   ├── model/        # User, Restaurant, Menu, Cart, CartItem, Order, OrderItem
│   └── util/         # DBConnection
└── src/main/webapp/
    ├── index.jsp, Login.jsp, Register.jsp, restaurant.jsp, Menu.jsp, Search.jsp
    ├── Cart.jsp, Payment.jsp, OrderConfirmation.jsp, Orders.jsp, OrderTracking.jsp
    ├── Profile.jsp, Navbar.jsp          # Navbar.jsp is shared across pages
    ├── *.css, *.js                      # Styles and scripts
    ├── images/                          # Restaurant and menu images
    └── WEB-INF/web.xml
```

## 🔄 Application Flow

```
Home ─▶ Restaurants ─▶ Menu ─▶ Cart ─▶ Proceed ─▶ Payment ─▶ Order Confirmation ─▶ My Orders / Tracking
                                          │
                              (not logged in?)
                                          ▼
                                Login ──▶ back to Payment
```

1. The user browses restaurants and opens a menu.
2. Items are added to the cart, which is stored in the session.
3. On **Proceed to Pay**, the app checks the session. If there is no logged-in user, it redirects to `/login?returnUrl=...`.
4. After login, the user returns to the payment page and picks UPI, Card or COD.
5. **Confirm Order** saves the order and its items in the database and opens the confirmation and tracking pages.

## 🌐 URL Routes

| URL | Controller | Purpose |
|-----|------------|---------|
| `/home` | HomeController | Home page |
| `/register` | RegisterController | Create an account |
| `/login` | LoginController | Login (supports `returnUrl`) |
| `/logout` | LogoutController | End the session |
| `/restaurant` | RestaurantController | List restaurants |
| `/menu` | MenuController | Show a restaurant's menu |
| `/search` | SearchController | Search dishes |
| `/cart` | CartController | Manage the cart |
| `/proceed` | ProceedController | Login check before payment |
| `/payment` | PaymentController | Payment page |
| `/confirmOrder` | ConfirmOrderController | Save the order |
| `/orderTracking`, `/myOrders` | OrderTrackingController | Order tracking and history |
| `/profile` | ProfileController | User profile |

## 🗄️ Database Design

Database name: `foodora`

| Table | Main columns |
|-------|--------------|
| `user` | userId, username, password, email (unique), phone, address, role |
| `restaurant` | restaurantId, name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath |
| `menu` | menuId, restaurantId, itemName, description, price, isAvailable, imagePath |
| `orders` | orderId, userId, restaurantId, orderDate, totalAmount, status, paymentMode |
| `orderItem` | orderItemId, orderId, menuId, totalAmount |

**Relationships:** a user places many orders · a restaurant has many menu items · an order has many order items · each order item points to a menu item.

## 🚀 Getting Started

### Prerequisites
- JDK 21
- Apache Tomcat 10.1
- MySQL 8 or later
- Eclipse IDE for Enterprise Java (or any IDE that supports Dynamic Web Projects)

### Setup
1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/foodora.git
   ```
2. **Create the database**
   ```sql
   CREATE DATABASE foodora;
   ```
   Then create the tables listed in [Database Design](#-database-design) and add some sample restaurants and menu items.
3. **Configure the connection** – open `src/main/java/com/tap/util/DBConnection.java` and set your own MySQL URL, username and password.
4. **Import the project** – in Eclipse, choose *File → Import → Existing Projects into Workspace*.
5. **Add the MySQL driver** – make sure `mysql-connector-j` is on the build path and in `WEB-INF/lib`.
6. **Run** – right-click the project → *Run As → Run on Server* → Tomcat 10.1.
7. Open `http://localhost:8080/foodora/`

## 🎨 3D UI Redesign

I also designed a **3D hub-style interface**: soft light background, glowing slab cards, ribbed pipes with animated light, and a central hub. It covers Home, Restaurants, Menu, Cart, Login, Payment and My Orders as a clickable **frontend prototype** (HTML, CSS, JavaScript), separate from the Java backend.

📸 *Add screenshots here:* `docs/home.png`, `docs/menu.png`, `docs/orders.png`

## 🔮 Future Improvements

- [ ] Hash passwords (BCrypt) instead of plain text
- [ ] Move database credentials to environment variables or a config file
- [ ] Add real payment gateway integration
- [ ] Live order status updates (admin / delivery partner panel)
- [ ] Input validation and server-side error pages
- [ ] Connection pooling (HikariCP)
- [ ] Unit tests for the DAO layer
- [ ] Connect the 3D UI to the Java backend

## 📚 What I Learned

This is the first backend I wrote and fully understood on my own. Key takeaways:

- How a request travels: **Browser → Servlet → DAO → Database → JSP**
- Session handling and safe redirects after login
- Separating concerns with MVC and the DAO pattern
- Using `PreparedStatement` to write safer SQL
- Thinking in user flows, not just individual pages

## 👤 Author

**<Your Name>**
💼 LinkedIn: `www.linkedin.com/in/tellamekala-harikrishna`
📧 Email: `harikrishnatellamekala1@gmail.com`


⭐ If you like this project, give it a star!
