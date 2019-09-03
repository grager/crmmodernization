      *-----------------------------------------------------------------
      *    COBFUNC3 - SAMPLE COBOL PROGRAM TO DEMONSTRATE TABLE 
      *               AND ARRAY FUNCTIONALITY   
      * 
      *               READS EMPLOYEE DATA FROM VSAM FILE AND COUNTS
      *               THE NUMBER OF EMPLOYEES HIRED IN EACH MONTH AND 
      *               DISPLAYS THE RESULT.  
      *                                                                 
      *-----------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBFUNC3.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT EMPDATA ASSIGN TO VSAMF
             ORGANIZATION IS INDEXED
             ACCESS IS SEQUENTIAL
             RECORD KEY IS EMPDATA-EMPNO.
       
       DATA DIVISION.
       FILE SECTION.
       FD EMPDATA 
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 120 CHARACTERS.
       01 EMPDATA-REC.
          05 EMPDATA-EMPNO		PIC X(06).
          05 EMPDATA-NAME		PIC X(34).
          05 EMPDATA-WORKDEPT		PIC X(03).
          05 EMPDATA-PHONENO		PIC X(04).
          05 EMPDATA-HIREDDATE.
             10 EMPDATA-HIREDDATE-YR    PIC X(04).
             10 FILLER			PIC X(01).
             10 EMPDATA-HIREDDATE-MO	PIC X(02).
             10 FILLER			PIC X(01).
             10 EMPDATA-HIREDDATE-DD	PIC X(02).
          05 EMPDATA-OTHDETAILS		PIC X(63).
          
       WORKING-STORAGE SECTION.
       01 MONTHTABLE.
          02 TABLEVALUES.
             03 FILLER         PIC X(18) VALUE "JANUARY  FEBRUARY".
             03 FILLER         PIC X(18) VALUE "MARCH    APRIL".
             03 FILLER         PIC X(18) VALUE "MAY      JUNE".
             03 FILLER         PIC X(18) VALUE "JULY     AUGUST".
             03 FILLER         PIC X(18) VALUE "SEPTEMBEROCTOBER".
             03 FILLER         PIC X(18) VALUE "NOVEMBER DECEMBER".
          02 FILLERH REDEFINES TABLEVALUES.
             03 MONTH OCCURS 12 TIMES PIC X(9).
       
       01 MONTHCOUNT OCCURS 12 TIMES PIC 999 VALUE ZEROS.
       
       01 MONTHIDX             PIC 999.
       
       01 HEADINGLINE          PIC X(19) VALUE " MONTH    EMPCOUNT".
       
       01 DISPLAYLINE.
          02 PRNMONTH          PIC X(9).
          02 FILLER            PIC X(4) VALUE SPACES.
          02 PRNEMPCOUNT       PIC ZZ9.
        
       
      *-----------------------------------------------------------------
      * PROCEDURE DIVISION.                                                
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      * THIS MODULE OPENS THE EMPLOYEE DATA FILE AND IMPLEMENTS TABLE     
      * AND ARRAY FACILITIES OF COBOL TO DEMONSTARTE THE CAPABILITIES.
      *-----------------------------------------------------------------
       100-MAIN-MODULE.
          OPEN INPUT EMPDATA
          READ EMPDATA
             AT END SET ENDOFEMPFILE TO TRUE
          END-READ
          PERFORM UNTIL ENDOFEMPFILE
             ADD 1 TO MONTHCOUNT(EMPDATA-HIREDDATE-MO)
             READ EMPDATA
                AT END SET ENDOFEMPFILE TO TRUE
             END-READ
          END-PERFORM
       
          DISPLAY HEADINGLINE
          PERFORM VARYING MONTHIDX FROM 1 BY 1 UNTIL MONTHIDX > 12
             MOVE MONTH(MONTHIDX) TO PRNMONTH
             MOVE MONTHCOUNT(MONTHIDX) TO PRNEMPCOUNT
             DISPLAY DISPLAYLINE
          END-PERFORM.
       
          CLOSE EMPDATA
   	  STOP RUN.