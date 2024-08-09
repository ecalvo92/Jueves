using Dapper;
using JN_API.Entities;
using JN_API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace JN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PerfilController(IConfiguration iConfiguration, IComunesModel iComunesModel) : ControllerBase
    {
        [Authorize]
        [HttpPut]
        [Route("CambiarContrasenna")]
        public async Task<IActionResult> CambiarContrasenna(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var Contrasenna = iComunesModel.Encrypt(ent.Contrasenna!);
                var EsTemporal = false;
                var VigenciaTemporal = DateTime.Now;

                var result = await context.ExecuteAsync("ActualizarContrasenna", 
                    new { ent.Consecutivo, Contrasenna, EsTemporal, VigenciaTemporal }, commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = true;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "La contraseña del usuario no se pudo actualizar";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }
    }
}
