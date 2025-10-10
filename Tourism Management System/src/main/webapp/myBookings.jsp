<%@ page import="com.tourism.model.User, com.tourism.dao.BookingDAO, com.tourism.model.Booking, java.util.List" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    // Fetch all bookings for this user
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> userBookings = bookingDAO.getBookingsByUserId(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Global Explorers</title>
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
        <h1>My Bookings</h1>

        <% if ("success".equals(request.getParameter("status"))) { %>
            <div style="padding: 15px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 8px; margin-bottom: 20px;">
                <strong>Success!</strong> Your package has been booked successfully.
            </div>
        <% } %>

        <% if (userBookings.isEmpty()) { %>
             <div style="text-align: center; padding: 40px; background-color: #fff; border-radius: 12px; box-shadow: var(--shadow-light);">
                <h2>No Bookings Found</h2>
                <p>You haven't booked any packages yet. <a href="dashboard.jsp">Explore packages</a> to start your next adventure!</p>
            </div>
        <% } else { %>
            <div class="table-container" style="overflow-x: auto;">
                <table style="width: 100%; border-collapse: collapse; background-color: #fff; border-radius: 12px; overflow: hidden; box-shadow: var(--shadow-light);">
                    <thead>
                        <tr style="background-color: var(--dark-bg); color: white;">
                            <th style="padding: 15px; text-align: left;">Package Name</th>
                            <th style="padding: 15px; text-align: left;">Booking Date</th>
                            <th style="padding: 15px; text-align: center;">Guests</th>
                            <th style="padding: 15px; text-align: left;">Price per Person</th>
                            <th style="padding: 15px; text-align: left;">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking b : userBookings) { %>
                           <tr style="border-bottom: 1px solid #ddd;">
                                <td style="padding: 15px;"><%= b.getPackageName() %></td>
                                <td style="padding: 15px;"><%= b.getBookingDate() %></td>
                                <td style="padding: 15px; text-align: center;"><%= b.getNumberOfGuests() %></td>
                                <td style="padding: 15px;">₹<%= String.format("%,.2f", b.getPackagePrice()) %></td>
                                <td style="padding: 15px;">
                                    <span style="padding: 5px 10px; border-radius: 20px; color: white; background-color: 
                                        <% 
                                            String status = b.getStatus() != null ? b.getStatus().toLowerCase() : "pending";
                                            switch (status) {
                                                case "confirmed":
                                                    out.print("#28a745"); // Green
                                                    break;
                                                case "cancelled":
                                                    out.print("#dc3545"); // Red
                                                    break;
                                                default:
                                                    out.print("#ffc107"); // Yellow for pending
                                                    break;
                                            }
                                        %>;">
                                        <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                                    </span>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>

</body>
</html>