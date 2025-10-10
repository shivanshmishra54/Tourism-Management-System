package com.tourism.dao;

import com.tourism.model.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Method to add a new booking
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, package_id, booking_date, number_of_guests) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, booking.getUserId());
            pstmt.setInt(2, booking.getPackageId());
            pstmt.setDate(3, booking.getBookingDate());
            pstmt.setInt(4, booking.getNumberOfGuests());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to get all bookings for a specific user
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookingList = new ArrayList<>();
        // Join bookings and packages table to get package name and price
        String sql = "SELECT b.*, p.name, p.price FROM bookings b JOIN packages p ON b.package_id = p.id WHERE b.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setPackageId(rs.getInt("package_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setStatus(rs.getString("status"));
                booking.setNumberOfGuests(rs.getInt("number_of_guests"));
                booking.setPackageName(rs.getString("name"));
                booking.setPackagePrice(rs.getDouble("price"));
                bookingList.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookingList;
    }
}