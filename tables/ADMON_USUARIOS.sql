USE [CMRISE]
GO

/****** Object:  Table [dbo].[ADMON_USUARIOS]    Script Date: 20/01/2020 15:15:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ADMON_USUARIOS](
	[NUMERO] [bigint] NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[ADMON_USUARIOS_S]),
	[NOMBRE] [varchar](100) NOT NULL,
	[APELLIDO_PATERNO] [varchar](100) NOT NULL,
	[APELLIDO_MATERNO] [varchar](100) NOT NULL,
	[CONTRASENIA] [varchar](100) NOT NULL,
	[TIPO_USUARIO] [varchar](100) NOT NULL,
	[CORREO_ELECTRONICO] [varchar](300) NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT 	ADMON_USUARIOS_PK1 PRIMARY KEY(NUMERO)
) ON [PRIMARY]
GO




