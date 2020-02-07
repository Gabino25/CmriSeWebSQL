CREATE TABLE DCM_PATIENT (ID BIGINT  NOT NULL DEFAULT (NEXT VALUE FOR [DBO].[DCM_PATIENT_S]) 
                         ,PATIENT_AGE VARCHAR(10)
                         ,PATIENT_BIRTHDAY DATE
                         ,PATIENT_ID VARCHAR(100)
                         ,PATIENT_NAME VARCHAR(100)
                         ,PATIENT_SEX VARCHAR(10)
                         ,CREATED_DATE DATETIME
                         ,MODIFIED_DATE DATETIME 
                         ,CONSTRAINT DCM_PATIENT_PK1 PRIMARY KEY(ID)
                         )