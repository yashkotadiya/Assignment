﻿using Microsoft.AspNetCore.Mvc;

namespace CI_plateform.Controllers
{
    public class MainController : Controller
    {
        public IActionResult plateform()
        {
            return View();
        }
    }
}