      ******************************************************************
      * DCLGEN TABLE(HR_DB.PACTIVITY)                                *
      *        LIBRARY(HR_DB.TEST.SOURCE(PACTIVITY))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.PACTIVITY TABLE
           ( PROJ_NO CHAR(6) NOT NULL, 
             ACT_NO SMALLINT NOT NULL, 
             ACT_STAFF DECIMAL(5,2), 
             ACT_STARTDATE DATE NOT NULL, 
             ACT_ENDDATE DATE 
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.PACTIVITY                   *
      ******************************************************************
       01  DCLPACTVT.
           10 PROJ-NO               PIC X(6).
           10 ACT-NO                PIC S9(4) USAGE COMP.
           10 ACT-STAFF             PIC S9(3)V9(2) USAGE COMP-3.
           10 ACT-STARTDATE         PIC X(10).
           10 ACT-ENDDATE           PIC X(10).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
