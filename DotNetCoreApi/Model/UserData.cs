using DotNetCoreApi.Controllers;

namespace DotNetCoreApi.Model
{
    public class UserData
    {
      /*  public int UserId { get; set; }*/
        public string? UserName { get; set; }
        public string? Password { get; set; }
        public string? ConfirmPassword { get; set; }
        public int GenderId { get; set; }
        public int CountryId { get; set; }
        public int StateId { get; set; }
        public string? Languages { get; set; }
        public DateTime dob { get; set; }
    }
}
