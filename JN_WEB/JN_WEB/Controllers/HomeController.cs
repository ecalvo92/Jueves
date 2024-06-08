using JN_WEB.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace JN_WEB.Controllers
{
    public class HomeController(IUsuarioModel iUsuarioModel) : Controller
    {
        public IActionResult Index()
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
