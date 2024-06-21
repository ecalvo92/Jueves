using JN_WEB.Entities;
using JN_WEB.Models;
using Microsoft.AspNetCore.Mvc;

namespace JN_WEB.Controllers
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class HomeController(IUsuarioModel iUsuarioModel) : Controller
    {
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Index(Usuario ent)
        {
            var resp = iUsuarioModel.IniciarSesion(ent);

            if (resp.Codigo == 1)
                return RedirectToAction("Home","Home");

            ViewBag.msj = resp.Mensaje;
            return View();
        }


        [HttpGet]
        public IActionResult RegistrarUsuario()
        {
            return View();
        }

        [HttpPost]
        public IActionResult RegistrarUsuario(Usuario ent)
        {
            var resp = iUsuarioModel.RegistrarUsuario(ent);

            if (resp.Codigo == 1)
                return RedirectToAction("Index", "Home");

            ViewBag.msj = resp.Mensaje;
            return View();
        }


        [HttpGet]
        public IActionResult Home()
        {
            return View();
        }        

    }
}
