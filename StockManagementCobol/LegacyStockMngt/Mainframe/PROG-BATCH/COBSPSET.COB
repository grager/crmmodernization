      *-----------------------------------------------------------------
      *     COBSPSET - THIS MODULE ACCEPTS A DEPT NUMBER AND            
      *                RETURNS THE DEPT NAME AS OUT PARM AND            
      *                A RESULT SET CONTAINING ALL EMPLOYEES            
      *                IN THAT DEPARTMENT.                              
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBSPSET.                                         
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
      *****************************************************             
      * WORKAREAS                                         *             
      *****************************************************             
       77  INPUT-SWITCH        PIC X          VALUE  SPACES.            
               88  NOMORE-INPUT               VALUE  'N'.               
       77  END-OF-C1-SWITCH    PIC X          VALUE  SPACES.            
               88  END-OF-C1                  VALUE  'Y'.               
       01  WS-TIMESTAMP         PIC X(26).                              
                                                                        
       01  WS-PARMAREA.                                                 
               02  WS-DEPTNO             PIC X(03).                     
                                                                        
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
                                                                        
                EXEC SQL INCLUDE DEPT                                         
                END-EXEC.                                               
                                                                  
      /                                                                 
       LINKAGE SECTION.                                                 
       01  PDEPTNO       PIC X(3).                                      
       01  PDEPTNAME.                                                   
           49 PDEPTNAME-LEN     PIC S9(4) COMP.                         
           49 PDEPTNAME-TEXT    PIC X(36).                              
       01  PSQLCODE      PIC S9(9) COMP.                                
       01  PSQLSTATE     PIC X(5).                                      
       01  PSQLERRMC.                                                   
           49 PSQLERRMC-LEN     PIC S9(4) COMP.                         
           49 PSQLERRMC-TEXT    PIC X(250).                             
                                                                        
      ******************************************************************
      * SQL CURSORS AND STATEMENTS                                      
      ******************************************************************
                                                                        
                EXEC SQL DECLARE C1                                     
                  CURSOR WITH RETURN FOR                                
                  SELECT                                                
                      EMPNO                                             
                    , FIRSTNME                                          
                    , MIDINIT                                           
                    , LASTNAME                                          
                    , HIREDATE                                          
                    , SALARY                                            
                    FROM EMP                                            
                    WHERE WORKDEPT = :WS-DEPTNO                         
                    ORDER BY SALARY DESC                                
                END-EXEC.                                               
                                                                        
      /                                                                 
       PROCEDURE DIVISION USING PDEPTNO, PDEPTNAME, PSQLCODE,           
                          PSQLSTATE, PSQLERRMC.                         
      *------------------                                               
                                                                        
      ******************************************************************
      * MAIN PROGRAM ROUTINE                                            
      ******************************************************************
       MAINLINE.                                                        
                DISPLAY '++ START OF COBSPSET STARTING ++'.             
                                                                        
                EXEC SQL                                                
                     SET CURRENT SQLID = USER                           
                END-EXEC.                                               
                                                                  
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                  
                DISPLAY '++ END OF COBSPSET ++'.                        
                                                                        
                GOBACK.                                                 
      /                                                                 
      ******************************************************************
      * 2000-PROCESS                                                    
      ******************************************************************
       2000-PROCESS.                                                    
                MOVE PDEPTNO TO WS-DEPTNO.                              
                                                                        
                DISPLAY 'WS-DEPTNO = ' WS-DEPTNO.                       
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      DEPTNAME                                          
                  INTO                                                  
                      :PDEPTNAME                                        
                  FROM DEPT                                             
                  WHERE DEPTNO = :WS-DEPTNO                             
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.           
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                EXEC SQL                                                
                  OPEN  C1                                              
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER OPEN   = ' SQLCODE.           
                                                                        
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
