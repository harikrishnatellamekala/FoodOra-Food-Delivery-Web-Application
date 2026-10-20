package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;


import com.tap.dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

    private static final String INSERT_QUERY =
            "INSERT INTO orders " +
            "(userId, restaurantId, orderDate, totalAmount, status, paymentMode) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String READ_QUERY =
            "SELECT * FROM orders WHERE orderId = ?";

    private static final String SELECT_QUERY =
            "SELECT * FROM orders";

    private static final String USER_ORDERS_QUERY =
            "SELECT * FROM orders WHERE userId = ?";

    private static final String RESTAURANT_ORDERS_QUERY =
            "SELECT * FROM orders WHERE restaurantId = ?";

    private static final String UPDATE_QUERY =
            "UPDATE orders SET " +
            "userId = ?, " +
            "restaurantId = ?, " +
            "orderDate = ?, " +
            "totalAmount = ?, " +
            "status = ?, " +
            "paymentMode = ? " +
            "WHERE orderId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM orders WHERE orderId = ?";


    

@Override
public int addOrder(Order order) {

    int generatedOrderId = -1;

    try (
        Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(
            INSERT_QUERY,
            Statement.RETURN_GENERATED_KEYS
        )
    ) {

        statement.setInt(1, order.getUserId());
        statement.setInt(2, order.getRestaurantId());
        statement.setTimestamp(3, order.getOrderDate());
        statement.setDouble(4, order.getTotalAmount());
        statement.setString(5, order.getStatus());
        statement.setString(6, order.getPaymentMode());

        int rowsInserted = statement.executeUpdate();

        if (rowsInserted > 0) {

            try (ResultSet resultSet = statement.getGeneratedKeys()) {

                if (resultSet.next()) {

                    generatedOrderId = resultSet.getInt(1);

                    order.setOrderId(generatedOrderId);
                }
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return generatedOrderId;
}



    @Override
    public Order getOrder(int orderId) {

        Order order = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_QUERY)
        ) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                order = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }


    @Override
    public List<Order> getAllOrders() {

        List<Order> orderList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {
                orderList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }


    @Override
    public List<Order> getOrdersByUser(int userId) {

        List<Order> orderList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt =
                        con.prepareStatement(USER_ORDERS_QUERY)
        ) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }


    @Override
    public List<Order> getOrdersByRestaurant(int restaurantId) {

        List<Order> orderList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt =
                        con.prepareStatement(RESTAURANT_ORDERS_QUERY)
        ) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }


    @Override
    public void updateOrder(Order order) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)
        ) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setTimestamp(3, order.getOrderDate());
            pstmt.setDouble(4, order.getTotalAmount());
            pstmt.setString(5, order.getStatus());
            pstmt.setString(6, order.getPaymentMode());
            pstmt.setInt(7, order.getOrderId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrder(int orderId) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)
        ) {

            pstmt.setInt(1, orderId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private Order processResult(ResultSet rs) throws SQLException {

        int orderId = rs.getInt("orderId");
        int userId = rs.getInt("userId");
        int restaurantId = rs.getInt("restaurantId");
        Timestamp orderDate = rs.getTimestamp("orderDate");
        double totalAmount = rs.getDouble("totalAmount");
        String status = rs.getString("status");
        String paymentMode = rs.getString("paymentMode");

        return new Order(
                orderId,
                userId,
                restaurantId,
                orderDate,
                totalAmount,
                status,
                paymentMode
        );
    }
}