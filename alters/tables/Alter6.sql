USE [CMRISE]
GO

/**

ALTER TABLE [dbo].[ADMON_USUARIOS] ADD CONSTRAINT  ADMON_USUARIOS_U1 UNIQUE(CONTRASENIA)

ALTER TABLE [dbo].[ADMON_USUARIOS] ADD CONSTRAINT  ADMON_USUARIOS_U2 UNIQUE(CURP)

SELECT [NUMERO]
      ,[CONTRASENIA]
      ,[CURP]
  FROM [dbo].[ADMON_USUARIOS]
GO

UPDATE [dbo].[ADMON_USUARIOS]
   SET CONTRASENIA = CONTRASENIA+CAST(1 AS VARCHAR)
 WHERE NUMERO = 2

 **/



