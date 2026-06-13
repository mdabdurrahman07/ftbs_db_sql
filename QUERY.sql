-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================
-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;


DROP TABLE IF EXISTS Matches;


DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
  user_id int,
  full_name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  role varchar(20) NOT NULL,
  phone_number varchar(20),
  -- Write your constraint to make 'user_id' the Primary Key
  CONSTRAINT pk_user_id PRIMARY KEY (user_id),
  -- Write your constraint to ensure 'email' values are never duplicated
  CONSTRAINT unique_email UNIQUE (email),
  -- Write your check constraint to restrict 'role' to specific allowed strings
  CONSTRAINT ck_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
  match_id int,
  fixture text NOT NULL,
  tournament_category varchar(100) NOT NULL,
  base_ticket_price int NOT NULL,
  match_status varchar(50) NOT NULL,
  -- Write your constraint to make 'match_id' the Primary Key
  CONSTRAINT pk_match_id PRIMARY KEY (match_id),
  -- Write your check constraint to prevent negative ticket prices
  CONSTRAINT ck_postive_price CHECK (base_ticket_price >= 0),
  -- Write your check constraint to restrict 'match_status' values
  CONSTRAINT ck_match_status CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id int,
  user_id int NOT NULL,
  match_id int NOT NULL,
  seat_number varchar(20) UNIQUE,
  payment_status varchar(50),
  total_cost int NOT NULL,
  -- Write your constraint to make 'booking_id' the Primary Key
  CONSTRAINT pk_booking_id PRIMARY KEY (booking_id),
  -- Write your Foreign Key constraint linking 'user_id' to the Users table
  CONSTRAINT fk_user_id FOREIGN key (user_id) REFERENCES Users (user_id),
  -- Write your Foreign Key constraint linking 'match_id' to the Matches table
  CONSTRAINT fk_match_id FOREIGN key (match_id) REFERENCES Matches (match_id),
  -- Write your check constraint to ensure 'total_cost' is non-negative
  CONSTRAINT ck_postive_total_cost CHECK (total_cost >= 0),
  -- Write your check constraint to restrict 'payment_status' values
  CONSTRAINT ck_payment_status CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  )
);



