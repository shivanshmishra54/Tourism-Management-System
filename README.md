# 🗺️ Tourism Management System

[![Java](https://img.shields.io/badge/Language-Java-blue?style=for-the-badge&logo=java)](https://www.java.com/)
[![UI](https://img.shields.io/badge/UI-Java%20Swing-orange?style=for-the-badge&logo=oracle)](https://docs.oracle.com/javase/8/docs/technotes/guides/swing/)
[![Database](https://img.shields.io/badge/Database-MySQL-blue?style=for-the-badge&logo=mysql)](https://www.mysql.com/)

A comprehensive desktop application built with Java and Swing for managing travel packages, bookings, customer details, and all operational aspects of a tourism business.

## 🚀 Overview

This project is a complete Tourism Management System designed to automate and streamline the processes of a travel agency. It provides a user-friendly graphical interface (GUI) for both administrators and customers. Administrators can manage packages, view bookings, and handle user accounts, while customers can browse destinations, book packages, and view their booking history.

This application serves as a strong example of object-oriented programming (OOP) principles, GUI design with Java Swing, and database integration with MySQL.

## ✨ Key Features

* **User Authentication:** Secure login and registration modules for both administrators and customers.
* **Administrator Dashboard:** A central control panel for admins to:
    * **Manage Packages:** Add, update, and delete travel packages (e.g., destinations, price, duration).
    * **View Bookings:** See all bookings made by customers.
    * **Manage Customers:** View and manage registered customer details.
* **Customer Dashboard:** A personalized portal for customers to:
    * **Browse Packages:** View all available travel packages with detailed descriptions.
    * **Book a Package:** Select and book a desired travel package.
    * **View My Bookings:** Check the status and history of their own bookings.
    * **Manage Profile:** Update personal information.
* **Dynamic Data Handling:** All package, user, and booking data is stored and retrieved from a MySQL database.

## 💻 Technology Stack

* **Core Language:** Java
* **Graphical User Interface (GUI):** Java Swing
* **Database:** MySQL
* **Database Connectivity:** JDBC (Java Database Connectivity)
* **IDE:** Eclipse / IntelliJ IDEA

## 🔧 Project Setup & Installation

To get a local copy up and running, follow these simple steps.

### Prerequisites

You will need the following tools installed on your system:
* [Java Development Kit (JDK) 8](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) or higher
* A database management system, such as [MySQL Server](https://dev.mysql.com/downloads/mysql/)
* An IDE like [Eclipse](https://www.eclipse.org/downloads/) or [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)

### Installation

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/shivanshmishra54/Tourism-Management-System.git](https://github.com/shivanshmishra54/Tourism-Management-System.git)
    cd Tourism-Management-System
    ```

2.  **Database Setup:**
    * Open your database management tool (e.g., MySQL Workbench).
    * Create a new database for the project.
        ```sql
        CREATE DATABASE tourism_db;
        ```
    

3.  **Configure Database Connection:**
    * Open the project in your IDE.
    * Locate the database connection file (it might be a class named `Conn.java` or `DBConnection.java`).
    * Update the database URL, username, and password to match your local MySQL setup:
        ```java
        // Example from a typical Conn.java file
        String url = "jdbc:mysql://localhost:3306/tourism_db";
        String user = "your_username";
        String password = "your_password";
        
        Connection c = DriverManager.getConnection(url, user, password);
        ```

4.  **Run the Application:**
    * Find the main entry point of the application (e.g., `Main.java`, `Login.java`, or `Splash.java`).
    * Right-click the file and select **Run As > Java Application**.

## 🚀 Usage

1.  Launch the application.
2.  **Login** as an **Admin** to manage packages and view all bookings.
3.  **Sign Up** as a new **Customer** to create an account.
4.  **Login** as a **Customer** to browse and book your favorite travel packages.

## 👤 Author

**Shivansh Mishra**
* GitHub: [@shivanshmishra54](https://github.com/shivanshmishra54)
* LinkedIn: [shivansh-mishra54](https://www.linkedin.com/in/shivansh-mishra54/)
* 
