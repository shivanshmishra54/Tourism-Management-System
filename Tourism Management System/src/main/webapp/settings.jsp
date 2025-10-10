<%@ page import="com.tourism.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Theme toggle switch style */
        .theme-switch-wrapper {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }
        .theme-switch {
            display: inline-block;
            height: 34px;
            position: relative;
            width: 60px;
        }
        .theme-switch input { display: none; }
        .slider {
            background-color: #ccc;
            bottom: 0;
            cursor: pointer;
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            transition: .4s;
        }
        .slider:before {
            background-color: #fff;
            bottom: 4px;
            content: "";
            height: 26px;
            left: 4px;
            position: absolute;
            transition: .4s;
            width: 26px;
        }
        input:checked + .slider { background-color: var(--primary-color); }
        input:checked + .slider:before { transform: translateX(26px); }
        .slider.round { border-radius: 34px; }
        .slider.round:before { border-radius: 50%; }
        .theme-switch-wrapper em { margin-left: 10px; font-size: 1rem; }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="profile">
            <img src="https://i.pravatar.cc/150?u=<%= user.getEmail() %>" alt="User Profile">
            <h3><%= user.getFirstname() + " " + user.getLastname() %></h3>
            <p><%= user.getEmail() %></p>
        </div>
        <ul class="nav-menu">
            <li><a href="dashboard.jsp"><i class="fas fa-tachometer-alt icon"></i> Dashboard</a></li>
            <li><a href="myProfile.jsp"><i class="fas fa-user icon"></i> My Profile</a></li>
            <li><a href="myBookings.jsp"><i class="fas fa-briefcase icon"></i> My Bookings</a></li>
            <li><a href="settings.jsp" class="active"><i class="fas fa-cog icon"></i> Settings</a></li>
        </ul>
        <div class="logout-link">
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt icon"></i> Logout</a>
        </div>
    </aside>

    <div class="main-content">
        <h1>Settings</h1>
        <div class="form-container" style="max-width: 700px; margin: 0;">
            <h2>Appearance</h2>
            <div class="theme-switch-wrapper">
                <label class="theme-switch" for="checkbox">
                    <input type="checkbox" id="checkbox" />
                    <div class="slider round"></div>
                </label>
                <em>Enable Dark Mode</em>
            </div>
        </div>
    </div>
    
    <script src="js/settings.js"></script>
</body>
</html>