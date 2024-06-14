using JN_WEB.Entities;

namespace JN_WEB.Models
{
    public interface IUsuarioModel
    {
        Respuesta RegistrarUsuario(Usuario ent);

        Respuesta IniciarSesion(Usuario ent);
    }
}
