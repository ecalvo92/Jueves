USE [master]
GO

CREATE DATABASE [JUEVES_BD]
GO

USE [JUEVES_BD]
GO

CREATE TABLE [dbo].[tCategoria](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[NombreCategoria] [varchar](250) NOT NULL,
 CONSTRAINT [PK_tCategoria] PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tProducto](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[PrecioUnitario] [decimal](18, 2) NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[Inventario] [int] NOT NULL,
	[Imagen] [varchar](500) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_tProducto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tProveedor](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[NombreProveedor] [varchar](250) NULL,
 CONSTRAINT [PK_tProveedor] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[tCategoria] ON 
GO
INSERT [dbo].[tCategoria] ([IdCategoria], [NombreCategoria]) VALUES (1, N'Tecnología')
GO
INSERT [dbo].[tCategoria] ([IdCategoria], [NombreCategoria]) VALUES (2, N'Ropa')
GO
INSERT [dbo].[tCategoria] ([IdCategoria], [NombreCategoria]) VALUES (3, N'Alimentos')
GO
SET IDENTITY_INSERT [dbo].[tCategoria] OFF
GO

SET IDENTITY_INSERT [dbo].[tProducto] ON 
GO
INSERT [dbo].[tProducto] ([IdProducto], [Nombre], [Descripcion], [PrecioUnitario], [IdCategoria], [IdProveedor], [Inventario], [Imagen], [Estado]) VALUES (3, N'Play station 5', N'PlayStation 5 es la quinta consola de videojuegos de sobremesa desarrollada por la empresa Sony Interactive Entertainment, a la vez que es la tercera consola de Sony en ser diseñada por Mark Cerny.', CAST(315000.00 AS Decimal(18, 2)), 1, 1, 10, N'https://th.bing.com/th/id/OIP.TUq7Z7NWXVVwiz0iNLKd7QHaHa?rs=1&pid=ImgDetMain', 1)
GO
INSERT [dbo].[tProducto] ([IdProducto], [Nombre], [Descripcion], [PrecioUnitario], [IdCategoria], [IdProveedor], [Inventario], [Imagen], [Estado]) VALUES (5, N'Camiseta Real Madrid', N'
Kylian Mbappé Kits
Introducing the official jersey and kit of your favorite player, Kylian Mbappé! It features Mbappe''s official number and name on the back, as well as Champions League and Spanish League badges.', CAST(70000.00 AS Decimal(18, 2)), 2, 2, 15, N'https://w7.pngwing.com/pngs/638/671/png-transparent-white-adidas-polo-shirt-real-madrid-c-f-uefa-champions-league-jersey-shirt-kit-jersey-tshirt-white-logo.png', 1)
GO
SET IDENTITY_INSERT [dbo].[tProducto] OFF
GO

SET IDENTITY_INSERT [dbo].[tProveedor] ON 
GO
INSERT [dbo].[tProveedor] ([IdProveedor], [NombreProveedor]) VALUES (1, N'Amazon')
GO
INSERT [dbo].[tProveedor] ([IdProveedor], [NombreProveedor]) VALUES (2, N'Shein')
GO
INSERT [dbo].[tProveedor] ([IdProveedor], [NombreProveedor]) VALUES (3, N'Walmart')
GO
SET IDENTITY_INSERT [dbo].[tProveedor] OFF
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
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado], [EsTemporal], [VigenciaTemporal]) VALUES (1, N'304590415', N'Eduardo José Calvo Castillo', N'ecalvo90415@ufide.ac.cr', N'cSKGG1tdQNeyv7wJWXXCiw==', 2, 1, NULL, NULL)
GO
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado], [EsTemporal], [VigenciaTemporal]) VALUES (2, N'305070199', N'Tifanny Andrea Camacho Monge', N'tcamacho70199@ufide.ac.cr', N'5WTxeR6FTuUE6YMYTcYTMA==', 1, 1, 0, CAST(N'2024-08-08T19:34:30.827' AS DateTime))
GO
INSERT [dbo].[tUsuario] ([Consecutivo], [Identificacion], [Nombre], [Correo], [Contrasenna], [IdRol], [Estado], [EsTemporal], [VigenciaTemporal]) VALUES (1002, N'115390597', N'Brayam Perez Reyes', N'bperez90597@ufide.ac.cr', N'ZC9bbl+1mRONkmaW/maXiA==', 2, 1, NULL, NULL)
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

ALTER TABLE [dbo].[tProducto]  WITH CHECK ADD  CONSTRAINT [FK_tProducto_tProveedor] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[tProveedor] ([IdProveedor])
GO
ALTER TABLE [dbo].[tProducto] CHECK CONSTRAINT [FK_tProducto_tProveedor]
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

CREATE PROCEDURE [dbo].[ConsultarProductos]

AS
BEGIN

	SELECT	IdProducto,
			Nombre,
			Descripcion,
			PrecioUnitario,
			P.IdCategoria,
			C.NombreCategoria,
			P.IdProveedor,
			Pr.NombreProveedor,
			Inventario,
			Imagen,
			Estado
	  FROM dbo.tProducto P
	  INNER JOIN dbo.tCategoria C ON P.IdCategoria = C.IdCategoria
	  INNER JOIN dbo.tProveedor Pr ON P.IdProveedor = Pr.IdProveedor

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