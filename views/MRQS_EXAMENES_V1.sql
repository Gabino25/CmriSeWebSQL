USE [CMRISE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[MRQS_EXAMENES_V1] AS
SELECT ME.[NUMERO]
      ,ME.[TITULO]
      ,ME.[NOMBRE]
      ,ME.[DESCRIPCION]
      ,ME.[COMENTARIOS]
      ,ME.[TIEMPO_LIMITE]
      ,ME.[SALTAR_PREGUNTAS]
      ,ME.[SALTAR_CASOS]
      ,ME.[MOSTRAR_RESPUESTAS]
      ,ME.[TIENE_PASSMARK]
      ,ME.[ALEATORIO_GRUPO]
      ,ME.[ALEATORIO_PREGUNTAS]
      ,ME.[SELECCION_CASOS_ALEATORIOS]
      ,ME.[MENSAJE_FINALIZACION]
      ,ME.[CONFIRMACION_ASISTENCIA]
      ,ME.[DIPLOMA]
      ,ME.[TIPO_PREGUNTA]
	  ,TUV5.SIGNIFICADO TIPO_PREGUNTA_DESC
      ,ME.[TIPO_EXAMEN]
	  ,TUV1.SIGNIFICADO TIPO_EXAMEN_DESC
      ,ME.[VISIBILIDAD]
	  ,TUV2.SIGNIFICADO VISIBILIDAD_DESC 
      ,ME.[ESTATUS]
	  ,TUV3.SIGNIFICADO ESTATUS_DESC
      ,ME.[TEMA]
	  ,TUV4.SIGNIFICADO TEMA_DESC
      ,ME.[SOCIEDAD]
      ,ME.[FECHA_EFECTIVA_DESDE]
      ,ME.[FECHA_EFECTIVA_HASTA]
      ,ME.[CREADO_POR]
      ,ME.[FECHA_CREACION]
      ,ME.[ACTUALIZADO_POR]
      ,ME.[FECHA_ACTUALIZACION]
  FROM [dbo].[MRQS_EXAMENES] ME
      ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV1
	  ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV2
	  ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV3
	  ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV4
	  ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV5
 WHERE TUV1.TIPO_TABLA='TIPO_EXAMEN'
   AND TUV2.TIPO_TABLA='VISIBILIDAD_EXAMEN'
   AND TUV3.TIPO_TABLA='ESTATUS_EXAMEN'
   AND TUV4.TIPO_TABLA='TEMA_DE_EXAMEN'
   AND TUV5.TIPO_TABLA='TIPO_PREGUNTA'
   AND TUV1.CODIGO_TABLA = ME.[TIPO_EXAMEN]
   AND TUV2.CODIGO_TABLA = ME.[VISIBILIDAD]
   AND TUV3.CODIGO_TABLA = ME.[ESTATUS]
   AND TUV4.CODIGO_TABLA = ME.[TEMA]
   AND TUV5.CODIGO_TABLA = ME.[TIPO_PREGUNTA]
GO


