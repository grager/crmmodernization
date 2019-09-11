      ******************************************************************
      * DCLGEN TABLE(HR_DB.PAYROLL)                                    *
      *        LIBRARY(HR_DB.TEST.SOURCE(PAYROLL))                     *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE PAYROLL TABLE
           ( EMPNO         CHAR(6)         NOT NULL,
             PYEARMONTH    CHAR(6)         NOT NULL,
             SALARYPAID    DECIMAL(9,2)            ,
             BONUSPAID     DECIMAL(9,2)            ,
             COMMPAID      DECIMAL(9,2)            ,
             LOP           SMALLINT                
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE PAYROLL                            *
      ******************************************************************
       01  DCLPAYROLL.
           10 EMP-NO               PIC X(6).
           10 PYEARMONTH           PIC X(6).
           10 SALARYPAID           PIC S9(7)V9(2) USAGE COMP-3.
           10 BONUSPAID            PIC S9(7)V9(2) USAGE COMP-3. 
           10 COMMPAID             PIC S9(7)V9(2) USAGE COMP-3.            
           10 LOP                  PIC S9(4) USAGE COMP.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
