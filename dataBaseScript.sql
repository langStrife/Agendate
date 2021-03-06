USE [master]
GO
/****** Object:  Database [Agendate]    Script Date: 9/11/2017 9:00:21 p. m. ******/
CREATE DATABASE [Agendate] ON  PRIMARY 
( NAME = N'Agendate', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Agendate.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Agendate_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Agendate_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Agendate] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Agendate].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Agendate] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Agendate] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Agendate] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Agendate] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Agendate] SET ARITHABORT OFF 
GO
ALTER DATABASE [Agendate] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Agendate] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Agendate] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Agendate] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Agendate] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Agendate] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Agendate] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Agendate] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Agendate] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Agendate] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Agendate] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Agendate] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Agendate] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Agendate] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Agendate] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Agendate] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Agendate] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Agendate] SET RECOVERY FULL 
GO
ALTER DATABASE [Agendate] SET  MULTI_USER 
GO
ALTER DATABASE [Agendate] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Agendate] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Agendate', N'ON'
GO
USE [Agendate]
GO
/****** Object:  User [agendate]    Script Date: 9/11/2017 9:00:21 p. m. ******/
CREATE USER [agendate] FOR LOGIN [agendate] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [agendate]
GO
/****** Object:  Table [dbo].[Amigo]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Amigo](
	[UsuarioID] [int] NOT NULL,
	[AmigoID] [int] NOT NULL,
	[FechaAlta] [datetime] NOT NULL,
 CONSTRAINT [PK_Amigo_1] PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC,
	[AmigoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Solicitud]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[UsuarioIDSolicita] [int] NOT NULL,
	[SolicitudEstadoID] [tinyint] NOT NULL,
	[FechaAlta] [datetime] NOT NULL,
	[FechaModificacion] [datetime] NULL,
 CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tarea]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarea](
	[ID] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Descripcion] [nvarchar](200) NULL,
	[HoraComienzo] [datetime] NOT NULL,
	[HoraFin] [datetime] NOT NULL,
	[Lugar] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tarea] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Apellido] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [nchar](1) NOT NULL,
	[Foto] [nvarchar](100) NULL,
	[FechaRegistracion] [datetime] NOT NULL,
	[FechaActualizacion] [datetime] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Amigo] ADD  CONSTRAINT [DF_Amigo_FechaAlta]  DEFAULT (getdate()) FOR [FechaAlta]
GO
ALTER TABLE [dbo].[Solicitud] ADD  CONSTRAINT [DF_Solicitud_FechaAlta]  DEFAULT (getdate()) FOR [FechaAlta]
GO
ALTER TABLE [dbo].[Amigo]  WITH CHECK ADD  CONSTRAINT [FK_Amigo_Usuario] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Amigo] CHECK CONSTRAINT [FK_Amigo_Usuario]
GO
ALTER TABLE [dbo].[Solicitud]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Usuario] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Solicitud] CHECK CONSTRAINT [FK_Solicitud_Usuario]
GO
ALTER TABLE [dbo].[Tarea]  WITH CHECK ADD  CONSTRAINT [FK_Tarea_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuario] ([ID])
GO
ALTER TABLE [dbo].[Tarea] CHECK CONSTRAINT [FK_Tarea_Usuario]
GO
/****** Object:  StoredProcedure [dbo].[ListarTareas]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarTareas]

@HoraComienzo datetime

AS

SELECT * 
FROM Tarea 
WHERE CAST(Tarea.HoraComienzo AS DATE) = CAST(@HoraComienzo AS DATE) order by Tarea.HoraComienzo asc
	


	
GO
/****** Object:  StoredProcedure [dbo].[ListarTareasPorDia]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarTareasPorDia]

@ID int,
@HoraComienzo datetime,
@HoraFin datetime

AS

SELECT * 
FROM Tarea 
WHERE UsuarioId = @ID 
--and (cast(HoraComienzo as date) = cast(cast(@HoraComienzo as datetime) as date) 
--or cast(HoraFin as date) = cast(cast(@HoraFin as datetime) as date))

/* corregir el casteo de las variables @HoraComienzo y @HoraFin*/
GO
/****** Object:  StoredProcedure [dbo].[TareaDelete]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TareaDelete] 
@ID int

AS 

DELETE Tarea 
WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[TareaInsert]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TareaInsert]

@UsuarioId int,
@Nombre nvarchar(30),
@Descripcion nvarchar(200),
@HoraComienzo datetime,
@HoraFin datetime,
@Lugar nvarchar(50)

AS

INSERT INTO Tarea
(
UsuarioID,
Nombre,
Descripcion,
HoraComienzo,
HoraFin,
Lugar
)
VALUES
(
@UsuarioId,
@Nombre,
@Descripcion,
@HoraComienzo,
@HoraFin,
@Lugar
)

RETURN SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[TareaUpdate]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TareaUpdate] 

@ID int,
@Nombre nvarchar(30),
@Descripcion nvarchar(200),
@HoraComienzo datetime,
@HoraFin datetime,
@Lugar nvarchar(50)

AS

UPDATE	Tarea
SET		Nombre = @Nombre, Descripcion = @Descripcion, HoraComienzo = @HoraComienzo, HoraFin = @HoraFin, @Lugar = Lugar
WHERE	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[UsuarioActualizarFoto]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioActualizarFoto]

@ID int,
@Foto nvarchar(100)

AS

UPDATE	Usuario
SET		Foto = @Foto
WHERE	ID = @ID

GO
/****** Object:  StoredProcedure [dbo].[UsuarioBuscarEmail]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioBuscarEmail]

@Email nvarchar(100)

AS

IF EXISTS (SELECT * FROM Usuario WHERE Email = @Email)
	SELECT 1
ELSE
	SELECT 0

GO
/****** Object:  StoredProcedure [dbo].[UsuarioBuscarPorEmailPassword]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioBuscarPorEmailPassword]

@Email nvarchar(100),
@Password nvarchar(100)

AS

SELECT	*
FROM	Usuario
WHERE	Email = @Email AND
		Password = @Password

GO
/****** Object:  StoredProcedure [dbo].[UsuarioInsert]    Script Date: 9/11/2017 9:00:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsuarioInsert]

@Nombre nvarchar(30),
@Apellido nvarchar(30),
@Email nvarchar(100),
@Password nvarchar(100),
@FechaNacimiento date,
@Sexo nchar(1),
@FechaRegistracion datetime

AS

INSERT INTO Usuario
(
Nombre,
Apellido,
Email,
Password,
FechaNacimiento,
Sexo,
FechaRegistracion
)
VALUES
(
@Nombre,
@Apellido,
@Email,
@Password,
@FechaNacimiento,
@Sexo,
@FechaRegistracion
)

RETURN SCOPE_IDENTITY()

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1=Pendiente
2=Aceptada
3=Rechazada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Solicitud', @level2type=N'COLUMN',@level2name=N'SolicitudEstadoID'
GO
USE [master]
GO
ALTER DATABASE [Agendate] SET  READ_WRITE 
GO
