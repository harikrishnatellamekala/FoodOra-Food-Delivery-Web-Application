package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDao;
import com.tap.model.Restaurant;
import com.tap.util.DBConnection;

public class RestaurantDaoImpl implements RestaurantDao {

    private static final String INSERT_QUERY =
            "INSERT INTO restaurant " +
            "(name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String READ_QUERY =
            "SELECT * FROM restaurant WHERE restaurantId = ?";

    private static final String SELECT_QUERY =
            "SELECT * FROM restaurant";

    private static final String ACTIVE_RESTAURANTS_QUERY =
            "SELECT * FROM restaurant WHERE isActive = ?";

    private static final String UPDATE_QUERY =
            "UPDATE restaurant SET " +
            "name = ?, " +
            "cuisineType = ?, " +
            "deliveryTime = ?, " +
            "address = ?, " +
            "adminUserId = ?, " +
            "rating = ?, " +
            "isActive = ?, " +
            "imagePath = ? " +
            "WHERE restaurantId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM restaurant WHERE restaurantId = ?";


    @Override
    public void addRestaurant(Restaurant restaurant) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)
        ) {

            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setInt(3, restaurant.getDeliveryTime());
            pstmt.setString(4, restaurant.getAddress());
            pstmt.setInt(5, restaurant.getAdminUserId());
            pstmt.setDouble(6, restaurant.getRating());
            pstmt.setBoolean(7, restaurant.isActive());
            pstmt.setString(8, restaurant.getImagePath());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_QUERY)
        ) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                restaurant = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }


    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {
                restaurantList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    @Override
    public List<Restaurant> getActiveRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt =
                        con.prepareStatement(ACTIVE_RESTAURANTS_QUERY)
        ) {

            pstmt.setBoolean(1, true);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                restaurantList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    @Override
    public void updateRestaurant(Restaurant restaurant) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)
        ) {

            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisineType());
            pstmt.setInt(3, restaurant.getDeliveryTime());
            pstmt.setString(4, restaurant.getAddress());
            pstmt.setInt(5, restaurant.getAdminUserId());
            pstmt.setDouble(6, restaurant.getRating());
            pstmt.setBoolean(7, restaurant.isActive());
            pstmt.setString(8, restaurant.getImagePath());
            pstmt.setInt(9, restaurant.getRestaurantId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteRestaurant(int restaurantId) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)
        ) {

            pstmt.setInt(1, restaurantId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private Restaurant processResult(ResultSet rs) throws SQLException {

        int restaurantId = rs.getInt("restaurantId");
        String name = rs.getString("name");
        String cuisineType = rs.getString("cuisineType");
        int deliveryTime = rs.getInt("deliveryTime");
        String address = rs.getString("address");
        int adminUserId = rs.getInt("adminUserId");
        double rating = rs.getDouble("rating");
        boolean isActive = rs.getBoolean("isActive");
        String imagePath = rs.getString("imagePath");

        return new Restaurant(
                restaurantId,
                name,
                cuisineType,
                deliveryTime,
                address,
                adminUserId,
                rating,
                isActive,
                imagePath
        );
    }
}