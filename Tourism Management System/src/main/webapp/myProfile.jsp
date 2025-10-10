<%@ page import="com.tourism.model.User" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    // Get success/error messages from URL
    String emailStatus = request.getParameter("emailStatus");
    String passStatus = request.getParameter("passStatus");
%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Global Explorers</title>
    <link rel="stylesheet" href="css/styles.css">
     <script src="js/theme-loader.js"></script>
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
    <li><a href="myBookings.jsp" class="active"><i class="fas fa-briefcase icon"></i> My Bookings</a></li>
    <li><a href="settings.jsp"><i class="fas fa-cog icon"></i> Settings</a></li>
</ul>
        <div class="logout-link">
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt icon"></i> Logout</a>
        </div>
    </aside>

    <div class="main-content">
        <h1>My Profile</h1>

        <div class="form-container" style="max-width: 700px; margin: 0; margin-bottom: 40px;">
            <h2>Update Email</h2>
            <% if (emailStatus != null) { %>
                <% if ("success".equals(emailStatus)) { %>
                    <div style="color: green; margin-bottom: 15px;">Email updated successfully!</div>
                <% } else { %>
                    <div style="color: red; margin-bottom: 15px;">Error: <%= emailStatus.replace("_", " ") %>.</div>
                <% } %>
            <% } %>

            <form action="UpdateProfileServlet" method="post">
                <input type="hidden" name="action" value="updateEmail">
                <div class="input-group">
                    <label>Current Email</label>
                    <input type="email" value="<%= user.getEmail() %>" disabled>
                </div>
                <div class="input-group">
                    <label for="newEmail">New Email</label>
                    <input type="email" id="newEmail" name="newEmail" required>
                </div>
                <div class="input-group">
                    <label for="currentPasswordForEmail">Current Password (for verification)</label>
                    <input type="password" id="currentPasswordForEmail" name="currentPassword" required>
                </div>
                <button type="submit" class="btn btn-primary">Update Email</button>
            </form>
        </div>

        <div class="form-container" style="max-width: 700px; margin: 0;">
            <h2>Change Password</h2>
             <% if (passStatus != null) { %>
                <% if ("success".equals(passStatus)) { %>
                    <div style="color: green; margin-bottom: 15px;">Password changed successfully!</div>
                <% } else { %>
                    <div style="color: red; margin-bottom: 15px;">Error: <%= passStatus.replace("_", " ") %>.</div>
                <% } %>
            <% } %>
            <form action="UpdateProfileServlet" method="post">
                <input type="hidden" name="action" value="updatePassword">
                <div class="input-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                </div>
                <div class="input-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>
                <div class="input-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary">Change Password</button>
            </form>
        </div>
    </div>
</body>
</html>