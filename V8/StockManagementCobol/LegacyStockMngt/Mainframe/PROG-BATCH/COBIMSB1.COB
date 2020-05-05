      *---------------------------------------------------------------
      *
      *   THIS IS AN IMS COBOL BATCH PROGRAM TO DEMONSTRATE DL/I
      *   CALLS TO HISAM COMPANY DATABASE
      *
      *   USES DEPARTMENT SEGMENT TO DISPLAY NUMBERS OF VARIOUS
      *   DEPARTMENTS IN THE COMPANY 
      *    
      *   CAUTION : THIS IS A DEMO PROGRAM AND MAY NOT BE USED AS IS  
      *
      *---------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION---------
      *                                                                 
      *---------------------------------------------------------------     
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBIMSB1.                                           
       
       ENVIRONMENT DIVISION.                                            
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
            SELECT DBDCOMP1 ASSIGN TO CASTCMP1.             
            
       DATA DIVISION.                                                   
       FILE SECTION.                                                    
       FD  DBDCOMP1.                                     
             LABEL RECORD STANDARD.                                 
       01  DBDCOMP1-REC     PIC X(80).                                           
          
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
       01  GET-UNIQUE      PIC  X(4)  VALUE 'GU  '.                     
       01  GET-HOLD-UNIQUE PIC  X(4)  VALUE 'GHU '.                     
       01  GET-NEXT        PIC  X(4)  VALUE 'GN  '.                     
       01  ISRT            PIC  X(4)  VALUE 'ISRT'.                     
       01  DLET            PIC  X(4)  VALUE 'DLET'.                     
       01  REPL            PIC  X(4)  VALUE 'REPL'. 
       01  COUNT 	   PIC  S9(5)  VALUE +4 COMPUTATIONAL. 
       01  UNQUAL-SSA.
       	   10 SEG-NAME 	   PIC  X(8)  VALUE '        '.
       	   10 FILLER 	   PIC  X     VALUE ' '.
       01  DEPT-SEG-IN.
           10 DEPTNO               PIC X(3).
           10 DEPTNAME.
              49 DEPTNAME-LEN      PIC S9(4) USAGE COMP.
              49 DEPTNAME-TEXT     PIC X(36).
           10 MGRNO                PIC X(6).
           10 ADMRDEPT             PIC X(3).
           10 LOCATION             PIC X(16).           
                      
      *-----------------------------------------------------------------
      * LINKAGE SECTION                                                       
      *-----------------------------------------------------------------
       LINKAGE SECTION.             
       01 DEPTPCB.                                                       
          02  DBD-NAME      PIC X(8).                                   
          02  SEG-LEVEL     PIC X(2).                                   
          02  STATUS-CODE   PIC X(2).                                   
          02  PROC-OPTIONS  PIC X(4).                                   
          02  RESERVE-DLI   PIC S9(9) USAGE IS BINARY.                  
          02  SEG-NAME-FB   PIC X(8).                                   
          02  KEY-LENGTH    PIC S9(9) USAGE IS BINARY.                  
          02  NO-SENSE-SEG  PIC S9(9) USAGE IS BINARY.                  
          02  KEY-AREA      PIC X(3).                                    
      
      *-----------------------------------------------------------------
      * PROCEDURE DIVISION. THIS IMS PROGRAMS IS RUN USING JCL 'JOBIMSB#'
      * THE PROGRAM ACCEPTS DEPARTMENT PCB FROM THE JOB.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION USING DEPTPCB.                                              
      *-----------------------------------------------------------------
      * ENTERS DLITCBL AND PERFORMS PRINT DEPARTMENT MODULE
      *-----------------------------------------------------------------
       100-MAIN-MODULE.     
           ENTRY 'DLITCBL'
           
           PERFORM 200-PRINTDEPT-MODULE THRU 200-EXIT 
              UNTIL STATUS-CODE EQUAL TO 'QC'
                 
           GOBACK.    
      *-----------------------------------------------------------------
      * EXIT PARA FOR PROCEDURE DIVISION                                     
      *-----------------------------------------------------------------
       100-EXIT.                                                        
           EXIT.                                                        
       
      *-----------------------------------------------------------------
      * THIS PARA CALLS THE CBLDTLI WHICH MAKES A CALL TO IMS DB.        
      *-----------------------------------------------------------------
       200-PRINTDEPT-MODULE.
           CALL 'CBLTDLI' USING GET-NEXT, DEPTPCB, DEPT-SEG-IN
                          
           DISPLAY 'DEPARTMENT NUMBER IS : ' DEPTNO.
      *-----------------------------------------------------------------
      * EXIT PRINT DEPT PARAGRAPH.                                           
      *-----------------------------------------------------------------
       200-EXIT.
           EXIT.
           
       