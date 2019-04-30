      *-----------------------------------------------------------------
      *    COBSPDTL - SAMPLE COBOL STORED PROCEDURE                     
      *               USES PARAMETER STYLE GENERAL                      
      *                                                                 
      *    MODULE NAME = COBSPDTL                                       
      *                                                                 
      *    FUNCTION = THIS MODULE ACCEPTS AN EMPLOYEE NUMBER AND RETURNS
      *               EMPLOYEE INFORMATION                              
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBSPDTL.                                         
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
       01  PFIRSTNME.                                                   
           49  PFIRSTNME-LEN     PIC S9(4) COMP.                        
           49  PFIRSTNME-TEXT    PIC X(12).                             
       01  PMIDINIT      PIC X(1).                                      
       01  PLASTNAME.                                                   
           49  PLASTNAME-LEN     PIC S9(4) COMP.                        
           49  PLASTNAME-TEXT    PIC X(15).                             
       01  PWORKDEPT     PIC X(3).                                      
       01  PHIREDATE     PIC X(10).                                     
       01  PSALARY       PIC S9(7)V9(2) COMP-3.                         
       01  PSQLCODE      PIC S9(9) COMP.                                
       01  PSQLSTATE     PIC X(5).                                      
       01  PSQLERRMC.                                                   
           49  PSQLERRMC-LEN     PIC S9(4) COMP.                        
           49  PSQLERRMC-TEXT    PIC X(250).                            
                                                                        
      *-----------------------------------------------------------------
      * SQL CURSORS AND STATEMENTS                                      
      *-----------------------------------------------------------------
                                                                        
      /                                                                 
       PROCEDURE DIVISION USING PEMPNO, PFIRSTNME, PMIDINIT, PLASTNAME, 
                          PWORKDEPT, PHIREDATE, PSALARY, PSQLCODE,      
                          PSQLSTATE, PSQLERRMC.                         
                                                                        
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
                      FIRSTNME,                                         
                      MIDINIT,                                          
                      LASTNAME,                                         
                      WORKDEPT,                                         
                      HIREDATE,                                         
                      SALARY                                            
                  INTO                                                  
                      :PFIRSTNME                                        
                    , :PMIDINIT                                         
                    , :PLASTNAME                                        
                    , :PWORKDEPT                                        
                    , :PHIREDATE                                        
                    , :PSALARY                                          
                  FROM EMP                                              
                  WHERE EMPNO = :WS-EMPNO                               
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.           
                                                                        
                MOVE SQLCODE  TO PSQLCODE.                              
                MOVE SQLSTATE TO PSQLSTATE.                             
                MOVE SQLERRMC TO PSQLERRMC.                             
                                                                        
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
