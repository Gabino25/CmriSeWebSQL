USE [CMRISE]
GO
CREATE OR ALTER PROCEDURE XXCMRI_MRQS_CALIFICA_TEXTO_LIBRE ( @P_NUMERO_CAND_EXAMEN BIGINT
															,@P_NUMERO_GRUPO BIGINT
															,@P_NUMERO_PREGUNTA_HDR BIGINT
															,@P_NUMERO_PREGUNTA_FTA BIGINT 
															,@P_RESPUESTA VARCHAR(2000)
															) AS
BEGIN 
PRINT 'Comienza XXCMRI_MRQS_CALIFICA_TEXTO_LIBRE'
PRINT '@P_RESPUESTA:'+@P_RESPUESTA
DECLARE @retval VARCHAR(2000)
       ,@L_RESPUESTA_CORRECTA VARCHAR(500)
	   ,@L_VALOR_PUNTUACION  FLOAT
	   ,@L_ESTATUS   VARCHAR(200)
	   ,@L_PALABRA   VARCHAR(500)
	   ,@L_SINONIMOS VARCHAR(2000) 
	   ,@L_1_FLAG BIT 
	   ,@L_2_FLAG BIT 
	   ,@L_3_FLAG BIT 
	   ;
SET @L_1_FLAG = 0; 
SET @L_2_FLAG = 0; 
SET @L_3_FLAG = 0; 

DECLARE INCLUDED_WORDS_CURSOR CURSOR FOR 
SELECT [PALABRA]
      ,[SINONIMOS]
  FROM [dbo].[MRQS_LISTAS_PALABRAS]
 WHERE TIPO_REGISTRO = 'INCLUDED_WORDS'
   AND NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA;

DECLARE CAN_WORDS_CURSOR CURSOR FOR 
SELECT [PALABRA]
      ,[SINONIMOS]
  FROM [dbo].[MRQS_LISTAS_PALABRAS]
 WHERE TIPO_REGISTRO = 'CAN_WORDS'
   AND NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA; 

DECLARE EXCLUDED_WORDS_CURSOR CURSOR FOR 
SELECT [PALABRA]
      ,[SINONIMOS]
  FROM [dbo].[MRQS_LISTAS_PALABRAS]
 WHERE TIPO_REGISTRO = 'EXCLUDED_WORDS'
   AND NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA; 


    SELECT @L_RESPUESTA_CORRECTA = RESPUESTA_CORRECTA
	      ,@L_VALOR_PUNTUACION = CAST(VALOR_PUNTUACION  AS FLOAT)
      FROM [dbo].[MRQS_PREGUNTAS_FTA]
	WHERE NUMERO = @P_NUMERO_PREGUNTA_FTA; 

	PRINT @L_RESPUESTA_CORRECTA
	PRINT @L_VALOR_PUNTUACION
	PRINT @P_NUMERO_PREGUNTA_FTA

	 SELECT @L_1_FLAG = 1
	   FROM [dbo].[MRQS_PREGUNTAS_FTA]
  	  WHERE NUMERO = @P_NUMERO_PREGUNTA_FTA
	    AND LOWER(RESPUESTA_CORRECTA) LIKE '%'+LOWER(@P_RESPUESTA)+'%'
	
	 IF @L_1_FLAG = 0 
	 BEGIN 
	   OPEN INCLUDED_WORDS_CURSOR  
		FETCH NEXT FROM INCLUDED_WORDS_CURSOR   
		INTO @L_PALABRA, @L_SINONIMOS    
		WHILE (@@FETCH_STATUS = 0) AND  (@L_1_FLAG = 0)
		BEGIN 
		 
		 PRINT '*Comienza INCLUDED_WORDS_CURSOR*'

		   SELECT @L_2_FLAG = 1
		   FROM [dbo].CAND_EXAM_RESPUESTAS
		  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
			AND NUMERO_GRUPO = @P_NUMERO_GRUPO
			AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
			AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA
			AND REPLACE(@L_RESPUESTA_CORRECTA,@L_PALABRA,@L_SINONIMOS) LIKE '%'+@L_SINONIMOS+'%'
		   PRINT '*Finaliza INCLUDED_WORDS_CURSOR*'

		
		   -- Get the next INCLUDED_WORDS_CURSOR.  
			FETCH NEXT FROM INCLUDED_WORDS_CURSOR   
			INTO @L_PALABRA, @L_SINONIMOS   
	    END   
        CLOSE INCLUDED_WORDS_CURSOR;  
        DEALLOCATE INCLUDED_WORDS_CURSOR; 
	 END 


	 IF @L_1_FLAG = 0
	   AND @L_2_FLAG = 0
	   AND @L_3_FLAG = 0
	 BEGIN 
	   PRINT 'INCORRECTA'
	   UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = 0
		   ,ESTATUS = 'INCORRECTA'
		   ,NUM_OPC_CORRECTAS = 0
		   ,NUM_OPC_INCORRECTAS = 1
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA; 
	 END
	 ELSE 
	 BEGIN 
	    PRINT 'CORRECTA'
	  	 UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = @L_VALOR_PUNTUACION
		   ,ESTATUS = 'CORRECTA'
		   ,NUM_OPC_CORRECTAS = 1
		   ,NUM_OPC_INCORRECTAS = 0
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA; 
	 END

	IF (SELECT CURSOR_STATUS('global','INCLUDED_WORDS_CURSOR')) >= -1
	BEGIN
		DEALLOCATE INCLUDED_WORDS_CURSOR
	END
	
	IF (SELECT CURSOR_STATUS('global','CAN_WORDS_CURSOR')) >= -1
	BEGIN
		DEALLOCATE CAN_WORDS_CURSOR
	END

	IF (SELECT CURSOR_STATUS('global','EXCLUDED_WORDS_CURSOR')) >= -1
	BEGIN
		DEALLOCATE EXCLUDED_WORDS_CURSOR
	END
	
PRINT 'Finaliza XXCMRI_MRQS_CALIFICA_TEXTO_LIBRE'
END