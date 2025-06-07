using System.Net;

namespace DotNetCoreApi.Controllers
{
    public class UserApiResponse
    {
        public User user { get; set; }
        public List<User> users { get; set; }
        public string? message { get; set; }

        public UserApiResponse(User user,List<User> users, string message)
        {
            this.user = user;
            this.users = users;
            this.message = message;
        }
    }
}
