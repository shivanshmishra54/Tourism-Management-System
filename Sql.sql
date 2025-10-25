-- Database banane ke liye
CREATE DATABASE IF NOT EXISTS bookexchangesystem;

-- Database ko use karne ke liye
USE bookexchangesystem;

-- =================================================================
-- Table 1: USERS (User ki saari jaankari ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS USERS (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    mobile VARCHAR(15),
    password_hash VARCHAR(255) NOT NULL, -- Isme password hash karke save hoga
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================
-- Table 2: BOOKS (Saari books ki jaankari ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS BOOKS (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    genre VARCHAR(50),
    publication_type VARCHAR(50),
    language VARCHAR(50),
    file_path VARCHAR(255),
    image_path VARCHAR(255) NULL, -- Yeh naya column add kiya gaya hai
    is_offline BOOLEAN DEFAULT TRUE,
    is_direct_use BOOLEAN DEFAULT FALSE,
    uploaded_by INT,
    FOREIGN KEY (uploaded_by) REFERENCES USERS(user_id) ON DELETE SET NULL
);

-- =================================================================
-- Table 3: USER_PREFERENCES (User ki pasand save karne ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS USER_PREFERENCES (
    user_id INT PRIMARY KEY,
    preferences_json JSON,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- =================================================================
-- Table 4: REQUESTS (Book exchange requests ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS REQUESTS (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    requester_id INT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_date TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id) ON DELETE CASCADE,
    FOREIGN KEY (requester_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- =================================================================
-- Table 5: NOTIFICATIONS (Sabhi tarah ki notifications ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS NOTIFICATIONS (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    recipient_id INT,
    sender_id INT,
    message TEXT,
    type VARCHAR(50), -- Jaise 'REQUEST_RECEIVED', 'REQUEST_APPROVED', 'NEW_BOOK_MATCH'
    link VARCHAR(255), -- Isme zaroori ID (jaise request_id ya book_id) save hogi
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipient_id) REFERENCES USERS(user_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id) ON DELETE SET NULL
);

-- =================================================================
-- Table 6: DOWNLOADS (Download history ke liye)
-- =================================================================
CREATE TABLE IF NOT EXISTS DOWNLOADS (
    download_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    download_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id) ON DELETE CASCADE
);

-- =================================================================
-- Table 7: ACTIVITY_LOG (Optional - Agar aapko user ki har activity save karni hai)
-- =================================================================
CREATE TABLE IF NOT EXISTS ACTIVITY_LOG (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_type VARCHAR(50),
    description TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);
