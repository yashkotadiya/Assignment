
using CI_plateform.Models;
using CI_plateform.Models.Models;
using CI_plateform.Models.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Diagnostics;

namespace CI_plateform.Controllers 
{
    public class HomeController : Controller
    {
       /* private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }*/
        private readonly CiplateformContext _db;

        public HomeController(CiplateformContext db)
        {
            _db = db;
        }

        public IActionResult login()
        {
            return View();
        }
        public IActionResult forgot()
        {
            return View();
        }
        public IActionResult register()
        {
            
            return View();
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult register(RegisterViewModel model)
        {
            if(ModelState.IsValid)
            {
                var user = new User
                {
                    FirstName = model.FirstName,
                    LastName = model.LastName,
                    Email = model.Email,
                    PhoneNumber = model.PhoneNumber,
                    Password = model.Password,
                    CityId = model.CityId,
                    CountryId = model.CountryId, 
                    

                };
                _db.Add(user);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Registration successful. Please login to continue.";
                return RedirectToAction("login");

            }

            return View(model);
        }

        public IActionResult resetpass()
        {
            return View();
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}