using Dapper;
using JN_API.Entities;
using JN_API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace JN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController(IConfiguration iConfiguration, IComunesModel iComunesModel, IHostEnvironment iHost) : ControllerBase
    {
        [AllowAnonymous]
        [HttpPost]
        [Route("RegistrarUsuario")]
        public async Task<IActionResult> RegistrarUsuario(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.ExecuteAsync("RegistrarUsuario", new { ent.Identificacion, ent.Nombre, ent.Correo, ent.Contrasenna }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "La información del usuario ya se encuentra registrada";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [AllowAnonymous]
        [HttpPost]
        [Route("IniciarSesion")]
        public async Task<IActionResult> IniciarSesion(Usuario ent)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("IniciarSesion", new { ent.Correo, ent.Contrasenna }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    result.Token = GenerarToken(result.Consecutivo, result.IdRol);

                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "La información del usuario no se encuentra registrada";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [Authorize]
        [HttpGet]
        [Route("ConsultarUsuarios")]
        public async Task<IActionResult> ConsultarUsuarios()
        {
            if (!iComunesModel.EsAdministrador(User))
                return StatusCode(403);

            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.QueryAsync<Usuario>("ConsultarUsuarios", new {  }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "No hay usuarios registrados en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [Authorize]
        [HttpGet]
        [Route("ConsultarUsuario")]
        public async Task<IActionResult> ConsultarUsuario(int Consecutivo)
        {
            if (!iComunesModel.EsAdministrador(User))
                return StatusCode(403);

            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("ConsultarUsuario", new { Consecutivo }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay usuarios registrados en este momento";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [Authorize]
        [HttpPut]
        [Route("CambiarEstadoUsuario")]
        public async Task<IActionResult> CambiarEstadoUsuario(Usuario ent)
        {
            if (!iComunesModel.EsAdministrador(User))
                return StatusCode(403);

            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.ExecuteAsync("CambiarEstadoUsuario", new { ent.Consecutivo }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "El estado del usuario no se pudo actualizar";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [Authorize]
        [HttpPut]
        [Route("ActualizarUsuario")]
        public async Task<IActionResult> ActualizarUsuario(Usuario ent)
        {
            if (!iComunesModel.EsAdministrador(User))
                return StatusCode(403);

            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.ExecuteAsync("ActualizarUsuario", new { ent.Consecutivo, ent.Identificacion, ent.Nombre, ent.Correo, ent.IdRol }, commandType: CommandType.StoredProcedure);

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
                    resp.Mensaje = "La información del usuario no se pudo actualizar";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        [HttpGet]
        [Route("RecuperarAcceso")]
        public async Task<IActionResult> RecuperarAcceso(string Identificacion)
        {
            Respuesta resp = new Respuesta();

            using (var context = new SqlConnection(iConfiguration.GetSection("ConnectionStrings:DefaultConnection").Value))
            {
                var result = await context.QueryFirstOrDefaultAsync<Usuario>("ConsultarUsuarioIdentificacion", new { Identificacion }, commandType: CommandType.StoredProcedure);

                if (result != null)
                {
                    var CodigoAleatorio = iComunesModel.GenerarCodigo();
                    var Contrasenna = iComunesModel.Encrypt(CodigoAleatorio);
                    var EsTemporal = true;
                    var VigenciaTemporal = DateTime.Now.AddMinutes(30);

                    await context.ExecuteAsync("ActualizarContrasenna",
                        new { result.Consecutivo, Contrasenna, EsTemporal, VigenciaTemporal },
                        commandType: CommandType.StoredProcedure);

                    var ruta = Path.Combine(iHost.ContentRootPath, "FormatoCorreo.html");
                    var html = System.IO.File.ReadAllText(ruta);

                    html = html.Replace("@@Nombre", result.Nombre);
                    html = html.Replace("@@Contrasenna", CodigoAleatorio);
                    html = html.Replace("@@Vencimiento", VigenciaTemporal.ToString("dd/MM/yyyy HH:mm"));

                    iComunesModel.EnviarCorreo(result.Correo!, "Recuperar Acceso Sistema", html);

                    resp.Codigo = 1;
                    resp.Mensaje = "OK";
                    resp.Contenido = result;
                    return Ok(resp);
                }
                else
                {
                    resp.Codigo = 0;
                    resp.Mensaje = "No hay usuarios registrados con esa identificación";
                    resp.Contenido = false;
                    return Ok(resp);
                }
            }
        }

        private string GenerarToken(int Consecutivo, int IdRol)
        {
            string SecretKey = iConfiguration.GetSection("Llaves:SecretKey").Value!;
            List<Claim> claims = new List<Claim>();
            claims.Add(new Claim(ClaimTypes.Name, Consecutivo.ToString()));
            claims.Add(new Claim("IdRol", IdRol.ToString()));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(SecretKey));
            var cred = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(10),
                signingCredentials: cred);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}