USE [CMRISE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MRQS_GRUPO_HDR](
	[NUMERO] [bigint] NOT NULL  DEFAULT (NEXT VALUE FOR [DBO].[MRQS_GRUPO_HDR_S]) ,
	[NUMERO_EXAMEN] [bigint] NOT NULL,
	[TITULO] VARCHAR(200) NOT NULL,
	[TEMA] VARCHAR(30) NOT NULL,
	COMENTARIOS  VARCHAR(500),
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT MRQS_GRUPO_HDR_PK PRIMARY KEY(NUMERO),
	CONSTRAINT MRQS_GRUPO_HDR_FK1 FOREIGN KEY(NUMERO_EXAMEN) REFERENCES dbo.[MRQS_EXAMENES](NUMERO)
)