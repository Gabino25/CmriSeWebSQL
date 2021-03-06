USE [CMRISE]
GO

/****** Object:  Table [dbo].[ADMON_USUARIOS]    Script Date: 20/01/2020 15:15:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ADMON_ROLES](
	[NUMERO] [bigint] NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[ADMON_ROLES_S]),
	[NOMBRE] [varchar](100) NOT NULL,
	[DESCRIPCION] [varchar](300) NOT NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT 	ADMON_ROLES_PK1 PRIMARY KEY(NUMERO)
) ON [PRIMARY]
GO