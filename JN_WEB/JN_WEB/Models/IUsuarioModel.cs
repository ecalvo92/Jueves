using JN_WEB.Entities;

namespace JN_WEB.Models
{
    public interface IUsuarioModel
    {
        Respuesta RegistrarUsuario(Usuario ent);

        Respuesta IniciarSesion(Usuario ent);

        Respuesta ConsultarUsuarios();

        Respuesta ConsultarUsuario(int Consecutivo);

        Respuesta ActualizarUsuario(Usuario ent);

        Respuesta RecuperarAcceso(string Identificacion);

        Respuesta CambiarEstadoUsuario(Usuario ent);
    }
}
