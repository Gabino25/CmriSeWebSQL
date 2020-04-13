USE [CMRISE]
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Gabino Hernandez Canales
-- Create date: 03 Abril 2020
-- Description:	Procedimiento Almacenado que Calificara Preguntas
-- =============================================
CREATE OR ALTER PROCEDURE XXCMRI_CALIFICA_PREGUNTA 
	 @P_NUMERO_CAND_EXAMEN BIGINT
	,@P_NUMERO_GRUPO BIGINT
	,@P_NUMERO_PREGUNTA_HDR BIGINT
	,@P_NUMERO_PREGUNTA_FTA BIGINT 
AS
DECLARE @L_NUMERO_CAND_EXAM_RESPUESTA AS BIGINT
       ,@L_NUMERO_CAND_EXAMEN AS BIGINT
	   ,@L_TIPO_EXAMEN  VARCHAR(30)
	   ,@L_RESPUESTA VARCHAR(2000)
	   ,@L_TIPO_PREGUNTA VARCHAR(30)
	    ;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  @L_NUMERO_CAND_EXAM_RESPUESTA = NUMERO
	       ,@L_NUMERO_CAND_EXAMEN = NUMERO_CAND_EXAMEN
		   ,@L_RESPUESTA = RESPUESTA
       FROM [dbo].CAND_EXAM_RESPUESTAS
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA

    PRINT @L_NUMERO_CAND_EXAM_RESPUESTA
	PRINT @L_NUMERO_CAND_EXAMEN

	SELECT @L_TIPO_EXAMEN = TIPO
	  FROM CAND_EXAMENES 
	 WHERE NUMERO = @L_NUMERO_CAND_EXAMEN

      PRINT @L_TIPO_EXAMEN
	 IF 'MRQS' = @L_TIPO_EXAMEN  
	 BEGIN 
	   PRINT 'Comienza MRQS'
	   SELECT @L_TIPO_PREGUNTA = TIPO_PREGUNTA 
	     FROM [dbo].[MRQS_PREGUNTAS_HDR]
		WHERE NUMERO = @P_NUMERO_PREGUNTA_HDR
		PRINT @L_TIPO_PREGUNTA
		IF 'RESP_TEXTO_LIBRE' = @L_TIPO_PREGUNTA
		BEGIN 
		PRINT 'Comienza MRQS RESP_TEXTO_LIBRE'
		  EXECUTE  [dbo].[XXCMRI_MRQS_CALIFICA_TEXTO_LIBRE]    @P_NUMERO_CAND_EXAMEN
															  ,@P_NUMERO_GRUPO
															  ,@P_NUMERO_PREGUNTA_HDR
															  ,@P_NUMERO_PREGUNTA_FTA
															  ,@L_RESPUESTA

		END
		ELSE IF 'OPCION_MULTIPLE' = @L_TIPO_PREGUNTA
		BEGIN 
		 EXECUTE  [dbo].[XXCMRI_MRQS_CALIFICA_OPCION_MULTIPLE]    @P_NUMERO_CAND_EXAMEN
															     ,@P_NUMERO_GRUPO
															     ,@P_NUMERO_PREGUNTA_HDR
															     ,@P_NUMERO_PREGUNTA_FTA
															     ,@L_RESPUESTA
		END;
	 END
	 IF 'CORE_CASES' = @L_TIPO_EXAMEN  
	 BEGIN 
	   PRINT 'Comienza Casos Clinicos'
	 END

END
GO
