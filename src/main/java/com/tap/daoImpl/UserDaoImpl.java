package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDao;
import com.tap.model.User;
import com.tap.util.DBConnection;

public class UserDaoImpl implements UserDao {

    private static final String INSERT_QUERY =
            "INSERT INTO `user` " +
            "(`username`, `password`, `email`, `phone`, `address`, `role`) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String READ_QUERY =
            "SELECT * FROM `user` WHERE `userId` = ?";

    private static final String READ_BY_EMAIL_QUERY =
            "SELECT * FROM `user` WHERE `email` = ?";

    private static final String SELECT_QUERY =
            "SELECT * FROM `user`";

    private static final String UPDATE_QUERY =
            "UPDATE `user` SET " +
            "`username` = ?, " +
            "`password` = ?, " +
            "`email` = ?, " +
            "`phone` = ?, " +
            "`address` = ?, " +
            "`role` = ? " +
            "WHERE `userId` = ?";

    private static final String DELETE_QUERY =
            "DELETE FROM `user` WHERE `userId` = ?";


    @Override
    public void addUser(User user) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)
        ) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public User getUser(int userId) {

        User user = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_QUERY)
        ) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    @Override
    public User getUserByEmail(String email) {

        User user = null;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(READ_BY_EMAIL_QUERY)
        ) {

            pstmt.setString(1, email);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = processResult(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    @Override
    public List<User> getAllUsers() {

        List<User> userList = new ArrayList<>();

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY);
                ResultSet rs = pstmt.executeQuery()
        ) {

            while (rs.next()) {
                userList.add(processResult(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }


    @Override
    public void updateUser(User user) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)
        ) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setInt(7, user.getUserId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteUser(int userId) {

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)
        ) {

            pstmt.setInt(1, userId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private User processResult(ResultSet rs) throws SQLException {

        int userId = rs.getInt("userId");
        String username = rs.getString("username");
        String password = rs.getString("password");
        String email = rs.getString("email");
        String phone = rs.getString("phone");
        String address = rs.getString("address");
        String role = rs.getString("role");

        return new User(
                userId,
                username,
                password,
                email,
                phone,
                address,
                role
        );
    }
}