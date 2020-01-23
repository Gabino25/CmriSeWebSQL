USE [CMRISE]
GO

/****** Object:  Table [dbo].[MRQS_PREGUNTAS_HDR]    Script Date: 23/01/2020 10:55:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MRQS_PREGUNTAS_HDR](
	[NUMERO] [bigint] NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[MRQS_PREGUNTAS_HDR_S]),
	[NOMBRE] [varchar](200) NOT NULL,
	[TITULO] [varchar](200) NOT NULL,
	[TIPO_PREGUNTA] [varchar](30) NOT NULL,
	[TEMA_PREGUNTA] [varchar](30) NOT NULL,
	[ETIQUETAS] [varchar](500) NULL,
	[COMENTARIOS] [varchar](1000) NULL,
	[ESTATUS] [varchar](30) NOT NULL,
	[SOCIEDAD] [varchar](200) NOT NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
 CONSTRAINT [MRQS_PREGUNTAS_HDR_PK1] PRIMARY KEY ([NUMERO]) 
 )
GO



