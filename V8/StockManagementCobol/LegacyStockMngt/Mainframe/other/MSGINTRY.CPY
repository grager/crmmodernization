      ******************************************************************
      * DCLGEN TABLE(HR_DB.MSG_IN_TRAY)                              *
      *        LIBRARY(HR_DB.TEST.SOURCE(MSG_IN_TRAY))               *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.MSG_IN_TRAY TABLE
           ( EMPNO        CHAR(6)  NOT NULL,
             RECEIVED     TIMESTAMP, 
             SOURCE       CHAR(8),
             SUBJECT      CHAR(64),
             NOTE_TEXT    VARCHAR2(3000)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.MSG_IN_TRAY                *
      ******************************************************************
       01  DCLMSGINTRAY.
           10 EMPNO                PIC X(6).
           10 RECEIVED             PIC X(26).
           10 SOURCE               PIC X(8).
           10 SUBJECT              PIC X(64).
           10 NOTE-TEXT            PIC X(3000).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
