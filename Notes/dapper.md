# Dapper Micro-ORM: Complete Technical Reference

Dapper is a high-performance "Micro-ORM" for .NET that extends the `IDbConnection` interface. It provides a thin wrapper around ADO.NET to map SQL results directly to C# objects with maximum efficiency.

---

## 1. Core Execution Methods
Dapper offers several methods to handle different data requirements. All methods have an `Async` equivalent (e.g., `QueryAsync`).

| Method | Use Case | Return Type |
| :--- | :--- | :--- |
| **Execute** | `INSERT`, `UPDATE`, `DELETE`, or DDL. | `int` (Rows affected) |
| **Query<T>** | Standard `SELECT` for multiple records. | `IEnumerable<T>` |
| **QueryFirst<T>** | Fetch first row; throws exception if empty. | `T` |
| **QueryFirstOrDefault<T>** | Fetch first row; returns `null` if empty. | `T?` |
| **QuerySingle<T>** | Expects exactly one row; throws if 0 or >1. | `T` |
| **QuerySingleOrDefault<T>** | Expects 0 or 1 row; throws if >1. | `T?` |
| **QueryMultiple** | Executes multiple SQL statements in one call. | `GridReader` |

---

## 2. Parameter Management

### A. Anonymous Objects
The most common way to pass parameters securely and prevent SQL Injection.
```csharp
var sql = "UPDATE Users SET Email = @email WHERE Id = @id";
connection.Execute(sql, new { email = "hello@world.com", id = 10 });

```

### B. DynamicParameters

Used for advanced scenarios like **Output Parameters** or specifying database types.

```csharp
var p = new DynamicParameters();
p.Add("@UserName", "JohnDoe");
p.Add("@NewId", dbType: DbType.Int32, direction: ParameterDirection.Output);

connection.Execute("sp_CreateUser", p, commandType: CommandType.StoredProcedure);
int id = p.Get<int>("@NewId");

```

### C. List Support (The "IN" Clause)

Dapper automatically expands any `IEnumerable` passed as a parameter into a comma-separated list.

```csharp
var ids = new[] { 1, 2, 3 };
var users = connection.Query<User>("SELECT * FROM Users WHERE Id IN @ids", new { ids });

```

---

## 3. Table-Valued Parameters (TVP)

TVPs allow passing a structured "table" of data to a Stored Procedure, which is much faster than running loops of individual inserts.

### Step 1: SQL Setup

```sql
-- Create the Type in the database
CREATE TYPE dbo.UserType AS TABLE (
    UserId INT,
    UserName NVARCHAR(50)
);

```

### Step 2: C# Implementation

```csharp
var dt = new DataTable();
dt.Columns.Add("UserId", typeof(int));
dt.Columns.Add("UserName", typeof(string));
dt.Rows.Add(1, "Alice");
dt.Rows.Add(2, "Bob");

var p = new DynamicParameters();
p.Add("@MyTableParam", dt.AsTableValuedParameter("dbo.UserType"));

connection.Execute("sp_BulkUpdate", p, commandType: CommandType.StoredProcedure);

```

---

## 4. Advanced Mapping Features

### Multi-Mapping (Joins)

Maps a single row to multiple nested objects. The `splitOn` parameter tells Dapper where the next object starts.

```csharp
var sql = "SELECT * FROM Posts p JOIN Users u ON p.AuthorId = u.Id";
var posts = conn.Query<Post, User, Post>(sql, (post, user) => {
    post.Author = user;
    return post;
}, splitOn: "Id");

```

### Multiple Result Sets

Fetch different types of data in a single database round-trip.

```csharp
var sql = "SELECT * FROM Orders; SELECT * FROM Customers;";
using (var multi = connection.QueryMultiple(sql))
{
    var orders = multi.Read<Order>().ToList();
    var customers = multi.Read<Customer>().ToList();
}

```

### Literal Tokens

Used for values that cannot be parameterized by standard SQL, like table names.

```csharp
var sql = "SELECT * FROM {=TableName} WHERE Id = @id";
conn.Query(sql, new { TableName = "Products", id = 1 });

```

---

## 5. Performance Best Practices

* **Use Async:** In web environments, use `QueryAsync` to keep threads free.
* **Buffered Queries:** Set `buffered: false` for massive datasets to stream rows one-by-one and save memory.
* **Transactions:** Dapper works with `IDbTransaction`. Always pass the transaction object: `conn.Execute(sql, param, transaction: myTrans)`.
* **Stored Procedures:** Explicitly define `commandType: CommandType.StoredProcedure` when calling procedures.

```

Would you like me to provide a sample **Generic Repository** implementation using these Dapper patterns?

```
