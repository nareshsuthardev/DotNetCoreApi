using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Microsoft.Extensions.Hosting;
using DotNetCoreApi.Model;

namespace DotNetCoreApi.Controllers
{
    public class UserRepository
    {
        public IDbConnection getConnection()
        {
            var mssqlConnectionString = "Server=localhost;Database=UserData;Trusted_Connection=True;MultipleActiveResultSets=true";
            IDbConnection conn = new SqlConnection(mssqlConnectionString);
            return conn;
        }

        public User getUserById(int id)
        {
            IDbConnection con = getConnection();
            con.Open();
            var sql = @"SELECT         u.UserId,u.Username,u.Password,u.Languages,u.dob,g.Id,g.Name,c.CountryId,c.CountryName,s.SId,s.StateName
                        FROM          [User]  u
                        inner join    Gender  g on u.GenderId=g.Id
                        inner join    Country c on u.CountryId=c.CountryId
                        inner join    [State] s on u.StateId=s.SId
                        where         u.UserId=@id and u.IsDeleted='false'";


            User user = con.Query<User, Gender, Country, State, User>(sql, (user, gender, country, state) =>
            {
                user.Gender = gender;
                user.Country = country;
                user.State = state;
                return user;
            }, new { id = id }, splitOn: "Id,CountryId,SId").AsList().FirstOrDefault();
            con.Close();
            return user;

        }

        public UserData getUserDataById(int id)
        {
            IDbConnection con = getConnection();
            con.Open();
            var sql = @"SELECT         u.UserId,u.Username,u.Password,u.Languages,u.dob,g.Id,g.Name,c.CountryId,c.CountryName,s.SId,s.StateName
                        FROM          [User]  u
                        inner join    Gender  g on u.GenderId=g.Id
                        inner join    Country c on u.CountryId=c.CountryId
                        inner join    [State] s on u.StateId=s.SId
                        where         u.UserId=@id and u.IsDeleted='false'";

            UserData user = con.Query<UserData>("select * from [User] where UserId=@id;", new { id = id }).AsList().First();
            con.Close();
            return user;
        }

        public List<User> getAllUser()
        {
            IDbConnection con = getConnection();
            con.Open();
            List<User> users = new List<User>();
            /* var sql = @"SELECT         u.UserId,u.Username,u.Password,u.Languages,u.dob,g.Id,g.Name,c.CountryId,c.CountryName,s.SId,s.StateName
                         FROM          [User]  u
                         inner join    Gender  g on u.GenderId=g.Id
                         inner join    Country c on u.CountryId=c.CountryId
                         inner join    [State] s on u.StateId=s.SId
                         where         u.IsDeleted='false'";*/
            users = con.Query<User, Gender, Country, State, Role, User>("SelectAllUser", (user, gender, country, state, role) =>
           {
               user.Gender = gender;
               user.Country = country;
               user.State = state;
               user.Role = role;
               return user;
           }, splitOn: "Id,CountryId,SId,RoleId").AsList();
            con.Close();
            return users;
        }

        public User getUserByUserName(string userName)
        {
            var mssqlConnectionString = "Server=localhost;Database=UserData;Trusted_Connection=True;MultipleActiveResultSets=true";
            IDbConnection conn = new SqlConnection(mssqlConnectionString);
            //IDbConnection con = getConnection();
            conn.Open();
            var sql = @"SELECT         u.UserId,u.Username,u.Password,u.Languages,u.dob,g.Id,g.Name,c.CountryId,c.CountryName,s.SId,s.StateName
                        FROM          [User]  u
                        inner join    Gender  g on u.GenderId=g.Id
                        inner join    Country c on u.CountryId=c.CountryId
                        inner join    [State] s on u.StateId=s.SId
                        where         u.Username=@userName and u.IsDeleted='false'";
            User user = conn.Query<User, Gender, Country, State, User>(sql, (user, gender, country, state) =>
             {
                 user.Gender = gender;
                 user.Country = country;
                 user.State = state;
                 return user;
             }, new { userName = userName }, splitOn: "Id,CountryId,SId").AsList().FirstOrDefault();
            conn.Close();
            return user;
        }

        public void addUser(User user)
        {

            //  string sql = "insert into [User] values (@userName,@password,@genderId,@countryId,@stateId,@language,@dob,'false')";
            IDbConnection con = getConnection();
            con.Open();
            con.Execute("spAddUser", new
            {
                userName = user.UserName,
                password = user.Password,
                genderId = user.Gender.Id,
                countryId = user.Country.CountryId,
                stateId = user.State.SId,
                language = user.Languages,
                /* dob = user.dob*/
                roleId = user.Role.RoleId
            }, commandType: CommandType.StoredProcedure);
            con.Close();
        }

        public void updateUser(User user)
        {
            IDbConnection con = getConnection();
            con.Open();
            //  string sql = "update [User] set userName=@userName,password=@password,genderId=@genderId,countryId=@countryId,stateId=@stateId,languages=@languages,dob=@dob where UserId=@userId";
            con.Execute("spUpdateUser", new
            {
                userName = user.UserName,
                password = user.Password,
                genderId = user.Gender.Id,
                countryId = user.Country.CountryId,
                stateId = user.State.SId,
                languages = user.Languages,
                /*dob = user.dob,*/
                roleId=user.Role.RoleId,
                userId = user.UserId
            }, commandType: CommandType.StoredProcedure);
            con.Close();
        }

        public List<Country> getallCountry()
        {
            List<Country> countries = new List<Country>();
            IDbConnection con = getConnection();
            con.Open();
            countries = con.Query<Country>("select * from Country").AsList();
            con.Close();
            return countries;
        }

        public List<State> getAllState()
        {
            List<State> states = new List<State>();
            IDbConnection con = getConnection();
            con.Open();
            states = con.Query<State>("select * from State").AsList();
            con.Close();
            return states;
        }

        public List<State> getAllStateByCountryId(int countryId)
        {
            List<State> states = new List<State>();
            IDbConnection con = getConnection();
            con.Open();
            states = con.Query<State>("select * from State where CountryId=@countryId;", new { countryId = countryId }).AsList();
            con.Close();
            return states;
        }

        public int deleteUser(int userId)
        {
            IDbConnection con = getConnection();
            con.Open();
            //string sql = "update [User] set IsDeleted=@isDeleted where UserId=@userId;";
            int i = con.Execute("spDeleteUser", new { isDeleted = "true", userId = userId }, commandType: CommandType.StoredProcedure);
            con.Close();
            return i;
        }

    }
}
