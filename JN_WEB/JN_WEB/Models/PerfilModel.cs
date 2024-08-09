using JN_WEB.Entities;
using Microsoft.Extensions.Configuration;
using System.Net.Http.Headers;
using System.Net.Http;

namespace JN_WEB.Models
{
    public class PerfilModel(HttpClient httpClient, IConfiguration iConfiguration, IHttpContextAccessor iContextAccesor) : IPerfilModel
    {
        public Respuesta CambiarContrasenna(Usuario ent)
        {
            using (httpClient)
            {
                string url = iConfiguration.GetSection("Llaves:UrlApi").Value + "Perfil/CambiarContrasenna";
                string token = iContextAccesor.HttpContext!.Session.GetString("TOKEN")!.ToString();

                JsonContent body = JsonContent.Create(ent);
                httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                var resp = httpClient.PutAsync(url, body).Result;

                if (resp.IsSuccessStatusCode)
                    return resp.Content.ReadFromJsonAsync<Respuesta>().Result!;
                else
                    return new Respuesta();
            }
        }
    }
}
