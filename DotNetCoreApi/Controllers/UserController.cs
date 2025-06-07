using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Text.Json;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using DotNetCoreApi.Model;

namespace DotNetCoreApi.Controllers
{
    [Route("/[controller]")]
    [ApiController]
    public class UserController : Controller
    {
        public IDbConnection getConnection()
        {
            var mssqlConnectionString = "Server=localhost;Database=UserData;Trusted_Connection=True;MultipleActiveResultSets=true";
            IDbConnection conn = new SqlConnection(mssqlConnectionString);
            return conn;
        }

        [Route("add")]
        [HttpPost]
        public IActionResult addUser([FromBody] User user)
        {
            try
            {
                UserRepository u = new UserRepository();
                IDbConnection con = getConnection();
                con.Open();
                string message = "";
                using (con)
                {
                    if (user.UserId != 0)
                    {
                        /* con.Execute("spUpdateUser", new
                         {
                             userName = user.UserName,
                             password = user.Password,
                             genderId = user.Gender,
                             countryId = user.Country,
                             stateId = user.State,
                             languages = user.Languages,
                             dob = user.dob,
                             // userId = user.UserId
                         }, commandType: CommandType.StoredProcedure);*/
                        u.updateUser(user);
                        message = "User UPdated Successfully";
                    }
                    else
                    {
                        /*con.Execute("spAddUser", new
                        {
                            userName = user.UserName,
                            password = user.Password,
                            genderId = user.GenderId,
                            countryId = user.CountryId,
                            stateId = user.StateId,
                            language = user.Languages,
                            dob = user.dob
                        }, commandType: CommandType.StoredProcedure);*/
                        u.addUser(user);
                        message = "User Added Successfully";
                    }
                }
                con.Close();
                return Ok(new UserApiResponse(user, null, message));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        [Route("update")]
        [HttpPut]
        public IActionResult updateUser([FromBody] User user)
        {
            try
            {
                UserRepository u = new UserRepository();
                u.updateUser(user);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("delete")]
        [HttpDelete]
        public IActionResult deleteUser(int id)
        {
            UserRepository u = new UserRepository();

            return Ok(u.deleteUser(id));
        }

        [Route("getAllUser")]
        [HttpGet]
        public IActionResult getAllUser()
        {
            try
            {
                UserRepository u = new UserRepository();
                List<User> users = u.getAllUser();
                return Ok(new UserApiResponse(null, users, "User getsuccessfully"));
            }
            catch (Exception ex)
            {
                return NotFound(new UserApiResponse(null, null, "User List Not Found"));
            }
        }


        [Route("getUserById")]
        [HttpGet]
        public IActionResult getUserById(int id)
        {
            try
            {
                UserRepository u = new UserRepository();
                return Ok(u.getUserDataById(id));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("getUserByUserName")]
        [HttpGet]
        public IActionResult getUserByUserName(string userName)
        {
            try
            {
                UserRepository u = new UserRepository();
                return Ok(u.getUserByUserName(userName));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }




        [Route("getAllCountry")]
        [HttpGet]
        public IActionResult getAllCountry()
        {
            try
            {
                UserRepository u = new UserRepository();
                return Ok(u.getallCountry());
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("getAllState")]
        [HttpGet]
        public IActionResult getAllState()
        {
            try
            {
                UserRepository u = new UserRepository();
                return Ok(u.getAllState());
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("getAllStateByCountryid")]
        [HttpGet]
        public IActionResult getAllStateByCountryid(int countryid)
        {
            try
            {
                return Ok(new UserRepository().getAllStateByCountryId(countryid));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("check")]
        [HttpPost]
        public string checkConnect([FromBody] string str)
        {
            return str;
        }


        [Route("hello")]
        [HttpGet]
        public string getHello()
        {
            string Result = "Good Morning";
            return JsonSerializer.Serialize<string>(Result);
        }
    }
}
