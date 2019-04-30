      ******************************************************************
      * DCLGEN TABLE(HR_DB.DEPT)                                    *
      *        LIBRARY(HR_DB.TEST.SOURCE(DEPT))                     *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.DEPT TABLE
           ( DEPTNO                         CHAR(3) NOT NULL,
             DEPTNAME                       VARCHAR(36) NOT NULL,
             MGRNO                          CHAR(6),
             ADMRDEPT                       CHAR(3) NOT NULL,
             LOCATION                       CHAR(16)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE COBDEMO.DEPT                       *
      ******************************************************************
       01  DCLDEPT.
           10 DEPTNO               PIC X(3).
           10 DEPTNAME.
              49 DEPTNAME-LEN      PIC S9(4) USAGE COMP.
              49 DEPTNAME-TEXT     PIC X(36).
           10 MGRNO                PIC X(6).
           10 ADMRDEPT             PIC X(3).
           10 LOCATION             PIC X(16).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
