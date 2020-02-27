USE [CMRISE]
GO

CREATE OR ALTER VIEW ADMON_CC_CANDIDATOS_V1 AS
SELECT ACC.[NUMERO]
      ,ACC.[NUMERO_USUARIO]
      ,ACC.[NUMERO_CC_EXAMEN]
      ,ACC.[INFORMACION_EXTRA]
      ,ACC.[FECHA_EFECTIVA_DESDE]
      ,ACC.[FECHA_EFECTIVA_HASTA]
      ,ACC.[CREADO_POR]
      ,ACC.[FECHA_CREACION]
      ,ACC.[ACTUALIZADO_POR]
      ,ACC.[FECHA_ACTUALIZACION]
	  ,(AU.NOMBRE+' '+AU.APELLIDO_PATERNO+' '+AU.APELLIDO_MATERNO) NOMBRE_COMPLETO_USUARIO
	  ,AU.CONTRASENIA
	  ,AU.CORREO_ELECTRONICO
  FROM [dbo].[ADMON_CC_CANDIDATOS] ACC
      ,[dbo].[ADMON_USUARIOS] AU
 WHERE ACC.NUMERO_USUARIO = AU.NUMERO


