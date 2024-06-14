using JN_WEB.Entities;

namespace JN_WEB.Models
{
    public class UsuarioModel (HttpClient httpClient) : IUsuarioModel
    {
        public Respuesta RegistrarUsuario(Usuario ent)
        {
            using (httpClient)
            {
                string url = "https://localhost:7009/api/Usuario/RegistrarUsuario";
                JsonContent body = JsonContent.Create(ent);
                var resp = httpClient.PostAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }

        public Respuesta IniciarSesion(Usuario ent)
        {
            using (httpClient)
            {
                string url = "https://localhost:7009/api/Usuario/IniciarSesion";
                JsonContent body = JsonContent.Create(ent);
                var resp = httpClient.PostAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}