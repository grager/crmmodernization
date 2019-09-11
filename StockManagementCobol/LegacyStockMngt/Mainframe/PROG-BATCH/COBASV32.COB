      *-----------------------------------------------------------------
      *    COBASV32 - SAMPLE COBOL STORED PROCEDURE FOR VIOLATION OF HIGH FANOUT 
      *               , USES PARAMETER STYLE GENERAL                      
      *                                                                 
      *    MODULE NAME = COBASV32
      *                                                                 
      *    FUNCTION = THIS MODULE ACCEPTS AN EMPLOYEE NUMBER AND RETURNS
      *               EMPLOYEE  SALARY
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV32.                                         
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
                EXEC SQL INCLUDE SQLCA  END-EXEC.                       
                                                                        
           EXEC SQL INCLUDE EMP                                         
           END-EXEC.                                                    
                                                                        
      /                                                                 
       LINKAGE SECTION.                                                 
       01  PEMPNO        PIC X(6).                                      
       01  PSALARY       PIC S9(7)V(2) USAGE COMP-3.                                     
                                                                        
      *-----------------------------------------------------------------
      * SQL CURSORS AND STATEMENTS                                      
      *-----------------------------------------------------------------
                                                                        
      /                                                                 
       PROCEDURE DIVISION USING PEMPNO, PSALARY.                         
                                                                        
      *-----------------------------------------------------------------
      * MAIN PROGRAM ROUTINE                                            
      *-----------------------------------------------------------------
       MAINLINE.                                                        
                DISPLAY '++ START OF COBSPDTL STARTING ++'.             
                                                                        
                EXEC SQL                                                
                     SET CURRENT SQLID = USER                           
                END-EXEC.                                               
                                                                        
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                        
                DISPLAY '++ END OF COBSPDTL ++'.                        
                                                                        
                GOBACK.                                                 
      /                                                                 
      *-----------------------------------------------------------------
      * 2000-PROCESS                                                    
      *-----------------------------------------------------------------
       2000-PROCESS.                                                    
                MOVE PEMPNO TO WS-EMPNO.                                
                                                                        
                DISPLAY 'WS-EMPNO = ' WS-EMPNO.                         
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      LASTNAME                                          
                  INTO                                                  
                      :PLASTNAME                                        
                  FROM EMP                                              
                  WHERE EMPNO = :WS-EMPNO                               
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.           
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
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
