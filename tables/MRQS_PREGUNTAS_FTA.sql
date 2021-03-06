USE [CMRISE]
GO

CREATE TABLE [dbo].[MRQS_PREGUNTAS_FTA](
	[NUMERO] [bigint] NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[MRQS_PREGUNTAS_FTA_S]),
	[NUMERO_HDR] [bigint] NOT NULL,
	[TITULO] [varchar](200) NOT NULL,
	[TEXTO_PREGUNTA][varchar](500) NOT NULL,
	[TEXTO_SUGERENCIAS][varchar](500),
	[METODO_PUNTUACION] [varchar](30) NOT NULL,
	[VALOR_PUNTUACION] [varchar](30) NOT NULL,
	[RESPUESTA_CORRECTA][varchar](500) NOT NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT 	MRQS_PREGUNTAS_FTA_PK1 PRIMARY KEY(NUMERO),
	CONSTRAINT 	MRQS_PREGUNTAS_FTA_FK1 FOREIGN KEY(NUMERO_HDR) REFERENCES [dbo].[MRQS_PREGUNTAS_HDR](NUMERO)
) ON [PRIMARY]
GO