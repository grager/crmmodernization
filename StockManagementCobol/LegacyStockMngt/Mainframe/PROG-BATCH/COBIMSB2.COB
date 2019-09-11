      *---------------------------------------------------------------
      *
      *   THIS IS AN IMS COBOL BATCH PROGRAM TO DEMONSTRATE DL/I
      *   CALLS TO GSAM DATABASE
      *
      *   CAUTION : THIS IS A DEMO PROGRAM AND MAY NOT BE USED AS IS  
      *
      *---------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION---------
      *                                                                 
      *---------------------------------------------------------------     
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBIMSB2.                                           
       
       ENVIRONMENT DIVISION.                                            
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
            SELECT DBDGSAM ASSIGN TO GSASEQ.             
            
       DATA DIVISION.                                                   
       FILE SECTION.                                                    
       FD  DBDGSAM.                                     
             LABEL RECORD STANDARD.                                 
       01  DBDGSAM-REC     PIC X(80).                                           
          
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                            
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
       77  GET-UNIQUE      PIC  X(4)  VALUE 'GU  '.                     
       77  GET-HOLD-UNIQUE PIC  X(4)  VALUE 'GHU '.                     
       77  GET-NEXT        PIC  X(4)  VALUE 'GN  '.                     
       77  ISRT            PIC  X(4)  VALUE 'ISRT'.                     
       77  DLET            PIC  X(4)  VALUE 'DLET'.                     
       77  REPL            PIC  X(4)  VALUE 'REPL'. 
       77  COUNT 	   PIC  S9(5)  VALUE +4 COMPUTATIONAL. 
       01  UNQUAL-SSA.
       	   02 SEG-NAME 	   PIC  X(8)  VALUE '        '.
       	   02 FILLER 	   PIC  X     VALUE ' '.
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
       01 GSAPCB.                                                       
          02  DBD-NAME      PIC X(8).                                   
          02  SEG-LEVEL     PIC X(2).                                   
          02  STATUS-CODE   PIC X(2).                                   
          02  PROC-OPTIONS  PIC X(4).                                   
          02  RESERVE-DLI   PIC S9(9) USAGE IS BINARY.                  
          02  SEG-NAME-FB   PIC X(8).                                   
          02  KEY-LENGTH    PIC S9(9) USAGE IS BINARY.                  
          02  NO-SENSE-SEG  PIC S9(9) USAGE IS BINARY.                  
          02  KEY-AREA      PIC X(50).                                    
      
      *-----------------------------------------------------------------
      * MAIN PROGRAM ROUTINE                                            
      *-----------------------------------------------------------------
       PROCEDURE DIVISION USING GSAPCB.                                              
      *-----------------------------------------------------------------
      * ENTERS DLITCBL. PERFORMS PRINT DEPARTMENT MODULE.                                            
      *-----------------------------------------------------------------
       100-MAIN-MODULE.     
           ENTRY 'DLITCBL'
           
           PERFORM 200-PRINTDEPT-MODULE THRU 200-EXIT 
              UNTIL STATUS-CODE EQUAL TO 'GL'
                 
           GOBACK.    
       100-EXIT.                                                        
           EXIT.                                                        
       
      *-----------------------------------------------------------------
      * THIS PARAGRAPH CALLS THE COBOL PROGRAM CBLDTL1 USING THE COMMON
      * AREA TO PASS THE DETAILS TO PRINT DEPARTMENT DETAILS.                                            
      *-----------------------------------------------------------------
       200-PRINTDEPT-MODULE.
           CALL 'CBLTDLI' USING GET-NEXT, GSAPCB, DEPT-SEG-IN
                          
           DISPLAY 'DEPARTMENT NUMBER IS : ' DEPTNO.
       200-EXIT.
           EXIT.
           
       