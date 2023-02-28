using CI_plateform.Models.Models;
using CI_plateform.Models.ViewModels;
using CI_plateform.Repository.Repository.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CI_plateform.Repository.Repository
{
    public class UserRepository : BaseRepository
    {
        private readonly CiplateformContext _context;

        public UserRepository(CiplateformContext context)
        {
            _context = context;
        }
        public async Task<int> CreateUser(RegisterViewModel model)
        {
            var user = new User()
            {
                FirstName = model.FirstName,
                LastName = model.LastName,
                Email = model.Email,
                PhoneNumber = model.PhoneNumber,
                Password = model.Password,
                CityId = model.CityId,
                CountryId = model.CountryId,
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return 1;
        }

        public async Task<int> LoginUser(RegisterViewModel model)
        {
            var userExists = _context.Users.Any(u => u.Email == model.Email && u.Password == model.Password);
            await _context.SaveChangesAsync();
            return userExists ? 1 : 0;
          

        }

        public async Task<int> ForgotUserPass(RegisterViewModel model)
        {
            var userExists = _context.Users.Any(u => u.Email == model.Email);
            await _context.SaveChangesAsync();
            return userExists ? 1 : 0;
              
        }
    }
    
}
