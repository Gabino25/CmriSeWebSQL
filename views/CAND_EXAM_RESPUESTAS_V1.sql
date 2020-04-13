USE [CMRISE]
GO

CREATE OR ALTER VIEW CAND_EXAM_RESPUESTAS_V1 AS
SELECT CER.[NUMERO]
      ,CER.[NUMERO_CAND_EXAMEN]
      ,CER.[NUMERO_GRUPO]
      ,CER.[NUMERO_PREGUNTA_HDR]
      ,CER.[NUMERO_PREGUNTA_FTA]
      ,CER.[RESPUESTA]
      ,CER.[PUNTUACION]
      ,CER.[ESTATUS]
      ,CER.[NUM_OPC_CORRECTAS]
      ,CER.[NUM_OPC_INCORRECTAS]
      ,CER.[CREADO_POR]
      ,CER.[FECHA_CREACION]
      ,CER.[ACTUALIZADO_POR]
      ,CER.[FECHA_ACTUALIZACION]
	  ,CE.NUMERO_EXAMEN 
	  ,CE.NUMERO_USUARIO
	  ,CE.TIPO
	  ,MPHV.TITULO
	  ,MPHV.TIPO_PREGUNTA
	  ,MPHV.TIPO_PREGUNTA_DESC
  FROM [dbo].[CAND_EXAM_RESPUESTAS] CER
      ,[dbo].[CAND_EXAMENES] CE
	  ,[dbo].[MRQS_PREGUNTAS_HDR_V1] MPHV
 WHERE CE.NUMERO = CER.NUMERO_CAND_EXAMEN
   AND MPHV.NUMERO = CER.NUMERO_PREGUNTA_HDR

