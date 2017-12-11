USE [Agendate]
GO
/****** Object:  User [agendate]    Script Date: 28/11/2017 10:42:37 p. m. ******/
CREATE USER [agendate] FOR LOGIN [agendate] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [agendate]
GO
/****** Object:  Table [dbo].[Amigo]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  Table [dbo].[Solicitud]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  Table [dbo].[Tarea]    Script Date: 28/11/2017 10:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarea](
	[ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[HayDisponibilidad]    Script Date: 28/11/2017 10:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HayDisponibilidad]

@ID int,
@UsuarioId int,
@HoraComienzo datetime,
@HoraFin datetime

AS

SELECT * 
FROM Tarea 
WHERE Tarea.ID != @ID AND (Tarea.UsuarioId = @UsuarioId AND (
										(
											(@HoraComienzo BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME)) OR (@HoraFin BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME))
										)
										 OR 
										 (
											(HoraComienzo BETWEEN CAST(@HoraComienzo AS DATETIME) AND CAST(@HoraFin AS DATETIME)) OR (HoraFin BETWEEN CAST(@HoraComienzo AS DATETIME) AND CAST(@HoraFin AS DATETIME))
										 )
									 )
							)

--SELECT * 
--FROM Tarea 
--WHERE Tarea.ID != 4 AND (Tarea.UsuarioId = 2 AND (
--										(
--											('2017-11-3 11:45:00.000' BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME)) OR ('2017-11-3 11:50:00.000' BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME))
--										)
--										 OR 
--										 (
--											(HoraComienzo BETWEEN CAST('2017-11-3 11:45:00.000' AS DATETIME) AND CAST('2017-11-3 11:50:00.000' AS DATETIME)) OR (HoraFin BETWEEN CAST('2017-11-3 11:45:00.000' AS DATETIME) AND CAST('2017-11-3 11:50:00.000' AS DATETIME))
--										 )
--									 )
--							)

--SELECT * 
--FROM Tarea 
--WHERE Tarea.UsuarioId = '2' AND ((CAST('2017-10-21 17:05:00.000' AS DATETIME) BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME)) OR (CAST('2017-12-28 23:00:00.000' AS DATETIME) BETWEEN CAST(HoraComienzo AS DATETIME) AND CAST(HoraFin AS DATETIME)))

--'2017-11-23 17:05:00.000'
--'2017-11-23 23:00:00.000'

--SELECT * 
--FROM Tarea 
--WHERE Tarea.UsuarioId = '2' AND (CAST(HoraComienzo AS DATETIME) BETWEEN CAST('2017-11-14 17:10:00.000' AS DATETIME) AND CAST('2017-11-28 1:00:00.000' AS DATETIME)) AND (CAST(HoraFin AS DATETIME) BETWEEN CAST('2017-11-14 17:10:00.000' AS DATETIME) AND CAST('2017-11-28 1:00:00.000' AS DATETIME))

GO
/****** Object:  StoredProcedure [dbo].[ListarTareas]    Script Date: 28/11/2017 10:42:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarTareas]

@UsuarioId int,
@HoraComienzo datetime--,
--@HoraFin datetime

AS

--SELECT * 
--FROM Tarea 
--WHERE UsuarioId = @UsuarioId AND CAST(Tarea.HoraComienzo AS DATE) = CAST(@HoraComienzo AS DATE) order by Tarea.HoraComienzo asc
	
SELECT * 
FROM Tarea 
WHERE Tarea.UsuarioId = @UsuarioId AND (CAST(@HoraComienzo AS DATE) BETWEEN CAST(Tarea.HoraComienzo AS DATE) AND CAST(Tarea.HoraFin AS DATE)) order by Tarea.HoraComienzo asc

	
GO
/****** Object:  StoredProcedure [dbo].[TareaDelete]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[TareaInsert]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[TareaUpdate]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
SET		Nombre = @Nombre, Descripcion = @Descripcion, HoraComienzo = @HoraComienzo, HoraFin = @HoraFin, Lugar = @Lugar
WHERE	ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[UsuarioActualizarFoto]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[UsuarioBuscarEmail]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[UsuarioBuscarPorEmailPassword]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[UsuarioInsert]    Script Date: 28/11/2017 10:42:38 p. m. ******/
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
