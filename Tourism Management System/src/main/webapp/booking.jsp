<%@ page import="com.tourism.model.User, com.tourism.dao.PackageDAO, com.tourism.model.Package" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    // Get packageId from URL and fetch package details
    int packageId = Integer.parseInt(request.getParameter("packageId"));
    PackageDAO packageDAO = new PackageDAO();
    Package packageToBook = packageDAO.getPackageById(packageId);
%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Booking</title>
    <script src="js/theme-loader.js"></script>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body style="display: block;"> 
    <%-- Navbar can be added here if needed --%>
    <nav class="navbar">
        <div class="container">
             <a href="dashboard.jsp" class="logo">Global Explorers</a>
             <ul class="nav-links">
                 <li><a href="dashboard.jsp">Dashboard</a></li>
                 <li><a href="myBookings.jsp">My Bookings</a></li>
                 <li><a href="LogoutServlet">Logout</a></li>
             </ul>
        </div>
    </nav>

    <main class="container" style="padding-top: 40px;">
        <div class="form-container" style="max-width: 700px; margin: auto;">
            <h2>Confirm Your Booking</h2>
            
            <% if (packageToBook != null) { %>
                <h3>Package: <%= packageToBook.getName() %></h3>
                <p><%= packageToBook.getDescription() %></p>
                <p><strong>Price per person:</strong> ₹<%= String.format("%,.2f", packageToBook.getPrice()) %></p>
                
                <form action="BookingServlet" method="post">
                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                    <input type="hidden" name="packageId" value="<%= packageToBook.getId() %>">

                    <div class="input-group">
                        <label for="bookingDate">Select Booking Date</label>
                        <input type="date" id="bookingDate" name="bookingDate" required>
                    </div>

                    <div class="input-group">
                        <label for="numberOfGuests">Number of Guests</label>
                        <input type="number" id="numberOfGuests" name="numberOfGuests" value="1" min="1" max="10" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Confirm & Book</button>
                </form>
            <% } else { %>
                <p>Sorry, the package could not be found.</p>
            <% } %>
        </div>
    </main>
    
    <script>
        // Set the minimum date for the date picker to today
        document.getElementById('bookingDate').min = new Date().toISOString().split("T")[0];
    </script>
</body>
</html>