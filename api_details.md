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

---

#### **3. API Endpoints**

##### **3.1. User Management**

1. **Register User**
   - **Endpoint**: `POST /users/register`
   - **Description**: Register a new user (rider or club owner).
   - **Request Body**:
     ```json
     {
       "email": "string",
       "password": "string",
       "userType": "Rider" | "ClubOwner",
       "profileDetails": {
         "name": "string",
         "age": "number",
         "address": "string",
         ...
       }
     }
     ```
   - **Response**:
     ```json
     {
       "userID": "string",
       "riderNumber": "number" (if Rider),
       "message": "string"
     }
     ```

2. **Login User**
   - **Endpoint**: `POST /users/login`
   - **Description**: Authenticate user and return a session token.
   - **Request Body**:
     ```json
     {
       "email": "string",
       "password": "string"
     }
     ```
   - **Response**:
     ```json
     {
       "token": "string",
       "userID": "string",
       "userType": "Rider" | "ClubOwner"
     }
     ```

3. **Get User Profile**
   - **Endpoint**: `GET /users/{userID}`
   - **Description**: Retrieve user profile details.
   - **Response**:
     ```json
     {
       "userID": "string",
       "email": "string",
       "userType": "Rider" | "ClubOwner",
       "riderNumber": "number",
       "profileDetails": {
         "name": "string",
         "age": "number",
         "address": "string",
         ...
       },
       "registrationDate": "string"
     }
     ```

##### **3.2. Club Management**

1. **Create Club**
   - **Endpoint**: `POST /clubs`
   - **Description**: Create a new club by a verified club owner.
   - **Request Body**:
     ```json
     {
       "clubName": "string",
       "ownerID": "string",
       "clubDetails": {
         "description": "string",
         "location": "string",
         ...
       }
     }
     ```
   - **Response**:
     ```json
     {
       "clubID": "string",
       "message": "string"
     }
     ```

2. **Get Club Details**
   - **Endpoint**: `GET /clubs/{clubID}`
   - **Description**: Retrieve details of a specific club.
   - **Response**:
     ```json
     {
       "clubID": "string",
       "clubName": "string",
       "ownerID": "string",
       "clubDetails": {
         "description": "string",
         "location": "string",
         ...
       }
     }
     ```

3. **List All Clubs**
   - **Endpoint**: `GET /clubs`
   - **Description**: Retrieve a list of all clubs.
   - **Response**:
     ```json
     {
       "clubs": [
         {
           "clubID": "string",
           "clubName": "string",
           "ownerID": "string",
           "clubDetails": {
             "description": "string",
             "location": "string",
             ...
           }
         },
         ...
       ]
     }
     ```

##### **3.3. Ride Management**

1. **Create Ride**
   - **Endpoint**: `POST /rides`
   - **Description**: Create a new ride by a club owner.
   - **Request Body**:
     ```json
     {
       "clubID": "string",
       "rideName": "string",
       "rideDate": "string",
       "distance": "number",
       "route": "string",
       "registrationFee": "number",
       "registrationDeadline": "string",
       "maxParticipants": "number"
     }
     ```
   - **Response**:
     ```json
     {
       "rideID": "string",
       "message": "string"
     }
     ```

2. **Get Ride Details**
   - **Endpoint**: `GET /rides/{rideID}`
   - **Description**: Retrieve details of a specific ride.
   - **Response**:
     ```json
     {
       "rideID": "string",
       "clubID": "string",
       "rideName": "string",
       "rideDate": "string",
       "distance": "number",
       "route": "string",
       "registrationFee": "number",
       "registrationDeadline": "string",
       "maxParticipants": "number",
       "status": "string",
       "participants": [
         "RiderID1",
         "RiderID2",
         ...
       ],
       "homologationNumber": "number"
     }
     ```

3. **List All Rides**
   - **Endpoint**: `GET /rides`
   - **Description**: Retrieve a list of all rides.
   - **Response**:
     ```json
     {
       "rides": [
         {
           "rideID": "string",
           "clubID": "string",
           "rideName": "string",
           "rideDate": "string",
           "distance": "number",
           "route": "string",
           "registrationFee": "number",
           "registrationDeadline": "string",
           "maxParticipants": "number",
           "status": "string",
           "participants": [
             "RiderID1",
             "RiderID2",
             ...
           ],
           "homologationNumber": "number"
         },
         ...
       ]
     }
     ```

4. **Register for a Ride**
   - **Endpoint**: `POST /rides/{rideID}/register`
   - **Description**: Register a rider for a specific ride.
   - **Request Body**:
     ```json
     {
       "riderID": "string"
     }
     ```
   - **Response**:
     ```json
     {
       "message": "string"
     }
     ```

5. **Update Ride Status**
   - **Endpoint**: `PUT /rides/{rideID}/status`
   - **Description**: Update the status of riders post-ride (e.g., completed

, DNF, DNS, LF).
   - **Request Body**:
     ```json
     {
       "riderID": "string",
       "status": "string"
     }
     ```
   - **Response**:
     ```json
     {
       "message": "string"
     }
     ```

6. **Homologate Ride**
   - **Endpoint**: `PUT /rides/{rideID}/homologate`
   - **Description**: Homologate a completed ride, assigning a homologation number.
   - **Response**:
     ```json
     {
       "homologationNumber": "number",
       "message": "string"
     }
     ```

##### **3.4. Payment Processing**

1. **Process Payment**
   - **Endpoint**: `POST /payments`
   - **Description**: Process payment for ride registration.
   - **Request Body**:
     ```json
     {
       "riderID": "string",
       "rideID": "string",
       "amount": "number",
       "paymentMethod": "string"
     }
     ```
   - **Response**:
     ```json
     {
       "paymentID": "string",
       "status": "string",
       "message": "string"
     }
     ```

2. **Get Payment Status**
   - **Endpoint**: `GET /payments/{paymentID}`
   - **Description**: Retrieve the status of a specific payment.
   - **Response**:
     ```json
     {
       "paymentID": "string",
       "status": "string",
       "amount": "number",
       "paymentDate": "string"
     }
     ```

##### **3.5. Series Management**

1. **Track Series Participation**
   - **Endpoint**: `POST /series`
   - **Description**: Track a rider's participation in a ride series.
   - **Request Body**:
     ```json
     {
       "riderID": "string",
       "rideID": "string",
       "year": "number",
       "seriesType": "Standard"
     }
     ```
   - **Response**:
     ```json
     {
       "seriesID": "string",
       "message": "string"
     }
     ```

2. **Get Series Status**
   - **Endpoint**: `GET /series/{riderID}/{year}`
   - **Description**: Retrieve a rider's series completion status for a given year.
   - **Response**:
     ```json
     {
       "seriesID": "string",
       "riderID": "string",
       "year": "number",
       "rides": [
         "RideID1",
         "RideID2",
         ...
       ],
       "completionStatus": "Incomplete" | "Completed",
       "seriesType": "Standard"
     }
     ```

##### **3.6. Notifications and Communication**

1. **Send Notification**
   - **Endpoint**: `POST /notifications`
   - **Description**: Send notifications to users about ride updates or homologations.
   - **Request Body**:
     ```json
     {
       "userID": "string",
       "message": "string"
     }
     ```
   - **Response**:
     ```json
     {
       "notificationID": "string",
       "message": "string"
     }
     ```

2. **Get Notifications**
   - **Endpoint**: `GET /notifications/{userID}`
   - **Description**: Retrieve notifications for a specific user.
   - **Response**:
     ```json
     {
       "notifications": [
         {
           "notificationID": "string",
           "message": "string",
           "date": "string"
         },
         ...
       ]
     }
     ```

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
