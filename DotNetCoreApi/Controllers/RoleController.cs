using System.Data;
using System.Data.SqlClient;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using DotNetCoreApi.Context;
using DotNetCoreApi.Model;

namespace DotNetCoreApi.Controllers
{
    [Route("/[controller]")]
    [ApiController]
    public class RoleController : Controller
    {

        public IDbConnection getConnection()
        {
            var mssqlConnectionString = "Server=localhost;Database=UserData;Trusted_Connection=True;MultipleActiveResultSets=true";
            IDbConnection conn = new SqlConnection(mssqlConnectionString);
            return conn;
        }

        [Route("getAllRole")]
        [HttpGet]
        public List<Role> getAllRole()
        {
            using(var con = getConnection())
            {
                con.Open();
                List<Role> roles = new List<Role>();
                roles = con.Query<Role>("Select * from Role").ToList();
                return roles;
            }

        }
    }
}
