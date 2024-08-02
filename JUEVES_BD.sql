USE [master]
GO

CREATE DATABASE [JUEVES_BD]
GO

USE [JUEVES_BD]
GO

CREATE TABLE [dbo].[tRol](
	[IdRol] [tinyint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tRol] PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tUsuario](
	[Consecutivo] [int] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contrasenna] [varchar](100) NOT NULL,
	[IdRol] [tinyint] NOT NULL,
	[Estado] [bit] NOT NULL,
	[EsTemporal] [bit] NULL,
	[VigenciaTemporal] [datetime] NULL,
 CONSTRAINT [PK_tUsuario] PRIMARY KEY CLUSTERED 
(
	[Consecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Cedula] UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_Correo] UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tUsuario]  WITH CHECK ADD  CONSTRAINT [FK_tUsuario_tRol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[tRol] ([IdRol])
GO
ALTER TABLE [dbo].[tUsuario] CHECK CONSTRAINT [FK_tUsuario_tRol]
GO

CREATE PROCEDURE [dbo].[ActualizarContrasenna]
	@Consecutivo INT, 
	@Contrasenna VARCHAR(100),
	@EsTemporal	 BIT, 
	@VigenciaTemporal DATETIME
AS
BEGIN

	UPDATE tUsuario
	   SET Contrasenna = @Contrasenna,
		   EsTemporal = @EsTemporal,
		   VigenciaTemporal = @VigenciaTemporal
	 WHERE Consecutivo = @Consecutivo

END
GO

CREATE PROCEDURE [dbo].[ActualizarUsuario]
	@Consecutivo	INT,
	@Identificacion VARCHAR(50),
	@Nombre			VARCHAR(100),
	@Correo			VARCHAR(100),
	@IdRol			TINYINT
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.tUsuario WHERE	(Correo = @Correo 
												OR	Identificacion = @Identificacion)
												AND Consecutivo != @Consecutivo)
	BEGIN

		UPDATE tUsuario
		   SET Identificacion = @Identificacion,
			   Nombre = @Nombre,
			   Correo = @Correo,
			   IdRol = @IdRol
		 WHERE Consecutivo = @Consecutivo

	END

END
GO

CREATE PROCEDURE [dbo].[CambiarEstadoUsuario]
	@Consecutivo INT
AS
BEGIN

	UPDATE tUsuario
	   SET Estado = CASE WHEN Estado = 1 THEN 0 ELSE 1 END
	 WHERE Consecutivo = @Consecutivo

END
GO

CREATE PROCEDURE [dbo].[ConsultarRoles]

AS
BEGIN

	SELECT IdRol 'value', Descripcion 'text'
	FROM tRol

END
GO

CREATE PROCEDURE [dbo].[ConsultarUsuario]
	@Consecutivo INT
AS
BEGIN

	SELECT	Consecutivo,Identificacion,Nombre,Correo,U.IdRol,
	CASE WHEN Estado = 1 THEN 'Activo' ELSE 'Inactivo' END 'Estado',R.Descripcion
	FROM	dbo.tUsuario U
	INNER JOIN dbo.tRol  R ON U.IdRol = R.IdRol
	WHERE Consecutivo = @Consecutivo

END
GO

CREATE PROCEDURE [dbo].[ConsultarUsuarioIdentificacion]
	@Identificacion INT
AS
BEGIN

	SELECT	Consecutivo,Identificacion,Nombre,Correo,U.IdRol,
	CASE WHEN Estado = 1 THEN 'Activo' ELSE 'Inactivo' END 'Estado',R.Descripcion
	FROM	dbo.tUsuario U
	INNER JOIN dbo.tRol  R ON U.IdRol = R.IdRol
	WHERE Identificacion = @Identificacion

END
GO

CREATE PROCEDURE [dbo].[ConsultarUsuarios]
	
AS
BEGIN

	SELECT	Consecutivo,Identificacion,Nombre,Correo,U.IdRol,
	CASE WHEN Estado = 1 THEN 'Activo' ELSE 'Inactivo' END 'Estado',R.Descripcion
	FROM	dbo.tUsuario U
	INNER JOIN dbo.tRol  R ON U.IdRol = R.IdRol

END
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@Correo			varchar(100),
	@Contrasenna	varchar(100)
AS
BEGIN

	SELECT	Consecutivo,Identificacion,Nombre,Correo,U.IdRol,Estado,R.Descripcion,
			EsTemporal, VigenciaTemporal
	FROM	dbo.tUsuario U
	INNER JOIN dbo.tRol  R ON U.IdRol = R.IdRol
	WHERE	Correo = @Correo
		AND Contrasenna = @Contrasenna
		AND Estado = 1

END
GO

CREATE PROCEDURE [dbo].[RegistrarUsuario]
	@Identificacion varchar(50),
	@Nombre			varchar(100),
	@Correo			varchar(100),
	@Contrasenna	varchar(100)
AS
BEGIN

	DECLARE @Rol		TINYINT = 2,
			@Estado		BIT		= 1,
			@Temporal	BIT		= 0

	IF NOT EXISTS(SELECT 1 FROM dbo.tUsuario WHERE Correo = @Correo OR Identificacion = @Identificacion)
	BEGIN

		INSERT INTO dbo.tUsuario(Identificacion,Nombre,Correo,Contrasenna,IdRol,Estado,EsTemporal,VigenciaTemporal)
		VALUES (@Identificacion,@Nombre,@Correo,@Contrasenna,@Rol,@Estado,@Temporal,GETDATE())

	END

END
GO