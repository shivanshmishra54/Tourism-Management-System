<%@ page import="com.tourism.model.User, com.tourism.dao.PackageDAO, com.tourism.model.Package, java.util.List" %>
<%
    // --- SECURITY CHECK ---
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    // --- Data Fetching ---
    PackageDAO packageDAO = new PackageDAO();
    List<Package> packages = packageDAO.getAllPackages();
%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Global Explorers</title>
    <script src="js/theme-loader.js"></script>
    <link rel="stylesheet" href="css/styles.css"> 
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
            <li><a href="dashboard.jsp" class="active"><i class="fas fa-tachometer-alt icon"></i> Dashboard</a></li>
            <li><a href="myProfile.jsp"><i class="fas fa-user icon"></i> My Profile</a></li>
            <li><a href="myBookings.jsp"><i class="fas fa-briefcase icon"></i> My Bookings</a></li>
            <li><a href="settings.jsp"><i class="fas fa-cog icon"></i> Settings</a></li>
        </ul>
        <div class="logout-link">
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt icon"></i> Logout</a>
        </div>
    </aside>

    <div class="main-content">
        <h1>Explore Tour Packages</h1>
        <input type="text" id="search-bar" class="search-bar" placeholder="Search for packages by name or description...">

        <div class="package-grid">
            <% for (Package pkg : packages) { %>
                <div class="package-card">
                    <img src="<%= pkg.getImageUrl() != null ? pkg.getImageUrl() : "https://via.placeholder.com/400x250.png?text=Tour+Image" %>" alt="<%= pkg.getName() %>">
                    <div class="card-content">
                        <h3><%= pkg.getName() %></h3>
                        <p class="description"><%= pkg.getDescription() %></p>
                        
                        <div class="details">
                            <div class="price">₹<%= String.format("%,.2f", pkg.getPrice()) %></div>
                            <div class="duration"><i class="fas fa-clock"></i> <%= pkg.getDurationDays() %> Days</div>
                        </div>
    
                        <a href="booking.jsp?packageId=<%= pkg.getId() %>" class="btn btn-primary">Book Now</a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="js/dashboard.js"></script>
</body>
</html>