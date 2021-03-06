USE [CMRISE]
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MRQS_GRUPO_LINES](
	[NUMERO] [bigint] NOT NULL  DEFAULT (NEXT VALUE FOR [dbo].[MRQS_GRUPO_LINES_S] ),
	[NUMERO_HDR] [bigint] NOT NULL,
	[NUMERO_PREGUNTA] [bigint] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT MRQS_GRUPO_LINES_PK PRIMARY KEY(NUMERO),
	CONSTRAINT MRQS_GRUPO_LINES_FK1 FOREIGN KEY(NUMERO_HDR) REFERENCES [dbo].[MRQS_GRUPO_HDR](NUMERO), 
	CONSTRAINT MRQS_GRUPO_LINES_FK2 FOREIGN KEY(NUMERO_PREGUNTA) REFERENCES [dbo].[MRQS_PREGUNTAS_HDR](NUMERO)
)