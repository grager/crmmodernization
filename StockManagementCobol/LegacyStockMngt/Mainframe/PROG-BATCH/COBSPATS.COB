      *-----------------------------------------------------------------
      *    COBSPATS - SAMPLE COBOL STORED PROCEDURE                     
      *               INVOKED BY A TRIGGER PASSING TRANSITION VARIABLES 
      *                                                                 
      *    MODULE NAME = COBSPATS                                       
      *                                                                 
      *    FUNCTION = THIS MODULE ACCEPTS AN EMPLOYEE NUMBER,           
      *               OLD SALARY AND NEW SALARY AND DISPLAYS THEM.      
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBSPATS.                                         
      /                                                                 
       ENVIRONMENT DIVISION.                                            
      *--------------------                                             
       CONFIGURATION SECTION.                                           
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
       DATA DIVISION.                                                   
      *-------------                                                    
       FILE SECTION.                                                    
      /                                                                 
       WORKING-STORAGE SECTION.                                         
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       01  WS-PARMAREA.                                                 
               02  WS-EMPNO              PIC X(06).                     
               02  WS-OLDSALARY          PIC S9(7)V99 COMP-3.           
               02  WS-NEWSALARY          PIC S9(7)V99 COMP-3.           
                                                                        
      *-----------------------------------------------------------------
      * VARIABLES FOR ERROR-HANDLING                                    
      *-----------------------------------------------------------------
       01  ERROR-MESSAGE.                                               
               02  ERROR-LEN   PIC S9(4)  COMP VALUE +960.              
               02  ERROR-TEXT  PIC X(80) OCCURS 12 TIMES                
                                          INDEXED BY ERROR-INDEX.       
       77  ERROR-TEXT-LEN      PIC S9(9)  COMP VALUE +80.               
                                                                        
      /                                                                 
      *-----------------------------------------------------------------
      * SQLCA AND DCLGENS FOR TABLES                                    
      *-----------------------------------------------------------------
                EXEC SQL INCLUDE SQLCA    END-EXEC.                     
                EXEC SQL INCLUDE EMP      END-EXEC.                     
                                                                        
      /                                                                 
       LINKAGE SECTION.                                                 
       01  PEMPNO        PIC X(6).                                      
       01  POLDSALARY    PIC S9(7)V9(2) COMP-3.                         
       01  PNEWSALARY    PIC S9(7)V9(2) COMP-3.                         
      *-----------------------------------------------------------------
      * SQL CURSORS AND STATEMENTS                                      
      *-----------------------------------------------------------------
                                                                        
      /                                                                 
       PROCEDURE DIVISION USING PEMPNO, POLDSALARY, PNEWSALARY.         
                                                                        
      *-----------------------------------------------------------------
      * MAIN PROGRAM ROUTINE                                            
      *-----------------------------------------------------------------
       MAINLINE.                                                        
                DISPLAY '++ START OF COBSPATS STARTING ++'.             
                                                                        
                EXEC SQL                                                
                     SET CURRENT SQLID = USER                           
                END-EXEC.                                               
                                                                        
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                        
                DISPLAY '++ END OF COBSPATS ++'.                        
                                                                        
                GOBACK.                                                 
      /                                                                 
      *-----------------------------------------------------------------
      * 2000-PROCESS                                                    
      *-----------------------------------------------------------------
       2000-PROCESS.                                                    
                MOVE PEMPNO TO WS-EMPNO.                                
                MOVE POLDSALARY TO WS-OLDSALARY.                        
                MOVE PNEWSALARY TO WS-NEWSALARY.                        
                                                                        
                DISPLAY 'WS-EMPNO = ' WS-EMPNO.                         
                DISPLAY 'WS-OLDSALARY = ' WS-OLDSALARY.                 
                DISPLAY 'WS-NEWSALARY = ' WS-NEWSALARY.                 
                                                                        
       2000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 9000-DBERROR - GET ERROR MESSAGE                                
      *-----------------------------------------------------------------
       9000-DBERROR.                                                    
                CALL 'DSNTIAR' USING SQLCA ERROR-MESSAGE ERROR-TEXT-LEN.
                IF RETURN-CODE = ZERO                                   
                   PERFORM 9999-ERROR-DISPLAY THRU                      
                           9999-EXIT                                    
                   VARYING ERROR-INDEX                                  
                   FROM    1 BY 1                                       
                   UNTIL   ERROR-INDEX GREATER THAN 12.                 
                                                                        
                GOBACK.                                                 
                                                                        
       9000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 9999-ERROR-DISPLAY                                              
      *-----------------------------------------------------------------
       9999-ERROR-DISPLAY.                                              
                DISPLAY ERROR-TEXT (ERROR-INDEX).                       
       9999-EXIT.                                                       
                EXIT.                                                   
