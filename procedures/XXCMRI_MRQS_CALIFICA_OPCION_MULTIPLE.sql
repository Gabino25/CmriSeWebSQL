USE [CMRISE]
GO
CREATE OR ALTER PROCEDURE XXCMRI_MRQS_CALIFICA_OPCION_MULTIPLE ( @P_NUMERO_CAND_EXAMEN BIGINT
															    ,@P_NUMERO_GRUPO BIGINT
															    ,@P_NUMERO_PREGUNTA_HDR BIGINT
															    ,@P_NUMERO_PREGUNTA_FTA BIGINT 
															    ,@P_RESPUESTA VARCHAR(2000)
															    ) AS
BEGIN 
DECLARE @L_VALOR_PUNTUACION FLOAT
       ,@L_SINGLE_ANSWER_MODE BIT
	   ,@L_METODO_PUNTUACION VARCHAR(30)
	   ,@L_TOTAL_CORRECT_ANSWERS INT
	   ,@L_COUNT_CORRECT INT
	   ,@L_COUNT_INCORRECT INT
	   ,@L_1_FLAG BIT 
	   ,@L_2_FLAG BIT 
PRINT 'Comienza XXCMRI_MRQS_CALIFICA_OPCION_MULTIPLE'

     SELECT @L_VALOR_PUNTUACION = CAST(VALOR_PUNTUACION  AS FLOAT)
	       ,@L_SINGLE_ANSWER_MODE = SINGLE_ANSWER_MODE
		   ,@L_METODO_PUNTUACION = METODO_PUNTUACION
      FROM [dbo].[MRQS_PREGUNTAS_FTA]
	WHERE NUMERO = @P_NUMERO_PREGUNTA_FTA; 

	PRINT '@L_VALOR_PUNTUACION:'+CAST(@L_VALOR_PUNTUACION AS VARCHAR)
	PRINT '@L_SINGLE_ANSWER_MODE:'+CAST(@L_SINGLE_ANSWER_MODE AS VARCHAR)
	PRINT '@L_METODO_PUNTUACION:'+CAST(@L_METODO_PUNTUACION AS VARCHAR)

IF @L_SINGLE_ANSWER_MODE = 1 
BEGIN 
 PRINT '*** MODO UNICO DE RESPUESTA ***'
  SELECT @L_1_FLAG = 1 
    FROM MRQS_OPCION_MULTIPLE
   WHERE NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA 
     AND ESTATUS = 1
     AND NUMERO = @P_RESPUESTA; 

  IF @L_1_FLAG = 1 
  BEGIN
     UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = @L_VALOR_PUNTUACION
		   ,ESTATUS = 'CORRECTA'
		   ,NUM_OPC_CORRECTAS = 1
		   ,NUM_OPC_INCORRECTAS = 0
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA 
  END
  ELSE 
  BEGIN 
     UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = 0
		   ,ESTATUS = 'INCORRECTA'
		   ,NUM_OPC_CORRECTAS = 0
		   ,NUM_OPC_INCORRECTAS = 1
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA 
  END  

END; 
ELSE IF @L_SINGLE_ANSWER_MODE = 0 /** IF @L_SINGLE_ANSWER_MODE = 1 **/
BEGIN
 PRINT '*** MODO MULTIPLE DE RESPUESTA ***'
 PRINT @P_RESPUESTA;

 SELECT @L_COUNT_CORRECT = COUNT(1) 
   FROM MRQS_OPCION_MULTIPLE MOM
       JOIN STRING_SPLIT(@P_RESPUESTA,',') SP ON SP.value =MOM.NUMERO
   WHERE MOM.NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA 
     AND MOM.ESTATUS = 1

  SELECT @L_COUNT_INCORRECT = COUNT(1) 
   FROM MRQS_OPCION_MULTIPLE MOM
       JOIN STRING_SPLIT(@P_RESPUESTA,',') SP ON SP.value =MOM.NUMERO
   WHERE MOM.NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA 
     AND MOM.ESTATUS = 0
   
   PRINT '@L_COUNT_CORRECT:'+CAST(@L_COUNT_CORRECT AS VARCHAR);
   PRINT '@L_COUNT_INCORRECT:'+CAST(@L_COUNT_INCORRECT AS VARCHAR);
   
   IF @L_COUNT_INCORRECT > 0
   BEGIN 
      UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = 0
		   ,ESTATUS = 'INCORRECTA'
		   ,NUM_OPC_CORRECTAS = @L_COUNT_CORRECT
		   ,NUM_OPC_INCORRECTAS = @L_COUNT_INCORRECT
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA
   END
   ELSE /** IF @L_COUNT_INCORRECT > 0 **/
   BEGIN 
    IF 'PROP_SCORING' = @L_METODO_PUNTUACION
	BEGIN 
	   SELECT @L_TOTAL_CORRECT_ANSWERS = COUNT(1) 
		FROM MRQS_OPCION_MULTIPLE
	   WHERE NUMERO_FTA = @P_NUMERO_PREGUNTA_FTA 
		 AND ESTATUS = 1
        PRINT @L_COUNT_CORRECT
		PRINT @L_TOTAL_CORRECT_ANSWERS
		PRINT @L_VALOR_PUNTUACION
       SET @L_VALOR_PUNTUACION = (CAST(@L_COUNT_CORRECT AS FLOAT))/(CAST(@L_TOTAL_CORRECT_ANSWERS AS FLOAT))*@L_VALOR_PUNTUACION
	   PRINT @L_VALOR_PUNTUACION
	   SET @L_VALOR_PUNTUACION = ROUND(@L_VALOR_PUNTUACION,2)
	    PRINT @L_VALOR_PUNTUACION

	     UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = @L_VALOR_PUNTUACION
		   ,ESTATUS = 'CORRECTA'
		   ,NUM_OPC_CORRECTAS = @L_COUNT_CORRECT
		   ,NUM_OPC_INCORRECTAS = @L_COUNT_INCORRECT
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA

	END
	ELSE /** IF 'PROP_SCORING' = @L_METODO_PUNTUACION **/
	BEGIN 
	    UPDATE [dbo].CAND_EXAM_RESPUESTAS
	    SET PUNTUACION = @L_VALOR_PUNTUACION
		   ,ESTATUS = 'CORRECTA'
		   ,NUM_OPC_CORRECTAS = @L_COUNT_CORRECT
		   ,NUM_OPC_INCORRECTAS = @L_COUNT_INCORRECT
	  WHERE NUMERO_CAND_EXAMEN=  @P_NUMERO_CAND_EXAMEN
		AND NUMERO_GRUPO = @P_NUMERO_GRUPO
		AND NUMERO_PREGUNTA_HDR = @P_NUMERO_PREGUNTA_HDR
		AND NUMERO_PREGUNTA_FTA = @P_NUMERO_PREGUNTA_FTA
	END
   END; 

END; 


PRINT 'Finaliza XXCMRI_MRQS_CALIFICA_OPCION_MULTIPLE'
END 