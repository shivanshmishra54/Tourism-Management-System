package com.tourism.controller;

import com.tourism.dao.BookingDAO;
import com.tourism.model.Booking;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        int packageId = Integer.parseInt(request.getParameter("packageId"));
        Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
        int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));

        Booking booking = new Booking();
        booking.setUserId(userId);
        booking.setPackageId(packageId);
        booking.setBookingDate(bookingDate);
        booking.setNumberOfGuests(numberOfGuests);

        BookingDAO bookingDAO = new BookingDAO();
        if (bookingDAO.addBooking(booking)) {
            // Redirect to a success page or my bookings page
            response.sendRedirect("myBookings.jsp?status=success");
        } else {
            // Handle failure
            response.sendRedirect("dashboard.jsp?status=failure");
        }
    }
}