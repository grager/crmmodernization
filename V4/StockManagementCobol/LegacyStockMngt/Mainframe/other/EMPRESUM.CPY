      ******************************************************************
      * DCLGEN TABLE(HR_DB.EMP_RESUME)                                *
      *        LIBRARY(HR_DB.TEST.SOURCE(EMP_RESUME))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.EMP_RESUME TABLE
           ( EMPNO         CHAR(6) NOT NULL, 
             RESUME_FORMAT VARCHAR2(10) NOT NULL, 
             RESUME        CLOB
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.EMP_RESUME                   *
      ******************************************************************
       01  DCLRESUME.
           10 EMPNO                PIC X(6).
           10 RESUME-FORMAT        PIC X(10).
           10 RESUME               USAGE IS SQL TYPE IS CLOB.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
