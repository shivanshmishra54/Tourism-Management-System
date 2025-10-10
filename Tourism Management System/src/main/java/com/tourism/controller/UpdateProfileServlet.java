package com.tourism.controller;

import com.tourism.dao.UserDAO;
import com.tourism.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        // Pehle user ko current password se verify karein
        String currentPassword = request.getParameter("currentPassword");
        User validatedUser = userDAO.validateUser(user.getUsername(), currentPassword);

        if (validatedUser == null) {
            if ("updateEmail".equals(action)) {
                response.sendRedirect("myProfile.jsp?emailStatus=incorrect_password");
            } else if ("updatePassword".equals(action)) {
                response.sendRedirect("myProfile.jsp?passStatus=incorrect_password");
            }
            return;
        }

        // Action ke basis par update karein
        if ("updateEmail".equals(action)) {
            String newEmail = request.getParameter("newEmail");
            if (userDAO.updateEmail(user.getId(), newEmail)) {
                // Session mein bhi email update karein
                user.setEmail(newEmail);
                session.setAttribute("user", user);
                response.sendRedirect("myProfile.jsp?emailStatus=success");
            } else {
                response.sendRedirect("myProfile.jsp?emailStatus=update_failed");
            }
        } else if ("updatePassword".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("myProfile.jsp?passStatus=passwords_do_not_match");
                return;
            }

            if (userDAO.updatePassword(user.getId(), newPassword)) {
                response.sendRedirect("myProfile.jsp?passStatus=success");
            } else {
                response.sendRedirect("myProfile.jsp?passStatus=update_failed");
            }
        }
    }
}