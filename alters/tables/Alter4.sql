USE [CMRISE]
GO
--(Paso 1)
--ALTER TABLE dbo.MRQS_OPCION_MULTIPLE ADD NUMERO_LINEA INT;

--(Paso 2)
--UPDATE  dbo.MRQS_OPCION_MULTIPLE
--SET NUMERO_LINEA = 1

--(Paso 3)
ALTER TABLE dbo.MRQS_OPCION_MULTIPLE ALTER COLUMN NUMERO_LINEA INT NOT NULL; 