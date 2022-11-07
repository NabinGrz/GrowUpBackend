using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet("home")]
        public string Index()
        {
            return "<h2>Growup Application Backend</h2>";
        }
    }
}
