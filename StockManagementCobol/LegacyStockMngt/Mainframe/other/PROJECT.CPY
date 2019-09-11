      ******************************************************************
      * DCLGEN TABLE(HR_DB.PROJECT)                                  *
      *        LIBRARY(HR_DB.TEST.SOURCE(PROJECT))                   *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE PROJECT TABLE
           ( PROJ_NO         CHAR(6)        NOT NULL,
	     PROJ_NAME       VARCHAR(24)    NOT NULL,
       	     DEPTNO          CHAR(3)        NOT NULL,
             PROJ_EMP        CHAR(6)        NOT NULL,
             PROJ_STAFF      DECIMAL(5,2)           ,
             PROJ_STARTDATE  DATE                   ,
             PROJ_ENDDATE    DATE                   ,
             CTRLPROJ        CHAR(6)                
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE PROJECT                            *
      ******************************************************************
       01  DCLPROJECT.
           10 PROJ-NO              PIC X(6).
           10 PROJ-NAME.
              49 PROJNAME-LEN      PIC S9(4) USAGE COMP.
              49 PROJNAME-TEXT     PIC X(24).
           10 DEPTNO               PIC X(3).
           10 PROJ-EMP             PIC X(6).
           10 PROJ-STAFF           PIC S9(3)V9(2) USAGE COMP-3. 
           10 PROJ-STARTDATE       PIC X(10).
           10 PROJ-ENDDATE         PIC X(10).
           10 CTRLPROJ             PIC X(06).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
