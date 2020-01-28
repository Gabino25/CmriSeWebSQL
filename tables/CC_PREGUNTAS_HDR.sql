USE [CMRISE]
GO

CREATE TABLE [dbo].[CC_PREGUNTAS_HDR](
	[NUMERO] [bigint] NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[CC_PREGUNTAS_HDR_S]),
	[NUMERO_CC_HDR] [bigint] NOT NULL,
	[FECHA_EFECTIVA_DESDE] [date] NOT NULL,
	[FECHA_EFECTIVA_HASTA] [date] NOT NULL,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL, 
	CONSTRAINT 	CC_PREGUNTAS_HDR_PK1 PRIMARY KEY(NUMERO),
	CONSTRAINT 	CC_PREGUNTAS_HDR_FK1 FOREIGN KEY(NUMERO_CC_HDR) REFERENCES [dbo].[CC_HDR](NUMERO)
)