      ******************************************************************
      * DCLGEN TABLE(HR_DB.LEAVE)                                  *
      *        LIBRARY(HR_DB.TEST.SOURCE(LEAVE))                   *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE LEAVE TABLE
           ( EMPNO         CHAR(6)         NOT NULL,
             LYEARMONTH    CHAR(6)         NOT NULL,
             LAVAILABLE    SMALLINT                , 
             LTAKEN        SMALLINT                ,
             LBALANCE      SMALLINT                ,
	     WORKINGDAYS   SMALLINT 
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE LEAVE                            *
      ******************************************************************
       01  DCLLEAVE.
           10 EMP-NO               PIC X(6).
           10 LYEARMONTH           PIC X(6).
           10 LAVAILABLE           PIC S9(4) USAGE COMP.
           10 LTAKEN               PIC S9(4) USAGE COMP. 
           10 LBALANCE             PIC S9(4) USAGE COMP.            
	   10 WORKINGDAYS	   PIC S9(4) USAGE COMP.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
