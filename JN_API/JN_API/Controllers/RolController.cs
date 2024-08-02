using Dapper;
using JN_API.Entities;
using JN_API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace JN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RolController(IConfiguration iConfiguration, IComunesModel iComunesModel) : ControllerBase
    {
        [Authorize]
        [HttpGet]
        [Route("ConsultarRoles")]
        public async Task<IActionResult> ConsultarRoles()
        {
            if (!iComunesModel.EsAdministrador(User))
                return StatusCode(403);

            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.QueryAsync<SelectListItem>("ConsultarRoles", new { }, commandType: CommandType.StoredProcedure);

                if (result.Count() > 0)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay roles registrados en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

    }
}
