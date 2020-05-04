      *-----------------------------------------------------------------
      *    COBDYNSQ - SAMPLE COBOL PROGRAM TO DEMONSTRATE THE DYNAMIC   
      *               SQL CALL TO DB2                                   
      * 
      *               FETCHES LASTNAME AND SALARY BASED ON INPUT OF 
      *               SQL STATEMENT AND STORES THAT INTO A GDG   
      *                                                                 
      *-----------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBDYNSQ.

       DATA DIVISION.
       FILE-CONTROL.
          SELECT OUTFILE ASSIGN TO GDGFIL.
          SELECT STMTBUF ASSIGN TO PARMIN.

       DATA DIVISION.
       FILE SECTION.
       FD OUTFILE
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 80 CHARACTERS.
       01 OUTREC.
          05 OUTREC-LASTNAME		PIC X(15).
          05 OUTREC-SALARY   		PIC S9(7)V9(2) USAGE COMP-3.
          05 OUTFILL			PIC X(60) VALUE SPACES.
       FD STMTBUF
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 400 CHARACTERS.
       01 STMTBUF-REC.
          05 STMTLEN			PIC S9(4) COMP VALUE +398.
          05 STMTTXT			PIC X(398).
          
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION.                                           
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01  ERROR-MESSAGE.
               02  ERROR-LEN   PIC S9(4)  COMP VALUE +960.
               02  ERROR-TEXT  PIC X(80) OCCURS 12 TIMES
                                          INDEXED BY ERROR-INDEX.
       01  ERROR-TEXT-LEN      PIC S9(9)  COMP VALUE +80.
       
       01  END-OF-C1-SWITCH    PIC X          VALUE  SPACES.
               88  END-OF-C1                  VALUE  'Y'.           

           EXEC SQL INCLUDE SQLCA  END-EXEC.
	
           EXEC SQL INCLUDE EMP END-EXEC.
           
           EXEC SQL
                    DECLARE STMT STATEMENT
           END-EXEC.
     
           EXEC SQL
                    DECLARE C1 CURSOR FOR STMT
           END-EXEC.

      *-----------------------------------------------------------------
      * PROCEDURE DIVISION.                                                
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       100-MAIN-MODULE.
           OPEN OUTPUT OUTFILE
           DISPLAY "SAMPLE COBOL PROGRAM: COBDYNSQ"
      *-----------------------------------------------------------------
      * PREPARATION OF THE DYNAMIC SQL CALL STATEMENT.                     
      *-----------------------------------------------------------------
           EXEC SQL
                PREPARE STMT
                FROM :STMTBUF-REC
           END-EXEC

           DISPLAY 'SQLCODE AFTER PREPARE = ' SQLCODE

           EVALUATE SQLCODE
               WHEN 0
                    CONTINUE
               WHEN OTHER
                    PERFORM 900-DBERROR
                    THRU    900-EXIT
           END-EVALUATE

           EXEC SQL
                OPEN C1
           END-EXEC

           DISPLAY 'SQLCODE AFTER OPEN = ' SQLCODE

           EVALUATE SQLCODE
               WHEN 0
                    CONTINUE
               WHEN OTHER
                    PERFORM 900-DBERROR
                    THRU    900-EXIT
           END-EVALUATE

           MOVE 'N' TO END-OF-C1-SWITCH.

           PERFORM 200-FETCH
           THRU    200-EXIT UNTIL END-OF-C1.

           EXEC SQL
                CLOSE C1
           END-EXEC

           DISPLAY 'SQLCODE AFTER CLOSE = ' SQLCODE.

           EVALUATE SQLCODE
               WHEN 0
                    CONTINUE
               WHEN OTHER
                    PERFORM 900-DBERROR
                    THRU    900-EXIT
           END-EVALUATE
           
           CLOSE OUTFILE
           
           STOP RUN.

      *-----------------------------------------------------------------
      * FETCH PARA FECTHES DETAILS AS PER THE PREPARED DYNAMIC SQL STMT.   
      *-----------------------------------------------------------------
       200-FETCH.
                EXEC SQL
                     FETCH C1
                     INTO  :OUTREC-LASTNAME
                         , :OUTREC-SALARY
                END-EXEC        
                DISPLAY 'SQLCODE AFTER FETCH = ' SQLCODE
                EVALUATE SQLCODE
                    WHEN 0
                         WRITE OUTREC
                    WHEN +100
                         MOVE 'Y' TO END-OF-C1-SWITCH
                    WHEN OTHER
                         PERFORM 900-DBERROR
                         THRU    900-EXIT
                END-EVALUATE.
      *-----------------------------------------------------------------
      * EXIT STATEMENT FOR FETCH PARA.                                     
      *-----------------------------------------------------------------
       200-EXIT.
                EXIT.
                     
      *-----------------------------------------------------------------
      * DBERROR PARA. THIS IS CALLED WHEN THERE IS SOME SQL ERROR          
      *-----------------------------------------------------------------
       900-DBERROR.
                CALL 'DSNTIAR' USING SQLCA ERROR-MESSAGE ERROR-TEXT-LEN.
                IF RETURN-CODE = ZERO
                   PERFORM 9999-ERROR-DISPLAY THRU
                           9999-EXIT
                   VARYING ERROR-INDEX
                   FROM    1 BY 1
                   UNTIL   ERROR-INDEX GREATER THAN 12.
                GOBACK.
      *-----------------------------------------------------------------
      * EXIT PARA FOR DBERROR PARA.          
      *-----------------------------------------------------------------
       900-EXIT.
                EXIT.
                
      *-----------------------------------------------------------------
      * ERROR DISPLAY PARA. IT IS CALLED IN CASE OF ERRORS AND IT 
      * DISPLAYES THE ERROR MESSAGE AT THE MAINFRAME SYSOUT.
      *-----------------------------------------------------------------
       9999-ERROR-DISPLAY.
                DISPLAY ERROR-TEXT (ERROR-INDEX).
      *-----------------------------------------------------------------
      * EXIT PARA FOR ERROR DISPLAY PARA.                                  
      *-----------------------------------------------------------------
       9999-EXIT.
                EXIT.
