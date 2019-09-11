      *---------------------------------------------------------------
      *
      *   THIS IS AN IMS COBOL PROGRAM WHICH GETS TRIGGERED BY 
      *   JOBDET TRANSACTION (INVOKED BY 'SENDJOBDETAILS.JAVA')
      *
      *   WRITE JOB DETAILS TO IMS DATABASE (DBDJOBDT)
      *    
      *   CAUTION : THIS IS A DEMO PROGRAM AND MAY NOT BE USED AS IS  
      *
      *---------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION---------
      *                                                                 
      *---------------------------------------------------------------     
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBIMSO1.                                           
       
       ENVIRONMENT DIVISION.                                            
       CONFIGURATION SECTION.                                            
            
       DATA DIVISION.                                                   
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
       01  JOBDET-SEG-IN.
           10 JOBID                PIC X(20).
           10 SUBSIDIARY           PIC X(20).
           10 DEPTNO               PIC X(03).
           10 RUNDATE              PIC X(10).
           10 RUNTIME              PIC X(05).
       01  MESSAGE-BUFFER-IN.
           05  MI-LENGTH                PIC S9(4)  COMP.
           05  MI-ZZ                    PIC S9(4)  COMP.
           05  MI-TRAN-CODE             PIC X(6).
      *          (JOBDET)
           05  MI-TX-RECORD             PIC X(58).           
                      
      *-----------------------------------------------------------------
      * LINKAGE SECTION                                                       
      *-----------------------------------------------------------------
       LINKAGE SECTION.             
       01 IOPCB
          02  IO-LTERM      PIC X(8).
          02  IO-RESIMS     PIC X(2).
          02  IO-STATUSCD   PIC X(2).
          02  IO-LOCALDT.
              05 IO-DATE    PIC S9(03) COMP-3. 
              05 IO-TIME    PIC S9(07) COMP-3.
          02  IO-MSGSEQNO   PIC S9(4) COMP.
          02  IO-MSGOUT     PIC X(8).
          02  IO-USERID     PIC X(8).
          02  IO-GROUPNAME  PIC X(8).
          02  IO-TIMESTAMP.
              05 IO-TS-DATE PIC S9(07) COMP-3.
              05 IO-TS-TIME PIC  9(10) COMP-3.
              05 IO-TS-OFF  PIC S9(03) COMP-3.
          02  IO-USRID      PIC X(01).
          02  IO-RESIMS2    PIC X(03).
       
       01 JOBPCB.                                                       
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
      * PROCEDURE DIVISION.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.                                              
      *-----------------------------------------------------------------
      * ENTERS DLITCBL AND PERFORMS WRITEJOBDETAILS MODULE AFTER GETTING
      * THE MESSAGE QUEUE FROM OTMA
      *-----------------------------------------------------------------
       100-MAIN-MODULE.     
           ENTRY 'DLITCBL' USING IOPCB JOBPCB.
           
           CALL 'CBLTDLI' USING GU, IOPCB, MESSAGE-BUFFER-IN.
           
           PERFORM 200-WRITEJOBDETAILS-MODULE THRU 200-EXIT.
           
           GOBACK.    
      *-----------------------------------------------------------------
      * EXIT PARA FOR PROCEDURE DIVISION                                     
      *-----------------------------------------------------------------
       100-EXIT.                                                        
           EXIT.                                                        
       
      *-----------------------------------------------------------------
      * THIS PARA CALLS THE CBLDTLI WHICH MAKES A CALL TO IMS DB.        
      *-----------------------------------------------------------------
       200-WRITEJOBDETAILS-MODULE.
       
           MOVE MI-TX-RECORD TO JOBDET-SEG-IN.
       
           CALL 'CBLTDLI' USING ISRT, JOBPCB, JOBDET-SEG-IN.          		           
                          
      *-----------------------------------------------------------------
      * EXIT WRITE JOB DETAILS PARAGRAPH.                                           
      *-----------------------------------------------------------------
       200-EXIT.
           EXIT.
           
       