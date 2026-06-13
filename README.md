# Football Ticket Booking System - Database Design & SQL Queries

## Overview & Objectives

This is assignment 3 and this project includes

 - Database Table Design
 - ERD relationships
 - intermediate-to-advanced SQL queries


## Database Design & Business Logic

The system manages football fans purchasing tickets, upcoming tournament matches, and individual ticket booking receipts.

### Business Logic & Schema Architecture

Your database design must handle these real-world scenarios by implementing the following exact table fields:

### 1. Users Table

This table tracks all administrative staff and customers who use the platform.

| **Field Name** | **What the Field Does** |
| --- | --- |
| `user_id` | Unique identification number for each registered user. |
| `full_name` | Stores the first and last name of the user. |
| `email` | Stores the user's mail address used for login. |
| `role` | Defines access permissions (`Ticket Manager` or `Football Fan`). |
| `phone_number` | Stores the contact mobile number of the fan. |

### 2. Matches Table

This table catalogs the tournament events, stadium logistics, and baseline ticket inventory pricing.

| **Field Name** | **What the Field Does** |
| --- | --- |
| `match_id` | Unique identification number for each football match. |
| `fixture` | Tracks the two competing teams (e.g., *Real Madrid vs Barcelona*). |
| `tournament_category` | The league or cup title (e.g., *Champions League*, *Premier League*). |
| `base_ticket_price` | The foundational price for a single standard entry seat. |
| `match_status` | Current ticket availability state (`Available`, `Selling Fast`, `Sold Out`, `Postponed`). |

### 3. Bookings Table

This transactional table records individual ticket purchases by linking users to their chosen matches.

| **Field Name** | **What the Field Does** |
| --- | --- |
| `booking_id` | Unique tracking transaction number for the ticket purchase. |
| `user_id` | Links the booking directly to the user who made the purchase. |
| `match_id` | Links the booking directly to the specific match being attended. |
| `seat_number` | The specific allocated seat identifier in the stadium (e.g., `A-12`). |
| `payment_status` | Tracks financial resolution (`Pending`, `Confirmed`, `Cancelled`, `Refunded`). |
| `total_cost` | The calculated final invoice price based on the base price and seat quantity. |