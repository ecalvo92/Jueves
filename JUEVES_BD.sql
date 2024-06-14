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
 CONSTRAINT [PK_tUsuario] PRIMARY KEY CLUSTERED 
(
	[Consecutivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[tRol] ON 
GO
INSERT [dbo].[tRol] ([IdRol], [Descripcion]) VALUES (1, N'Administrador')
GO
INSERT [dbo].[tRol] ([IdRol], [Descripcion]) VALUES (2, N'Usuario')
GO
SET IDENTITY_INSERT [dbo].[tRol] OFF
GO

SET IDENTITY_INSERT [dbo].[tUsuario] ON 
GO
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado]) VALUES (1, N'304590415', N'Eduardo', N'ecalvo90415@ufide.ac.cr', N'90415', 1, 1)
GO
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado]) VALUES (2, N'118370494', N'Andrés Canul Bolaños', N'acanul70494@ufide.ac.cr', N'70494', 1, 1)
GO
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado]) VALUES (3, N'206900400', N'Jorge Hernández Araya', N'jhernadez00400@ufide.ac.cr', N'00400', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[tUsuario] OFF
GO

ALTER TABLE [dbo].[tUsuario] ADD  CONSTRAINT [UK_Cedula] UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tUsuario] ADD  CONSTRAINT [UK_Correo] UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tUsuario]  WITH CHECK ADD  CONSTRAINT [FK_tUsuario_tRol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[tRol] ([IdRol])
GO
ALTER TABLE [dbo].[tUsuario] CHECK CONSTRAINT [FK_tUsuario_tRol]
GO

CREATE PROCEDURE [dbo].[IniciarSesion]
	@Correo			varchar(100),
	@Contrasenna	varchar(100)
AS
BEGIN

	SELECT	Consecutivo,Identificacion,Nombre,Correo,U.IdRol,Estado,R.Descripcion
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

	DECLARE @Rol	TINYINT = 1,
			@Estado	BIT		= 1

	IF NOT EXISTS(SELECT 1 FROM dbo.tUsuario WHERE Correo = @Correo OR Identificacion = @Identificacion)
	BEGIN

		INSERT INTO dbo.tUsuario(Identificacion,Nombre,Correo,Contrasenna,IdRol,Estado)
		VALUES (@Identificacion,@Nombre,@Correo,@Contrasenna,@Rol,@Estado)

	END

END
GO
