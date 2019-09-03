      ******************************************************************
      * DCLGEN TABLE(HR_DB.ACTIVITY)                                 *
      *        LIBRARY(HR_DB.TEST.SOURCE(ACTIVITY))                  *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.ACTIVITY TABLE
           ( ACT_NO      SMALLINT NOT NULL, 
             ACT_KEYWORD CHAR(6) NOT NULL, 
             ACT_DESC    VARCHAR(20) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.ACTIVITY                   *
      ******************************************************************
       01  DCLACTVT.
           10 ACT-NO               PIC S9(4) USAGE COMP.
           10 ACT-KEYWORD          PIC X(6).
           10 ACT-DESC.
              49 ACTVTNAME-LEN      PIC S9(4) USAGE COMP.
              49 ACTVTNAME-TEXT     PIC X(20).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
