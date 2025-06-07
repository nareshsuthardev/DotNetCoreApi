# User Management API

A robust and scalable User Management API built with .NET Core, Dapper, and SQL Server (or your preferred relational database). This API provides comprehensive CRUD (Create, Read, Update, Delete) operations for user data, including authentication (login and registration). API documentation is provided via Swagger.

## 🚀 Features

* **User Authentication**: Secure user registration and login.

* **User Management**:

  * Create new users.

  * Retrieve a list of all users.

  * Retrieve a single user by ID.

  * Update existing user details.

  * Delete users.

* **Detailed User Profile**: Each user can store comprehensive data including:

  * `Username`

  * `Email`

  * `Language`

  * `Country`

  * `State`

  * `City`

  * `Gender`

  * `Role` (e.g., `Admin`, `User`, `Guest`)

* **Dapper ORM**: High-performance data access using Dapper for efficient interaction with the database.

* **Swagger**: Automatic generation of interactive API documentation for easy testing and consumption.


## 💻 Technologies Used

* **.NET 8.0 SDK**

* **ASP.NET Core Web API**

* **Dapper**: A simple object mapper for .NET.

* **Swashbuckle.AspNetCore**: For Swagger

* **Microsoft.Data.SqlClient** (or equivalent for PostgreSQL/MySQL)

## 🛠️ Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

* [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)

* A relational database (e.g., SQL Server, PostgreSQL, MySQL).

* A database management tool (e.g., SQL Server Management Studio, DBeaver, Azure Data Studio).

### ⬇️ Cloning the Repository
