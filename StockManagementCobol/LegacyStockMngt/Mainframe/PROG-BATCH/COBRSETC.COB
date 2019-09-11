      *-----------------------------------------------------------------
      *     COBRSETC - SAMPLE COBOL PROGRAM TO DEMONSTRATE CALLING OF A 
      *                DB2 STORED PROCEDURE                             
      *                                                                 
      *                THIS MODULE GETS EMPLOYEE INFORMATION FROM THE   
      *                DB2 STORED PROCEDURE.                            
      *                                                                 
      *     EXIT-NORMAL = RETURN CODE 0 NORMAL COMPLETION               
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBRSETC.                                         
      /                                                                 
       ENVIRONMENT DIVISION.                                            
      *--------------------                                             
       CONFIGURATION SECTION.                                           
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
           SELECT CARDIN                                                
                  ASSIGN TO DA-S-CARDIN.                                
                                                                        
       DATA DIVISION.                                                   
      *-------------                                                    
       FILE SECTION.                                                    
       FD      CARDIN                                                   
               RECORD CONTAINS 3 CHARACTERS                             
               BLOCK CONTAINS 0 RECORDS                                 
               LABEL RECORDS ARE OMITTED.                               
       01  CARDREC                    PIC X(3).                         
                                                                        
      /                                                                 
       WORKING-STORAGE SECTION.                                         
                                                                        
      *****************************************************             
      * STRUCTURE FOR INPUT                               *             
      *****************************************************             
       01  PDEPTNO       PIC X(3).                                      
       01  PDEPTNAME.                                                   
           49  PDEPTNAME-LEN      PIC S9(4) COMP.                       
           49  PDEPTNAME-TEXT     PIC X(36).                            
       01  PSQLCODE      PIC S9(9) COMP.                                
       01  PSQLSTATE     PIC X(5).                                      
       01  PSQLERRMC.                                                   
           49  PSQLERRMC-LEN      PIC S9(4) COMP.                       
           49  PSQLERRMC-TEXT     PIC X(250).                           
      *****************************************************             
      * WORKAREAS                                         *             
      *****************************************************             
       77  INPUT-SWITCH        PIC X          VALUE  SPACES.            
               88  NOMORE-INPUT               VALUE  'N'.               
       77  END-OF-C1-SWITCH    PIC X          VALUE  SPACES.            
               88  END-OF-C1                  VALUE  'Y'.               
       01  WS-TIMESTAMP         PIC X(26).                              
       01  WS-SQLCODE           PIC 9(9).                               
       01  WS-MISC-HOST.                                                
           10 WEMPNO                PIC X(6).                           
           10 WFIRSTNME.                                                
              49 WFIRSTNME-LEN         PIC S9(4) COMP.                  
              49 WFIRSTNME-TEXT        PIC X(12).                       
           10 WMIDINIT              PIC X(1).                           
           10 WLASTNAME.                                                
              49 WLASTNAME-LEN         PIC S9(4) COMP.                  
              49 WLASTNAME-TEXT        PIC X(15).                       
           10 WHIREDATE             PIC X(10).                          
           10 WSALARY               PIC S9(7)V9(2) USAGE COMP-3.        
                                                                        
      ****************************************************************  
      *    DECLARE A RESULT SET LOCATOR FOR THE RESULT SET THAT      *  
      *    IS RETURNED.                                              *  
      ****************************************************************  
      *                                                                 
       01 LOC-DTLSC USAGE SQL TYPE IS                                   
          RESULT-SET-LOCATOR VARYING.                                   
                                                                        
      ******************************************************************
      * VARIABLES FOR ERROR-HANDLING                                    
      ******************************************************************
       01  ERROR-MESSAGE.                                               
               02  ERROR-LEN   PIC S9(4)  COMP VALUE +960.              
               02  ERROR-TEXT  PIC X(80) OCCURS 12 TIMES                
                                          INDEXED BY ERROR-INDEX.       
       77  ERROR-TEXT-LEN      PIC S9(9)  COMP VALUE +80.               
                                                                        
      /                                                                 
      ******************************************************************
      * SQLCA AND DCLGENS FOR TABLES                                    
      ******************************************************************
                EXEC SQL INCLUDE SQLCA  END-EXEC.                       
                                                                        
           EXEC SQL INCLUDE EMP                                         
           END-EXEC.                                                    
                                                                        
      /                                                                 
      ******************************************************************
      * SQL CURSORS AND STATEMENTS                                      
      ******************************************************************
                                                                        
      /                                                                 
       PROCEDURE DIVISION.                                              
      *------------------                                               
                                                                        
      ******************************************************************
      * MAIN PROGRAM ROUTINE                                            
      ******************************************************************
       MAINLINE.                                                        
                DISPLAY '++ COBRSETC STARTING ++'.                      
                                                                        
                EXEC SQL                                                
                     SET :WS-TIMESTAMP = CURRENT TIMESTAMP              
                END-EXEC.                                               
                                                                        
                DISPLAY 'WS-TIMESTAMP = ' WS-TIMESTAMP.                 
                                                                        
                PERFORM 1000-OPEN-AND-READ                              
                THRU    1000-EXIT.                                      
                                                                        
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                        
      ****   PROCESS RESULT SETS, IF ANY                                
                                                                        
                IF  SQLCODE = +466                                      
                    PERFORM 2100-PROCESS-CURSOR                         
                    THRU    2100-EXIT.                                  
                                                                        
                PERFORM 3000-CLOSE                                      
                THRU    3000-EXIT.                                      
                                                                        
                DISPLAY '++ COBRSETC ENDING ++'.                        
                                                                        
                GOBACK.                                                 
      /                                                                 
      ******************************************************************
      * 1000-OPEN-AND-READ                                              
      ******************************************************************
       1000-OPEN-AND-READ.                                              
                OPEN INPUT  CARDIN.                                     
                                                                        
                READ CARDIN RECORD INTO PDEPTNO                         
                   AT END MOVE 'N' TO INPUT-SWITCH.                     
                                                                        
                IF  NOMORE-INPUT                                        
                    DISPLAY '++ COBRSETC EMPTY FILE ++'                 
                    CLOSE CARDIN                                        
                    GOBACK.                                             
                                                                        
               MOVE SPACES TO  PDEPTNAME.                               
               MOVE 0      TO  PSQLCODE.                                
               MOVE SPACES TO  PSQLSTATE.                               
               MOVE SPACES TO  PSQLERRMC.                               
                                                                        
       1000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 2000-PROCESS                                                    
      ******************************************************************
       2000-PROCESS.                                                    
                DISPLAY 'PDEPTNO = ' PDEPTNO.                           
                                                                        
                EXEC SQL                                                
                     CALL COBSPSET( :PDEPTNO                            
                                   ,:PDEPTNAME                          
                                   ,:PSQLCODE                           
                                   ,:PSQLSTATE                          
                                   ,:PSQLERRMC                          
                                  )                                     
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE = ' WS-SQLCODE.                     
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN +466                                           
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                DISPLAY 'PDEPTNAME  = ' PDEPTNAME.                      
                DISPLAY 'PSQLCODE   = ' PSQLCODE.                       
                DISPLAY 'PSQLSTATE  = ' PSQLSTATE.                      
                DISPLAY 'PSQLERRMC  = ' PSQLERRMC.                      
                                                                        
       2000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 2100-PROCESS-CURSOR.                                            
      ******************************************************************
       2100-PROCESS-CURSOR.                                             
                DISPLAY '++ PROCESSING CURSOR ROWS ++'.                 
                                                                        
                EXEC SQL ASSOCIATE LOCATORS (:LOC-DTLSC)                
                    WITH PROCEDURE COBSPSET                             
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE AFTER ASSOCIATE = ' WS-SQLCODE.     
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                EXEC SQL ALLOCATE C1 CURSOR FOR RESULT SET              
                    :LOC-DTLSC                                          
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE AFTER ALLOCATE = ' WS-SQLCODE.      
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                PERFORM 2200-GET-EACH                                   
                THRU    2200-EXIT                                       
                UNTIL   END-OF-C1.                                      
                                                                        
       2100-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 2200-GET-EACH                                                   
      ******************************************************************
       2200-GET-EACH.                                                   
                EXEC SQL                                                
                    FETCH C1                                            
                    INTO  :WEMPNO                                       
                        , :WFIRSTNME                                    
                        , :WMIDINIT                                     
                        , :WLASTNAME                                    
                        , :WHIREDATE                                    
                        , :WSALARY                                      
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE AFTER FETCH = ' WS-SQLCODE.         
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN +100                                           
                         MOVE 'Y' TO END-OF-C1-SWITCH                   
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                DISPLAY 'WEMPNO      = '  WEMPNO.                       
                DISPLAY 'WFIRSTNME   = '  WFIRSTNME.                    
                DISPLAY 'WMIDINIT    = '  WMIDINIT.                     
                DISPLAY 'WLASTNAME   = '  WLASTNAME.                    
                DISPLAY 'WHIREDATE   = '  WHIREDATE.                    
                DISPLAY 'WSALARY     = '  WSALARY.                      
                                                                        
       2200-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 3000-CLOSE                                                      
      ******************************************************************
       3000-CLOSE.                                                      
                CLOSE CARDIN.                                           
       3000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 9000-DBERROR - GET ERROR MESSAGE                                
      ******************************************************************
       9000-DBERROR.                                                    
                CALL 'DSNTIAR' USING SQLCA ERROR-MESSAGE ERROR-TEXT-LEN.
                IF RETURN-CODE = ZERO                                   
                   PERFORM 9999-ERROR-DISPLAY THRU                      
                           9999-EXIT                                    
                   VARYING ERROR-INDEX                                  
                   FROM    1 BY 1                                       
                   UNTIL   ERROR-INDEX GREATER THAN 12.                 
                                                                        
                PERFORM 3000-CLOSE                                      
                THRU    3000-EXIT.                                      
                                                                        
                GOBACK.                                                 
                                                                        
       9000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      ******************************************************************
      * 9999-ERROR-DISPLAY                                              
      ******************************************************************
       9999-ERROR-DISPLAY.                                              
                DISPLAY ERROR-TEXT (ERROR-INDEX).                       
       9999-EXIT.                                                       
                EXIT.                                                   
