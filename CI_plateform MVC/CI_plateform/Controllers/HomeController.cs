
using CI_plateform.Models;
using CI_plateform.Models.Models;
using CI_plateform.Models.ViewModels;
using CI_plateform.Repository.Repository.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Diagnostics;

namespace CI_plateform.Controllers 
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly BaseRepository _userRepository;
        public HomeController(ILogger<HomeController> logger, BaseRepository userRepository)
        {
            _logger = logger;
            _userRepository = userRepository;
        }

        [Route("", Name = "Default")]
        [Route("Home/login", Name = "login") ]
        public IActionResult login()
        {
            return View();
        }

        [HttpPost]
        [Route("Home/login", Name = "login")]
        public async Task<IActionResult> login(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
               
                int x = await _userRepository.LoginUser(model);
                if (x==1)
                {
                    return RedirectToAction("plateform", "Main");
                }
               
            }
            return View(model);
        }
        public IActionResult forgot()
        {
            return View();
        }

        [HttpPost]
        [Route("Home/forgot",Name="forgot")]
        public async Task<IActionResult> forgot(RegisterViewModel model)
        {
            if(ModelState.IsValid)
            {
                int x = await _userRepository.ForgotUserPass(model);
                if (x == 1)
                {
                    return RedirectToAction("resetpass", "Home");
                }
            }
            return View(model);
        }
        public IActionResult register()
        {
            
            return View();
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
       
        public async Task<IActionResult> register(RegisterViewModel model)
        {

            if (ModelState.IsValid)
            {
                await _userRepository.CreateUser(model);
                return RedirectToRoute("login");
            }

            ViewData["ModelState"] = "Model state invalid.";
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