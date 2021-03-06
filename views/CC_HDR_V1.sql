USE [CMRISE]
GO

CREATE OR ALTER VIEW CC_HDR_V1 AS
SELECT CH.[NUMERO]
      ,CH.[NOMBRE]
      ,CH.[TEMA]
	  ,TUV1.[SIGNIFICADO] TEMA_DESC
      ,CH.[HISTORIAL_CLINICO]
      ,CH.[DESCRIPCION_TECNICA]
      ,CH.[OPCION_INSEGURA]
      ,CH.[ETIQUETAS]
      ,CH.[NOTA]
      ,CH.[ESTATUS]
	  ,TUV2.SIGNIFICADO ESTATUS_DESC
      ,CH.[SOCIEDAD]
      ,CH.[FECHA_EFECTIVA_DESDE]
      ,CH.[FECHA_EFECTIVA_HASTA]
      ,CH.[CREADO_POR]
      ,CH.[FECHA_CREACION]
      ,CH.[ACTUALIZADO_POR]
      ,CH.[FECHA_ACTUALIZACION]
  FROM [dbo].[CC_HDR] CH
      ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV1
	  ,[dbo].[TABLAS_UTILITARIAS_VALORES] TUV2
 WHERE TUV1.TIPO_TABLA='TEMA_DE_PREGUNTA'
   AND TUV1.CODIGO_TABLA = CH.TEMA
   AND TUV2.TIPO_TABLA='ESTATUS_MRQ'
   AND TUV2.CODIGO_TABLA = CH.ESTATUS
GO


