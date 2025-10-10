package com.tourism.controller;

import com.tourism.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CheckUsernameServlet")
public class CheckUsernameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        UserDAO userDAO = new UserDAO();
        boolean exists = userDAO.isUsernameExists(username);
        
        // Send a simple JSON response
        response.setContentType("application/json");
        response.getWriter().write("{\"exists\": " + exists + "}");
    }
}