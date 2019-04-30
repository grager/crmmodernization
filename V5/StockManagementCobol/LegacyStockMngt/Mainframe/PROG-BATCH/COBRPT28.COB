      *-----------------------------------------------------------------
      *     COBRPT28 - THIS PROGRAM READS EMPLOYEE TABLE AND CREATES            
      *                REPORT OF THOSE EMPLOYEE WHOSE BIRTHDATE  
      *                HAVE NOT BEEN ENTERED IN DATABASE
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBRPT28.                                         
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
       77  END-OF-C1-SWITCH       PIC X          VALUE  SPACES.            
               88  END-OF-C1                     VALUE  'Y'.                      
       01  WS-EMPNO               PIC X(6).                                      
       01  WS-SQLCODE             PIC 9(9).                               
       
       01  WS-RPT-HEADER.                                                
           10 FILLER              PIC X(46)
           10 WS-TEXT             PIC X(40) 
                VALUE 'EMPLOYEES WHOSE BIRTHDATE NOT THERE'         
           10 FILLER              PIC X(46)
           
       01  WS-RPT-COLUMNS.
           10 FILLER              PIC X(23).
           10 WS-COL1             PIC X(6)   VALUE 'EMPNO'.
           10 FILLER              PIC X(2).
           10 WS-COL2             PIC X(30)  VALUE 'NAME'.
           10 FILLER              PIC X(2).
           10 WS-COL3             PIC X(4)   VALUE 'DEPT'.
           10 FILLER              PIC X(2).
           10 WS-COL4             PIC X(12)  VALUE 'HIREDATE'.
           10 FILLER              PIC X(2).
           
       01  WS-RPT-DETAIL.
           10 FILLER              PIC X(23).
           10 WS-EMPNO            PIC X(6).
           10 FILLER              PIC X(2).
           10 WS-NAME.
              15 WS-LASTNAME      PIC X(15).
              15 WS-MIDINIT       PIC X(1).
              15 WS-FIRSTNAME     PIC X(12). 
           10 FILLER              PIC X(4).
           10 WS-DEPT             PIC X(3).
           10 FILLER              PIC X(3).
           10 WS-HIREDATE         PIC X(10).
           10 FILLER              PIC X(53).
                                                                        
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
                                                                        
                EXEC SQL DECLARE C1 CURSOR                                
                  SELECT                                                
                      EMPNO,
                      FIRSTNAME,
                      MIDINIT,
                      LASTNAME,
                      WORKDEPT,
                      HIREDATE
                    FROM EMP                                            
                    WHERE BIRTHDATE IS NULL                         
                END-EXEC.                                               
                                                                        
      /                                                                 
       PROCEDURE DIVISION.                                                                                                                     
      ******************************************************************
      * MAIN PROGRAM ROUTINE                                            
      ******************************************************************
       MAINLINE.                                                        
                                  
                PRINT WS-RPT-HEADER.
                
                PRINT WS-RPT-COLUMNS.
                                  
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                                                                                         
                STOP RUN.                                                 
      /                                                                 
      ******************************************************************
      * 2000-PROCESS                                                    
      ******************************************************************
       2000-PROCESS.                                                    

                PERFORM 2100-OPEN-CURSOR                                    
                THRU    2100-EXIT.                                      
                                                                  
                PERFORM 2200-FETCH-CURSOR                                    
                THRU    2200-EXIT
                UNTIL END-OF-C1-SWITCH.
                                                                  
                PERFORM 2300-CLOSE-CURSOR                                    
                THRU    2300-EXIT.                                      
                                                                                                                                                                                                                                                                                        
       2000-EXIT.                                                       
                EXIT.                                                   

      /                                                                 
      ******************************************************************
      * 2100-OPEN-CURSOR                                                    
      ******************************************************************
       2100-OPEN-CURSOR.                                                    

                EXEC SQL                                                
                  OPEN  C1                                              
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE ON OPEN = ' WS-SQLCODE.         
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                                                                                                   
                                                                                                                                                                                                                      
       2100-EXIT.                                                       
                EXIT.                                                   

      /                                                                 
      ******************************************************************
      * 2200-FETCH-CURSOR                                                    
      ******************************************************************
       2200-FETCH-CURSOR.                                                    

                EXEC SQL                                                
                    FETCH C1                                            
                    INTO  :WS-EMPNO,
                          :WS-FIRSTNAME,
                          :WS-MIDINIT,
                          :WS-LASTNAME,
                          :WS-DEPT,
                          :WS-HIREDATE
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
                
                PRINT WS-PRT-DETAIL.
                                                                                                                                                                                                                                                                                              
       2200-EXIT.                                                       
                EXIT.                                                   

      /                                                                 
      ******************************************************************
      * 2300-CLOSE-CURSOR                                                    
      ******************************************************************
       2300-CLOSE-CURSOR.                                                    

                EXEC SQL                                                
                  CLOSE  C1                                              
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE ON CLOSE = ' WS-SQLCODE.         
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                                                                                                   
                                                                                                                                                                                                                      
       2300-EXIT.                                                       
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