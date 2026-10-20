package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

public class OrderItemDaoImpl implements OrderItemDao {

    private static final String INSERT_QUERY =
            "INSERT INTO orderItem " +
            "(orderId, menuId, totalAmount) " +
            "VALUES (?, ?, ?)";

    private static final String READ_QUERY =
            "SELECT * FROM orderItem WHERE orderItemId = ?";

    private static final String SELECT_QUERY =
            "SELECT * FROM orderItem";

    private static final String ORDER_ITEMS_QUERY =
            "SELECT * FROM orderItem WHERE orderId = ?";

    private static final String UPDATE_QUERY =
            "UPDATE orderItem SET " +
            "orderId = ?, " +
            "menuId = ?, " +
            "totalAmount = ? " +
            "WHERE orderItemId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM orderItem WHERE orderItemId = ?";


    @Override
    public void addOrderItem(OrderItem orderItem) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)
        ) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setDouble(3, orderItem.getTotalAmount());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public OrderItem getOrderItem(int orderItemId) {

        OrderItem orderItem = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_QUERY)
        ) {

            pstmt.setInt(1, orderItemId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                orderItem = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }


    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItemList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {
                orderItemList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }


    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {

        List<OrderItem> orderItemList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt =
                        con.prepareStatement(ORDER_ITEMS_QUERY)
        ) {

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderItemList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }


    @Override
    public void updateOrderItem(OrderItem orderItem) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)
        ) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setDouble(3, orderItem.getTotalAmount());
            pstmt.setInt(4, orderItem.getOrderItemId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrderItem(int orderItemId) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)
        ) {

            pstmt.setInt(1, orderItemId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private OrderItem processResult(ResultSet rs) throws SQLException {

        int orderItemId = rs.getInt("orderItemId");
        int orderId = rs.getInt("orderId");
        int menuId = rs.getInt("menuId");
        double totalAmount = rs.getDouble("totalAmount");

        return new OrderItem(
                orderItemId,
                orderId,
                menuId,
                totalAmount
        );
    }
}