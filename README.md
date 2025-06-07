User Management APIA robust and scalable User Management API built with .NET Core, Dapper, and SQL Server (or your preferred relational database). This API provides comprehensive CRUD (Create, Read, Update, Delete) operations for user data, including authentication (login and registration) with JWT tokens. API documentation is provided via Swagger/OpenAPI.🚀 FeaturesUser Authentication: Secure user registration and login with JWT token generation.User Management:Create new users.Retrieve a list of all users.Retrieve a single user by ID.Update existing user details.Delete users.Detailed User Profile: Each user can store comprehensive data including:UsernameEmailLanguageCountryStateCityGenderRole (e.g., Admin, User, Guest)Dapper ORM: High-performance data access using Dapper for efficient interaction with the database.Swagger/OpenAPI: Automatic generation of interactive API documentation for easy testing and consumption.Middleware-based Error Handling: Centralized exception handling for clean error responses.💻 Technologies Used.NET 8.0 SDKASP.NET Core Web APIDapper: A simple object mapper for .NET.Swashbuckle.AspNetCore: For Swagger/OpenAPI documentation.Microsoft.Data.SqlClient (or equivalent for PostgreSQL/MySQL)JWT (JSON Web Tokens): For authentication.BCrypt.Net: For password hashing.🛠️ Getting StartedPrerequisitesBefore you begin, ensure you have the following installed:.NET 8.0 SDKA relational database (e.g., SQL Server, PostgreSQL, MySQL).A database management tool (e.g., SQL Server Management Studio, DBeaver, Azure Data Studio).⬇️ Cloning the Repositorygit clone https://github.com/your-username/UserManagementApi.git
cd UserManagementApi
⚙️ Database SetupConfigure Connection String:Open appsettings.json (or appsettings.Development.json) and update the DefaultConnection string to point to your database.{
  "ConnectionStrings": {
    "DefaultConnection": "Server=YourServerName;Database=UserDb;User Id=YourUsername;Password=YourPassword;TrustServerCertificate=True;"
  },
  "Jwt": {
    "Key": "ThisIsAVeryStrongSecretKeyForYourJWTTokenGeneration", // Keep this secret and long!
    "Issuer": "UserManagementApi",
    "Audience": "UserManagementClients"
  },
  "Logging": {
    // ...
  }
}
Database Schema:This project uses a simple Dapper approach, so you'll need to manually create the Users table in your database.-- Example SQL Server DDL for the Users table
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Language NVARCHAR(50),
    Country NVARCHAR(50),
    State NVARCHAR(50),
    City NVARCHAR(50),
    Gender NVARCHAR(10),
    Role NVARCHAR(20) DEFAULT 'User',
    CreatedAt DATETIME DEFAULT GETDATE()
);
▶️ Running the APIRestore Dependencies:dotnet restore
Run the Application:dotnet run
The API will typically start on https://localhost:7001 (or http://localhost:5001). The console will show the exact URLs.📄 Accessing Swagger UIOnce the API is running, open your web browser and navigate to the Swagger UI:https://localhost:7001/swagger (adjust port if different)Here you can interact with all the API endpoints, send requests, and view responses without needing a separate tool.💡 API Endpoints & DemoThis section demonstrates how to interact with the API using the Swagger UI.1. User RegistrationEndpoint: POST /api/Auth/registerDescription: Creates a new user account.Request Body Example:{
  "username": "john.doe",
  "email": "john.doe@example.com",
  "password": "SecurePassword123",
  "language": "English",
  "country": "USA",
  "state": "California",
  "city": "Los Angeles",
  "gender": "Male",
  "role": "User"
}
Successful Response (200 OK):{
  "message": "User registered successfully!"
}
2. User LoginEndpoint: POST /api/Auth/loginDescription: Authenticates a user and returns a JWT token. This token must be used for accessing protected endpoints.Request Body Example:{
  "username": "john.doe",
  "password": "SecurePassword123"
}
Successful Response (200 OK):{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEiLCJuYmYiOjE3MDMxNTYxODUsImV4cCI6MTcwMzE1Njc4NSwiaWF0IjoxNzAzMTU2MTg1LCJpc3MiOiJVc2VyTWFuYWdlbWVudEFwaSIsImF1ZCI6IlVzZXJNYW5hZ2VtZW50Q2xpZW50cyJ9.someRandomJwtTokenString"
}
IMPORTANT: Copy the token value. In Swagger UI, click the "Authorize" button (usually a lock icon 🔒) at the top right and paste Bearer Your_JWT_Token_Here into the value field, then click "Authorize". This will enable you to test authenticated endpoints.3. Get All UsersEndpoint: GET /api/UsersDescription: Retrieves a list of all registered users. Requires Authentication.Successful Response (200 OK):[
  {
    "id": 1,
    "username": "john.doe",
    "email": "john.doe@example.com",
    "language": "English",
    "country": "USA",
    "state": "California",
    "city": "Los Angeles",
    "gender": "Male",
    "role": "User",
    "createdAt": "2024-01-01T10:00:00Z"
  },
  {
    "id": 2,
    "username": "jane.smith",
    "email": "jane.smith@example.com",
    "language": "Spanish",
    "country": "Mexico",
    "state": "Mexico City",
    "city": "Mexico City",
    "gender": "Female",
    "role": "Admin",
    "createdAt": "2024-01-02T11:30:00Z"
  }
]
4. Get User by IDEndpoint: GET /api/Users/{id} (e.g., /api/Users/1)Description: Retrieves a single user by their unique ID. Requires Authentication.Successful Response (200 OK) for ID 1:{
  "id": 1,
  "username": "john.doe",
  "email": "john.doe@example.com",
  "language": "English",
  "country": "USA",
  "state": "California",
  "city": "Los Angeles",
  "gender": "Male",
  "role": "User",
  "createdAt": "2024-01-01T10:00:00Z"
}
Error Response (404 Not Found) if user does not exist:{
  "message": "User not found."
}
5. Create User (Authenticated)Endpoint: POST /api/UsersDescription: Creates a new user. Similar to registration but can be used by an authenticated user (e.g., an Admin role) to add users. Requires Authentication.Request Body Example:{
  "username": "new.user",
  "email": "new.user@example.com",
  "password": "AnotherSecurePassword",
  "language": "German",
  "country": "Germany",
  "state": "Bavaria",
  "city": "Munich",
  "gender": "Other",
  "role": "Guest"
}
Successful Response (201 Created):{
  "id": 3,
  "username": "new.user",
  "email": "new.user@example.com",
  "language": "German",
  "country": "Germany",
  "state": "Bavaria",
  "city": "Munich",
  "gender": "Other",
  "role": "Guest",
  "createdAt": "2024-01-03T09:00:00Z"
}
6. Update UserEndpoint: PUT /api/Users/{id} (e.g., /api/Users/1)Description: Updates the details of an existing user. Requires Authentication.Request Body Example (to update John Doe's role and language):{
  "username": "john.doe",
  "email": "john.doe@example.com",
  "language": "French",
  "country": "USA",
  "state": "California",
  "city": "Los Angeles",
  "gender": "Male",
  "role": "Admin"
}
Note: The password cannot be updated via this endpoint. A separate endpoint (e.g., PUT /api/Auth/change-password) would be typical for password changes.Successful Response (204 No Content): (Indicates successful update without returning data)7. Delete UserEndpoint: DELETE /api/Users/{id} (e.g., /api/Users/1)Description: Deletes a user account. Requires Authentication.Successful Response (204 No Content): (Indicates successful deletion)Error Response (404 Not Found) if user does not exist:{
  "message": "User not found."
}
👥 User Data ModelThe User entity in this API typically contains the following fields:FieldTypeDescriptionIdintUnique identifier for the user.UsernamestringUnique username.EmailstringUnique email address.PasswordHashstringHashed password (stored securely).LanguagestringPreferred language (e.g., "English", "French").CountrystringUser's country.StatestringUser's state/province.CitystringUser's city.GenderstringUser's gender (e.g., "Male", "Female", "Other").RolestringUser's role (e.g., "User", "Admin", "Guest").CreatedAtDateTimeTimestamp of user creation.🤝 ContributionContributions are welcome! If you have suggestions for improvements or find any issues, please open an issue or submit a pull request.📝 LicenseThis project is licensed under the MIT License. See the LICENSE file for details.
