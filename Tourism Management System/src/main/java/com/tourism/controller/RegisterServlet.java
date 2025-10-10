package com.tourism.controller;

import com.tourism.dao.UserDAO;
import com.tourism.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        UserDAO userDAO = new UserDAO();

        // Check if username already exists
        if (userDAO.isUsernameExists(username)) {
            // UPDATED: Redirect back to signup.html with a specific error message in the URL
            response.sendRedirect("signup.html?error=username_taken");
        } else {
            // If username is unique, proceed with registration
            User user = new User();
            user.setFirstname(request.getParameter("firstName"));
            user.setLastname(request.getParameter("lastName"));
            user.setUsername(username);
            user.setEmail(request.getParameter("email"));
            user.setPhone(request.getParameter("phone"));
            user.setPassword(request.getParameter("password"));

            boolean isRegistered = userDAO.registerUser(user);

            if (isRegistered) {
                // Redirect to login page on success
                response.sendRedirect("login.html");
            } else {
                // UPDATED: Redirect back to signup.html with a generic failure message
                response.sendRedirect("signup.html?error=registration_failed");
            }
        }
    }
}