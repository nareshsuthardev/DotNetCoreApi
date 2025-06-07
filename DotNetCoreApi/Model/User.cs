using DotNetCoreApi.Model;

namespace DotNetCoreApi.Controllers
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public Gender Gender { get; set; }
        public Country Country { get; set; }
        public State State { get; set; }
        public string Languages { get; set; }
        public DateTime dob { get; set; }

        public Role Role { get; set; }
        public bool IsDeleted { get; set; }

        public User(int id, string userName, string password, string confirmPassword, Gender genderId, Country countryId, State stateId, string language, bool isDeleted)
        {
            UserId = id;
            UserName = userName;
            Password = password;
            ConfirmPassword = confirmPassword;
            Gender = genderId;
            Country = countryId;
            State = stateId;
            Languages = language;
           
            IsDeleted = isDeleted;
        }

        public User() { }
    }
}
