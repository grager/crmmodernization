      ******************************************************************
      * DCLGEN TABLE(HR_DB.EMP_PHOTO)                                *
      *        LIBRARY(HR_DB.TEST.SOURCE(EMP_PHOTO))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HR_DB.EMP_PHOTO TABLE
           ( EMPNO        CHAR(6) NOT NULL, 
             PHOTO_FORMAT VARCHAR2(10) NOT NULL, 
             PICTURE      BLOB
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HR_DB.EMP_PHOTO                   *
      ******************************************************************
       01  DCLPHOTO.
           10 EMPNO                PIC X(6).
           10 PHOTO-FORMAT         PIC X(10).
           10 PICTURE              USAGE IS SQL TYPE IS BLOB.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
