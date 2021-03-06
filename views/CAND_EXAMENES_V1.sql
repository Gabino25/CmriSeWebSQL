USE [CMRISE]
GO

CREATE OR ALTER VIEW CAND_EXAMENES_V1 AS
SELECT CE.[NUMERO]
      ,CE.[NUMERO_USUARIO]
      ,CE.[NUMERO_EXAMEN]
      ,CE.[TIPO]
      ,CE.[ESTATUS]
      ,CE.[CREADO_POR]
      ,CE.[FECHA_CREACION]
      ,CE.[ACTUALIZADO_POR]
      ,CE.[FECHA_ACTUALIZACION]
	  ,AURV1.MATRICULA
	  ,AURV1.NOMBRE_USUARIO
	  ,AURV1.APELLIDO_PATERNO
	  ,AURV1.APELLIDO_MATERNO
	  ,AURV1.NOMBRE_COMPLETO_USUARIO
	  ,AURV1.NOMBRE_ROL
	  ,AURV1.DESCRIPCION_ROL
  FROM [dbo].[CAND_EXAMENES] CE
      ,[dbo].[ADMON_USUARIOS_ROLES_V1] AURV1
 WHERE CE.NUMERO_USUARIO = AURV1.NUMERO_USUARIO


