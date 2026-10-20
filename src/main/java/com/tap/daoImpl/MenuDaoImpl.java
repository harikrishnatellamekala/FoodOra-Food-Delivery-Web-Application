package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDao;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

public class MenuDaoImpl implements MenuDao {

    private static final String INSERT_QUERY =
            "INSERT INTO menu " +
            "(restaurantId, itemName, description, price, isAvailable, imagePath) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String READ_QUERY =
            "SELECT * FROM menu WHERE menuId = ?";

    private static final String SELECT_QUERY =
            "SELECT * FROM menu";

    private static final String RESTAURANT_MENU_QUERY =
            "SELECT * FROM menu WHERE restaurantId = ?";

    private static final String UPDATE_QUERY =
            "UPDATE menu SET " +
            "restaurantId = ?, " +
            "itemName = ?, " +
            "description = ?, " +
            "price = ?, " +
            "isAvailable = ?, " +
            "imagePath = ? " +
            "WHERE menuId = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM menu WHERE menuId = ?";


    @Override
    public void addMenu(Menu menu) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)
        ) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public Menu getMenu(int menuId) {

        Menu menu = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_QUERY)
        ) {

            pstmt.setInt(1, menuId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                menu = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }


    @Override
    public List<Menu> getAllMenus() {

        List<Menu> menuList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {
                menuList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt =
                        con.prepareStatement(RESTAURANT_MENU_QUERY)
        ) {

            pstmt.setInt(1, restaurantId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                menuList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    @Override
    public void updateMenu(Menu menu) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)
        ) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());
            pstmt.setInt(7, menu.getMenuId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteMenu(int menuId) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)
        ) {

            pstmt.setInt(1, menuId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private Menu processResult(ResultSet rs) throws SQLException {

        int menuId = rs.getInt("menuId");
        int restaurantId = rs.getInt("restaurantId");
        String itemName = rs.getString("itemName");
        String description = rs.getString("description");
        double price = rs.getDouble("price");
        boolean isAvailable = rs.getBoolean("isAvailable");
        String imagePath = rs.getString("imagePath");

        return new Menu(
                menuId,
                restaurantId,
                itemName,
                description,
                price,
                isAvailable,
                imagePath
        );
    }
    
    
    @Override
    public Menu getMenuByItemName(String itemName) {

        if (itemName == null || itemName.trim().isEmpty()) {
            return null;
        }

        String sql =
            "SELECT * FROM menu " +
            "WHERE LOWER(itemName) LIKE LOWER(?) " +
            "ORDER BY " +
            "CASE WHEN LOWER(itemName) = LOWER(?) THEN 0 ELSE 1 END, " +
            "menuId ASC LIMIT 1";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, "%" + itemName.trim() + "%");
            ps.setString(2, itemName.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return processResult(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Unable to find homepage menu item", e);
        }

        return null;
    }
    
    
    
    @Override
    public List<Menu> searchMenus(String keyword) {

        List<Menu> results = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            return results;
        }

        String safe = keyword.trim()
                .replace("\\", "\\\\")
                .replace("%", "\\%")
                .replace("_", "\\_");

        String sql =
            "SELECT * FROM menu WHERE LOWER(itemName) LIKE LOWER(?) " +
            "ORDER BY CASE WHEN LOWER(itemName) LIKE LOWER(?) THEN 0 ELSE 1 END, " +
            "itemName ASC LIMIT 60";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, "%" + safe + "%");
            ps.setString(2, safe + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(processResult(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return results;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}