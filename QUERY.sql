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


