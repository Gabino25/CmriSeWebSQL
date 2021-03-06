USE [CMRISE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CAND_EXAM_RESPUESTAS](
	[NUMERO] [bigint] NOT NULL DEFAULT(NEXT VALUE FOR [DBO].[CAND_EXAM_RESPUESTAS_S]),
	[NUMERO_CAND_EXAMEN]  [bigint] NOT NULL, 
	[NUMERO_GRUPO]        [bigint] NOT NULL, 
	[NUMERO_PREGUNTA_HDR] [bigint] NOT NULL, 
	[NUMERO_PREGUNTA_FTA] [bigint] NOT NULL,
	[RESPUESTA] VARCHAR(2000),
	[PUNTUACION] FLOAT NOT NULL,
	[ESTATUS] VARCHAR(30),
	[NUM_OPC_CORRECTAS] INT,
	[NUM_OPC_INCORRECTAS] INT,
	[CREADO_POR] [bigint] NOT NULL,
	[FECHA_CREACION] [datetime] NOT NULL,
	[ACTUALIZADO_POR] [bigint] NOT NULL,
	[FECHA_ACTUALIZACION] [datetime] NOT NULL,
	CONSTRAINT CAND_EXAM_RESPUESTAS_PK1 PRIMARY KEY(NUMERO), 
	CONSTRAINT CAND_EXAM_RESPUESTAS_FK1 FOREIGN KEY(NUMERO_CAND_EXAMEN) REFERENCES [dbo].[CAND_EXAMENES](NUMERO)
)
