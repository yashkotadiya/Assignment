using Microsoft.AspNetCore.Mvc;

namespace CI_plateform.Controllers
{
    public class MainController : Controller
    {
        public IActionResult plateform()
        {
            return View();
        }
        public IActionResult volunteer()
        {
            return View();
        }
        public IActionResult storyListing()
        {
            return View();
        }
    }
}
