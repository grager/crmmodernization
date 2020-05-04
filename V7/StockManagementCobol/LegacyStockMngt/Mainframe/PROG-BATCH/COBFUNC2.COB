      *-----------------------------------------------------------------
      *    COBFUNC2 - SAMPLE COBOL PROGRAM TO DEMONSTRATE MERGE 
      *               FUNCTIONALITY   
      * 
      *               READS EMPLOYEE DATA FROM FOR TWO DEPARTEMNTS AND 
      *               MERGE THEM INTO OUTPUT FILE. ALSO COUNTS NUMBER 
      *               OF EMPLOYEES HAVING BONUS MORE THAN $10,000
      *                                                                 
      *-----------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBFUNC2.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT DEPTDATA1 ASSIGN TO SEQM1.
          SELECT DEPTDATA1 ASSIGN TO SEQM2.
          SELECT OUTFILE ASSIGN TO MERGED.
          SELECT MERGE-FILE ASSIGN TO SORT01.

       DATA DIVISION.
       FILE SECTION.
       FD DEPTDATA1
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 120 CHARACTERS.
       01 DEPTDATA1-REC.
          05 DEPTDATA1-EMPNO		PIC X(06).
          05 DEPTDATA1-NAME		PIC X(34).
          05 DEPTDATA1-WORKDEPT		PIC X(03).
          05 DEPTDATA1-OTHDETAILS	PIC X(36).
          05 DEPTDATA1-SALARY 		PIC S9(7)V9(2) USAGE COMP-3.
          05 DEPTDATA1-BONUS		PIC S9(7)V9(2) USAGE COMP-3.
          05 DEPTDATA1-RESTOFREC	PIC X(31).
       FD DEPTDATA2
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 120 CHARACTERS.
       01 DEPTDATA2-REC.
          05 DEPTDATA2-EMPNO		PIC X(06).
          05 DEPTDATA2-NAME		PIC X(34).
          05 DEPTDATA2-WORKDEPT		PIC X(03).
          05 DEPTDATA2-OTHDETAILS	PIC X(36).
          05 DEPTDATA2-SALARY 		PIC S9(7)V9(2) USAGE COMP-3.
          05 DEPTDATA2-BONUS		PIC S9(7)V9(2) USAGE COMP-3.
          05 DEPTDATA2-RESTOFREC	PIC X(31).
       FD OUTFILE
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 120 CHARACTERS. 
       01 OUTREC 			PIC X(120).
       SD MERGE-FILE.
       01 MERGE-REC.			PIC X(120).
          05 MERGE-EMPNO		PIC X(06).
          05 MERGE-NAME			PIC X(34).
          05 MERGE-FIRSTIGREC           PIC X(44).
          05 MERGE-BONUS                PIC S9(7)V9(2) USAGE COMP-3.
          05 MERGE-RESTOFREC		PIC X(31).

      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION.                                             
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 MORE-RECS 			PIC X(03) VALUE 'YES'.
       01 OVER-10000-CTR		PIC 9(05) VALUE ZERO.
                      
      *-----------------------------------------------------------------
      * PROCEDURE DIVISION.                                                  
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      * THE MAIN MODULE MERGES THE EMPLOYEE DATA AS RECEIVED FROM          
      * TWO DIFFERENT EMPLOYEE RECORD FILES.
      *-----------------------------------------------------------------
       100-MAIN-MODULE.
           MERGE MERGE-FILE
               ON ASCENDING KEY MERGE-EMPNO
               USING DEPTDATA1
                     DEPTDATA2
               OUTPUT PROCEDURE 200-COUNT-MODULE
           DISPLAY 'NO. OF EMPLOYEES WITH BONUS > $10,000 = '
                   OVER-10000-CTR
           STOP RUN.      

      *-----------------------------------------------------------------
      * THIS PARA PERFORMS THE LOGIC PARA UNTIL END OF FILE                
      *-----------------------------------------------------------------
       200-COUNT-MODULE.
          OPEN OUTPUT OUTFILE
          PERFORM UNTIL MORE-RECS = 'NO'
              RETURN MERGE-FILE
                 AT END
                    MOVE 'NO' TO MORE-RECS
                 NOT AT END 
                    PERFORM 300-LOGIC-MODULE
          END-PERFORM
          CLOSE OUTFILE.

      *-----------------------------------------------------------------
      * THE LOGIC MODULE CHECKS FOR THE BUSINESS LOGIC TO MERGE EMPLOYEE   
      * RECORDS.                            
      *-----------------------------------------------------------------
       300-LOGIC-MODULE.
          IF MERGE-BONUS > 10000
             ADD 1 TO OVER-10000-CTR
          END-IF
          WRITE OUTREC FROM MERGE-REC.
          
             
       