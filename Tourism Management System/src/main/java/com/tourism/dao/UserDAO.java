package com.tourism.dao;

import com.tourism.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /**
     * Registers a new user in the database with all the required fields.
     * @param user The User object containing registration details.
     * @return boolean True if registration is successful, false otherwise.
     */
    public boolean registerUser(User user) {
        // UPDATED: SQL statement now includes all new columns
        String sql = "INSERT INTO users (firstname, lastname, username, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Set all parameters from the User object
            pstmt.setString(1, user.getFirstname());
            pstmt.setString(2, user.getLastname());
            pstmt.setString(3, user.getUsername());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPhone());
            // In a real application, you MUST hash the password before storing it.
            pstmt.setString(6, user.getPassword()); 

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validates a user's login credentials using either username or email.
     * @param loginIdentifier The user's username OR email.
     * @param password The user's password.
     * @return User The User object if credentials are valid, null otherwise.
     */
    public User validateUser(String loginIdentifier, String password) {
        User user = null;
        // UPDATED: SQL query now checks both username and email columns
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the loginIdentifier for both possible columns
            pstmt.setString(1, loginIdentifier);
            pstmt.setString(2, loginIdentifier);
            pstmt.setString(3, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    // Populate the entire User object with data from the database
                    user.setId(rs.getInt("id"));
                    user.setFirstname(rs.getString("firstname"));
                    user.setLastname(rs.getString("lastname"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    // Do NOT set the password in the user object for security
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * Checks if a specific username already exists in the database.
     * This method remains correct and is used for real-time validation.
     * @param username The username to check.
     * @return boolean True if the username exists, false otherwise.
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Returns true if count > 0
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
 // UserDAO.java file mein yeh methods add karein

    /**
     * Updates the user's email in the database.
     * @param userId The ID of the user to update.
     * @param newEmail The new email address.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updateEmail(int userId, String newEmail) {
        String sql = "UPDATE users SET email = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newEmail);
            pstmt.setInt(2, userId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates the user's password in the database.
     * @param userId The ID of the user to update.
     * @param newPassword The new password.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Yahan password ko plain text mein save kiya ja raha hai aapke request ke anusaar.
            // Production environment ke liye hashing zaroori hai.
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}