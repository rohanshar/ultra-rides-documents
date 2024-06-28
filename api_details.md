### Detailed API Requirement Document for Enduroco Ride Management Platform (Using DynamoDB)

---

#### **1. Overview**

This document details the API requirements for building the Enduroco Ride Management Platform using DynamoDB as the database. The APIs will handle user registration, ride management, payment processing, ride tracking, and homologation.

---

#### **2. DynamoDB Data Models**

We will use DynamoDB tables to manage different entities within the platform. Each table will include primary keys and relevant attributes.

1. **Users Table**
   - **Primary Key**: `UserID (String, Partition Key)`
   - **Attributes**:
     - `UserType (String)` - "Rider" or "ClubOwner"
     - `Email (String)`
     - `PasswordHash (String)`
     - `RiderNumber (Number)` - Unique, sequential number for riders
     - `ClubID (String)` - Reference to Club table for club owners
     - `RegistrationDate (String)` - ISO date format
     - `ProfileDetails (Map)` - Additional profile details

2. **Clubs Table**
   - **Primary Key**: `ClubID (String, Partition Key)`
   - **Attributes**:
     - `ClubName (String)`
     - `OwnerID (String)` - Reference to Users table
     - `ClubDetails (Map)` - Additional details about the club

3. **Rides Table**
   - **Primary Key**: `RideID (String, Partition Key)`
   - **Attributes**:
     - `ClubID (String)` - Reference to Clubs table
     - `RideName (String)`
     - `RideDate (String)` - ISO date format
     - `Distance (Number)` - Distance in kilometers
     - `Route (String)` - Description or link to route details
     - `RegistrationFee (Number)`
     - `RegistrationDeadline (String)` - ISO date format
     - `MaxParticipants (Number)`
     - `Status (String)` - "Upcoming", "Completed", "Homologated"
     - `Participants (List)` - List of RiderIDs registered for the ride
     - `HomologationNumber (Number)` - Unique number for homologated rides

4. **Payments Table**
   - **Primary Key**: `PaymentID (String, Partition Key)`
   - **Attributes**:
     - `UserID (String)` - Reference to Users table
     - `RideID (String)` - Reference to Rides table
     - `Amount (Number)`
     - `PaymentDate (String)` - ISO date format
     - `Status (String)` - "Pending", "Completed", "Failed"

5. **Series Table**
   - **Primary Key**: `SeriesID (String, Partition Key)`
   - **Attributes**:
     - `UserID (String)` - Reference to Users table
     - `Year (Number)`
     - `Rides (List)` - List of RideIDs participated in the series
     - `CompletionStatus (String)` - "Incomplete", "Completed"
     - `SeriesType (String)` - "Standard" (200km, 300km, 400km, 600km)

6. **RiderRides Table**
   - **Primary Key**: Composite Key (`RiderID (String, Partition Key)`, `RideID (String, Sort Key)`)
   - **Attributes**:
     - `JoinDate (String)` - ISO date format
     - `Status (String)` - "Joined", "Completed", "DNF", "DNS"

---

#### **3. API Endpoints**

##### **3.1. User Management**

1. **Register User**
   - **Endpoint**: `POST /users/create-account`
   - **Description**: Register a new user (rider or club owner).
   - **Request Body**: Includes email, password, userType, and profileDetails.
   - **Response**: Includes userID, riderNumber (if Rider), and a message.

2. **Login User**
   - **Endpoint**: `POST /users/login`
   - **Description**: Authenticate user and return a session token.
   - **Request Body**: Includes email and password.
   - **Response**: Includes token, userID, and userType.

3. **Get User Profile**
   - **Endpoint**: `GET /users/{userID}`
   - **Description**: Retrieve user profile details.
   - **Response**: Includes userID, email, userType, riderNumber, profileDetails, and registrationDate.

##### **3.2. Club Management**

1. **Create Club**
   - **Endpoint**: `POST /clubs`
   - **Description**: Create a new club by a verified club owner.
   - **Request Body**: Includes clubName, ownerID, and clubDetails.
   - **Response**: Includes clubID and a message.

2. **Get Club Details**
   - **Endpoint**: `GET /clubs/{clubID}`
   - **Description**: Retrieve details of a specific club.
   - **Response**: Includes clubID, clubName, ownerID, and clubDetails.

3. **List All Clubs**
   - **Endpoint**: `GET /clubs`
   - **Description**: Retrieve a list of all clubs.
   - **Response**: Includes a list of clubs with clubID, clubName, ownerID, and clubDetails.

##### **3.3. Ride Management**

1. **Create Ride**
   - **Endpoint**: `POST /rides`
   - **Description**: Create a new ride by a club owner.
   - **Request Body**: Includes clubID, rideName, rideDate, distance, route, registrationFee, registrationDeadline, and maxParticipants.
   - **Response**: Includes rideID and a message.

2. **Get Ride Details**
   - **Endpoint**: `GET /rides/{rideID}`
   - **Description**: Retrieve details of a specific ride.
   - **Response**: Includes rideID, clubID, rideName, rideDate, distance, route, registrationFee, registrationDeadline, maxParticipants, status, participants, and homologationNumber.

3. **List All Rides**
   - **Endpoint**: `GET /rides`
   - **Description**: Retrieve a list of all rides.
   - **Response**: Includes a list of rides with rideID, clubID, rideName, rideDate, distance, route, registrationFee, registrationDeadline, maxParticipants, status, participants, and homologationNumber.

4. **Register for a Ride**
   - **Endpoint**: `POST /rides/{rideID}/create-account`
   - **Description**: Register a rider for a specific ride.
   - **Request Body**: Includes riderID.
   - **Response**: Includes a message.

5. **Get Rides by Rider**
   - **Endpoint**: `GET /riders/{riderID}/rides`
   - **Description**: Retrieve a list of rides that a specific rider has joined along with the status of each ride.
   - **Response**: Includes a list of rides with rideID, rideName, rideDate, and status.

6. **Get Riders in a Ride**
   - **Endpoint**: `GET /rides/{rideID}/riders`
   - **Description**: Retrieve a list of riders in a specific ride along with their status.
   - **Response**: Includes a list of riders with riderID, joinDate, and status.

7. **Get Rides by Club**
   - **Endpoint**: `GET /clubs/{clubID}/rides`
   - **Description**: Retrieve a list of rides organized by a specific club.
   - **Response**: Includes a list of rides with rideID, rideName, rideDate, distance, and status.

8. **Update Ride Status**
   - **Endpoint**: `PUT /rides/{rideID}/status`
   - **Description**: Update the status of riders post-ride (e.g., completed, DNF, DNS, LF).
   - **Request Body**: Includes riderID and status.
   - **Response**: Includes a message.

9. **Homologate Ride**
   - **Endpoint**: `PUT /rides/{rideID}/homologate`
   - **Description**: Homologate a completed ride, assigning a homologation number.
   - **Response**: Includes homologationNumber and a message.

##### **3.4. Payment Processing**

1. **Process Payment**
   - **Endpoint**: `POST /payments`
   - **Description**: Process payment for ride registration.
   - **Request Body**: Includes riderID, rideID, amount, and paymentMethod.
   - **Response**: Includes paymentID, status, and a message.

2. **Get Payment Status**
   - **Endpoint**: `GET /payments/{paymentID}`
   - **Description**: Retrieve the status of a specific payment.
   - **Response**: Includes paymentID, status, amount, and paymentDate.

##### **3.5. Series Management**

1. **Track Series Participation**
   - **Endpoint**: `POST /series`
   - **Description**: Track a rider's participation in a ride series.
   - **Request Body**: Includes riderID, rideID, year, and seriesType.
   - **Response**: Includes seriesID and a message.

2. **Get Series Status**
   - **Endpoint**: `GET /series/{riderID}/{year}`
   - **Description**: Retrieve a rider's series completion status for a given year.
   - **Response**: Includes seriesID, riderID, year, rides, completionStatus, and seriesType.

##### **

3.6. Notifications and Communication**

1. **Send Notification**
   - **Endpoint**: `POST /notifications`
   - **Description**: Send notifications to users about ride updates or homologations.
   - **Request Body**: Includes userID and message.
   - **Response**: Includes notificationID and a message.

2. **Get Notifications**
   - **Endpoint**: `GET /notifications/{userID}`
   - **Description**: Retrieve notifications for a specific user.
   - **Response**: Includes a list of notifications with notificationID, message, and date.

---

#### **4. Authentication and Authorization**

- **Session Management**:
  - Implement JWT-based authentication for secure API access.
  - Tokens should have expiration and renewal mechanisms.

- **Role-Based Access Control**:
  - Define roles and permissions (e.g., Rider, ClubOwner, Admin) to control access to different endpoints.

- **Secure Communication**:
  - Use HTTPS for all API communications to ensure data security.

---

#### **5. Error Handling and Logging**

- **Error Responses**:
  - APIs should return clear and consistent error messages with appropriate HTTP status codes (e.g., 400 for bad requests, 404 for not found, 500 for server errors).

- **Logging**:
  - Implement logging for API requests and responses to facilitate debugging and monitoring.

---

#### **6. API Rate Limiting and Throttling**

- **Rate Limits**:
  - Set rate limits for API requests to prevent abuse and ensure fair usage.

- **Throttling**:
  - Implement throttling mechanisms to control the number of requests from a single user or IP address.

---

This detailed API requirement document provides a comprehensive guide for building the Enduroco Ride Management Platform using DynamoDB. Each endpoint and feature is designed to support the functionality needed for riders, club owners, and administrators.

Feel free to provide feedback or ask for modifications if necessary!