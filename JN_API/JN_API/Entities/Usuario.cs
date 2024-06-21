namespace JN_API.Entities
{
    public class Usuario
    {
        public int Consecutivo { get; set; }
        public string? Identificacion { get; set; }
        public string? Nombre { get; set; }
        public string? Correo { get; set; }
        public string? Contrasenna { get; set; }
        public string? Token { get; set; }
    }
}