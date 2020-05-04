      ******************************************************************
      * DCLGEN TABLE(HR_DB.DEVELOPER)                                  *
      *        LIBRARY(HR_DB.TEST.SOURCE(DEVELOPER))                     *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE DEVELOPER TABLE
           ( DEVELOPER_ID  CHAR(6)         NOT NULL,
       	     HARDWARE_ID   CHAR(10)                ,
             SKILL_LEVEL   INTEGER                 ,
             SALARY        INTEGER                 ,
             EXPERIENCE    INTEGER                 ,          
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE DEVELOPER                            *
      ******************************************************************
       01  DCLDEVELOPER.
           10 DEVELOPER-ID         PIC X(6).
           10 HARDWARE-ID          PIC X(10).
           10 SKILL-LEVEL          PIC S9(7)V9(2) USAGE COMP-3.
           10 SALARY               PIC S9(7)V9(2) USAGE COMP-3. 
           10 EXPERIENCE           PIC S9(7)V9(2) USAGE COMP-3.            
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
