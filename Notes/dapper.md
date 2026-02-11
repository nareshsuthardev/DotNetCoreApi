To make this as easy as possible for you, here is the raw **Markdown (.md)** code block.

You can save this by copying the text below, opening a text editor (like Notepad), and saving the file with the extension **.md** (e.g., `Dapper_CheatSheet.md`).

```markdown
# Dapper Micro-ORM Documentation

Dapper is a high-performance "Micro-ORM" for .NET that extends the `IDbConnection` interface. This document covers core methods, parameter handling, and advanced features.

---

## 1. Core Dapper Methods
All methods have an `Async` version (e.g., `QueryAsync`) for non-blocking I/O.

| Method | Purpose | Returns |
| :--- | :--- | :--- |
| **Execute** | `INSERT`, `UPDATE`, `DELETE`, or DDL. | `int` (Rows affected) |
| **Query<T>** | Standard `SELECT` for multiple records. | `IEnumerable<T>` |
| **QueryFirst<T>** | First row; throws if empty. | `T` |
| **QueryFirstOrDefault<T>** | First row; `null` if empty. | `T?` |
| **QuerySingle<T>** | Exactly one row; throws if 0 or >1. | `T` |
| **QuerySingleOrDefault<T>** | 0 or 1 row; throws if >1. | `T?` |
| **QueryMultiple** | Multiple SQL result sets in one trip. | `GridReader` |

---

## 2. Parameter Handling

### Anonymous Objects
The standard way to pass values.
```csharp
var sql = "UPDATE Users SET Email = @email WHERE Id = @id";
connection.Execute(sql, new { email = "test@io.com", id = 5 });

```

### DynamicParameters

Used for **Output Parameters** or specifying database types explicitly.

```csharp
var p = new DynamicParameters();
p.Add("@Name", "Alice");
p.Add("@NewId", dbType: DbType.Int32, direction: ParameterDirection.Output);

connection.Execute("sp_InsertUser", p, commandType: CommandType.StoredProcedure);
int id = p.Get<int>("@NewId");

```

### Collection Support (IN Clause)

Dapper automatically handles arrays/lists for SQL `IN` statements.

```csharp
var ids = new[] { 1, 2, 3 };
connection.Query<User>("SELECT * FROM Users WHERE Id IN @ids", new { ids });

```

---

## 3. Table-Valued Parameters (TVP)

TVPs allow passing a structured table to SQL Server in a single call.

### Step 1: SQL Type

```sql
CREATE TYPE dbo.MyTableType AS TABLE (Id INT, Val NVARCHAR(50));

```

### Step 2: C# Implementation

```csharp
var table = new DataTable();
table.Columns.Add("Id", typeof(int));
table.Columns.Add("Val", typeof(string));
table.Rows.Add(1, "Sample Data");

var p = new DynamicParameters();
p.Add("@MyTVP", table.AsTableValuedParameter("dbo.MyTableType"));

connection.Execute("sp_YourProcedure", p, commandType: CommandType.StoredProcedure);

```

---

## 4. Advanced Mapping

### Multi-Mapping (Joins)

Maps joined data into nested objects.

```csharp
var sql = "SELECT * FROM Posts p JOIN Users u ON p.OwnerId = u.Id";
var data = conn.Query<Post, User, Post>(sql, (post, user) => {
    post.Author = user;
    return post;
}, splitOn: "Id");

```

### Literal Tokens

Use `{=Property}` for dynamic values that cannot be parameterized (e.g., Table Names).

```csharp
var sql = "SELECT * FROM {=TableName} WHERE Status = @s";
conn.Query(sql, new { TableName = "Orders", s = 1 });

```

---

## 5. Best Practices

* **Buffering:** For massive datasets, use `buffered: false` in `Query` to stream rows instead of loading them all into RAM.
* **Transactions:** Dapper supports transactions: `connection.Execute(sql, params, transaction: myTrans)`.
* **Async:** Always use `Async` methods in web APIs to improve scalability.

```

**Would you like me to add a section on how to handle Dapper Transactions with a `TransactionScope`?**

```
