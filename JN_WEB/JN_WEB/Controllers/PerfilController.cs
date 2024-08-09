using JN_WEB.Entities;
using JN_WEB.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace JN_WEB.Controllers
{
    [FiltroSesiones]
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class PerfilController(IUsuarioModel iUsuarioModel, IPerfilModel iPerfilModel) : Controller
    {
        [HttpGet]
        public IActionResult ActualizarPerfilUsuario()
        {
            var consecutivo = HttpContext.Session.GetInt32("CONSECUTIVO")!.Value;
            var resp = iUsuarioModel.ConsultarUsuario(consecutivo);

            if (resp.Codigo == 1)
            {
                var datos = JsonSerializer.Deserialize<Usuario>((JsonElement)resp.Contenido!);
                return View(datos);
            }

            return View(new Usuario());
        }

        [HttpPost]
        public IActionResult ActualizarPerfilUsuario(Usuario ent)
        {
            var resp = iUsuarioModel.ActualizarUsuario(ent);

            if (resp.Codigo == 1)
            {
                HttpContext.Session.SetString("NOMBRE", ent!.Nombre!);
                return RedirectToAction("Home", "Home");
            }

            ViewBag.msj = resp.Mensaje;
            return View();
        }


        [HttpGet]
        public IActionResult CambiarContrasenna()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CambiarContrasenna(Usuario ent)
        {
            ent.Consecutivo = HttpContext.Session.GetInt32("CONSECUTIVO")!.Value;
            if (ent.Contrasenna != ent.ContrasennaConfirmar)
            {
                ViewBag.msj = "Las contraseñas ingresadas no coinciden";
                return View();
            }

            var resp = iPerfilModel.CambiarContrasenna(ent);

            if (resp.Codigo == 1)
            {
                return RedirectToAction("Salir", "Home");
            }

            ViewBag.msj = resp.Mensaje;
            return View();
        }

    }
}
