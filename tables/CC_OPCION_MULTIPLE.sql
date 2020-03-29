USE [CMRISE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC_OPCION_MULTIPLE](
	[NUMERO] [bigint] NOT NULL  DEFAULT (NEXT VALUE FOR [DBO].[CC_OPCION_MULTIPLE_S]),
	[NUMERO_FTA] [bigint] NOT NULL,
	[ESTATUS] [bit] NOT NULL,
	[TEXTO_RESPUESTA] [varchar](500) NULL,
	[TEXTO_EXPLICACION] [varchar](500) NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
    CONSTRAINT [CC_OPCION_MULTIPLE_PK1] PRIMARY KEY ([NUMERO]),
	CONSTRAINT [CC_OPCION_MULTIPLE_FK1] FOREIGN KEY([NUMERO_FTA]) REFERENCES [dbo].[CC_PREGUNTAS_FTA] ([NUMERO])
	)
GO

