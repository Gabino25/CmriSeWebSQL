CREATE TABLE DCM_STUDY (ID BIGINT NOT NULL DEFAULT (NEXT VALUE FOR DBO.DCM_STUDY_S)
                       , ACCESSION_NUMBER VARCHAR(30)
                       , ADDITIONAL_PATIENT_HISTORY VARCHAR(300)
                       , ADMITTING_DIAGNOSES_DESCRIPTION VARCHAR(200)
                       , REFERRING_PHYSICIAN_NAME VARCHAR(100)
                       , STUDY_DATE_TIME DATETIME
                       , STUDY_DESCRIPTION VARCHAR(300)
                       , STUDY_ID VARCHAR(50)
                       , STUDY_INSTANCE_UID VARCHAR(100)
                       , STUDY_PRIORITY_ID VARCHAR(40)
                       , STUDY_STATUS_ID VARCHAR(40)
                       , PATIENT_ID BIGINT
					   , CREATED_DATE DATETIME
                       , MODIFIED_DATE DATETIME
                       , CONSTRAINT DCM_STUDY_PK1 PRIMARY KEY(ID)
					   , CONSTRAINT DCM_STUDY_FK1 FOREIGN KEY(PATIENT_ID) REFERENCES [dbo].[DCM_PATIENT]([ID]) 
                       )
