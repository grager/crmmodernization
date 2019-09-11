      ******************************************************************
      * DCLGEN TABLE(HR_DB.SUBSIDIARY)                                 *
      *        LIBRARY(HR_DB.TEST.SOURCE(SUBSIDIARY))                  *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.SUBSIDIARY TABLE
           ( SUBID        CHAR(4)  NOT NULL, 
             SUBNAME 	  CHAR(10) NOT NULL, 
             SUBPASSWORD  CHAR(16) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.SUBSIDIARY                   *
      ******************************************************************
       01  DCLSUBSIDIARY.
           10 SUBID                PIC X(4).
           10 SUBNAME              PIC X(10).
           10 SUBPASSWORD          PIC X(16).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
