To build a professional Book CRUD application using **.NET MVC** and **EF Core**, we use an **N-Tier Architecture**. This separates the user interface, the business rules, and the database logic into distinct "projects" within one solution.

Here is the structural blueprint for your task.

---

## 📂 Solution: `BookStore.Solution`

### 1. Project: `BookStore.Models` (Class Library)

This project is the "foundation." It contains the objects that all other projects will use. It has no logic, only definitions.

* **`Entities/` Folder**: Contains classes that match your database tables (e.g., `Book.cs`, `Author.cs`).
* **`DTOs/` Folder**: (Data Transfer Objects) for complex reports that don't match a single table.

### 2. Project: `BookStore.DAL` (Data Access Layer)

This project is the only one that talks to the database via **EF Core**.

* **`Data/` Folder**: Contains the `AppDbContext.cs`. This is the heart of EF Core that coordinates with the database.
* **`Repositories/` Folder**: Contains classes like `BookRepository.cs`. These classes handle the "Queries" (Add, Update, Delete, Get).
* **`Migrations/` Folder**: Created automatically by EF Core to keep track of database schema changes.

### 3. Project: `BookStore.BLL` (Business Logic Layer)

This is the "brain" of the application. It acts as a middleman between the Website and the Database.

* **`Services/` Folder**: Contains classes like `BookService.cs`.
* *What it does:* If a book price must be positive, or if you need to check stock before saving, the logic happens here. It calls the Repository from the DAL.



### 4. Project: `BookStore.Web` (ASP.NET Core MVC)

The "face" of the application. It handles what the user sees and clicks.

* **`Controllers/` Folder**: `BookController.cs`. It receives user requests and calls the Service layer.
* **`ViewModels/` Folder**: `BookVM.cs`. These are special classes designed specifically for the HTML forms (e.g., containing dropdown lists for Authors).
* **`Mappings/` Folder**: Contains **AutoMapper** profiles to translate ViewModels into Entities.
* **`Views/` Folder**: The `.cshtml` files (the actual HTML screens).
* **`appsettings.json`**: Stores your Database Connection String.

---

## 🛠️ Key Files & Their Responsibilities

| File Location | File Name | Role |
| --- | --- | --- |
| **Models** | `Book.cs` | Defines what a "Book" is (ID, Title, Price, AuthorId). |
| **DAL** | `AppDbContext.cs` | The "Bridge" that maps your C# classes to SQL tables. |
| **DAL** | `BookRepository.cs` | Uses the DbContext to perform `.Add()`, `.Remove()`, or `.ToList()`. |
| **BLL** | `BookService.cs` | Orchestrates the work (e.g., "Get the book, then get the author list"). |
| **Web** | `BookVM.cs` | Carries data to the View (e.g., the Title field + Author Dropdown). |
| **Web** | `BookController.cs` | Directs traffic. Maps the VM to an Entity and sends it to the Service. |

---

## 🔄 The Data Flow (The "Trip")

1. **User** fills a form on the **View**.
2. **Controller** grabs that data as a **ViewModel**.
3. **Controller** uses **AutoMapper** to turn the VM into an **Entity**.
4. **Service** validates the **Entity**.
5. **Repository** tells **EF Core** to save the **Entity** to SQL.

---

### Why this structure?

* **Scalability**: If you want to add a Mobile App later, you just create a new `BookStore.API` project and reuse the **BLL**, **DAL**, and **Models**.
* **Maintainability**: If the database changes from SQL Server to PostgreSQL, you only change the **DAL**. The rest of the app stays the same.
