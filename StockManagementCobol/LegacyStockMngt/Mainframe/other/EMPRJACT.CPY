
      ******************************************************************
      * DCLGEN TABLE(HR_DB.EMP_PROJ_ACT)                             *
      *        LIBRARY(HR_DB.TEST.SOURCE(EMP_PROJ_ACT))              *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.EMP_PROJ_ACT TABLE
           ( EMPNO        CHAR(6)  NOT NULL,
             PROJ_NO      CHAR(6)  NOT NULL, 
             ACT_NO       SMALLINT NOT NULL,
             EMPTIME      DECIMAL(5,2), 
             ESTARTDATE   DATE,
             EENDDATE     DATE
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.EMP_PROJ_ACT               *
      ******************************************************************
       01  DCLEMPPR0JACT.
           10 EMPNO                PIC X(6).
           10 PROJ-NO              PIC X(6).
           10 ACT-NO               PIC S9(4) USAGE COMP.           
           10 EMPTIME              PIC S9(3)V(2) COMP-3.
           10 ESTARTDATE           PIC X(10).  
           10 EENDDATE             PIC X(10). 
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 6       *
      ******************************************************************
