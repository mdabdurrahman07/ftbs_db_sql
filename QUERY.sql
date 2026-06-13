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

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);

-- =========================================================================
-- ALL QUERIES STARTS HERE
-- =========================================================================

-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

SELECT
  *
FROM
  matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'Available';

-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

SELECT
  *
FROM
  users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';
  
-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.
-- Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.
-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.
-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.