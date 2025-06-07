using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DotNetCoreApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        [HttpGet(Name ="GetAlpha")]
        public List<string> GetStrings()
        {
            List<string> strings = new List<string>();
            strings.Add("A");
            strings.Add("B");
            strings.Add("C");
            strings.Add("D");
            strings.Add("E");
            return strings;
        }

        /*[HttpPost]
        public string addUser(User user)
        {
            return user.UserName;
        }*/

        [Route("api/student/names")]
        [HttpPost]
        public string addUses(User user)
        {
            return user.UserName;
        }

        [HttpDelete(Name ="deleteUser")]
        public int deleteUser(int id)
        {
            return id;
        }

        
    }
}
