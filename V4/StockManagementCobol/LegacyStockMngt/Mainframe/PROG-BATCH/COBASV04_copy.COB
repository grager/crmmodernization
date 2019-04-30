      *-----------------------------------------------------------------
      *     COBASV04 - THIS PROGRAM READS EMPLOYEE TABLE AND CREATES            
      *                REPORT OF THOSE EMPLOYEE WHO HAVE BONUS MORE 
      *                THAN $10,000.00
      *
      *		 VIOLATION OF HIGH COMPLEXITY (HAVING EVALUATE 
      *		 STATEMENT HAVING MORE THAN 25 WHEN OPTIONS WITH 
      *		 CALLS TO OTHER PARAGRAPHS)
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV04.                                         
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
                VALUE 'EMPLOYEES HAVING BONUS > $ 10,000.00'         
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
           10 WS-COL5             PIC X(12)  VALUE 'SALARY'.
           10 FILLER              PIC X(2).
           10 WS-COL6             PIC X(12)  VALUE 'BONUS'.
           10 FILLER              PIC X(23).
           
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
           10 FILLER              PIC X(4).
           10 WS-SALARY           PIC S9(7)V(2) USAGE COMP-3.
           10 FILLER              PIC X(4).
           10 WS-BONUS            PIC S9(7)V(2) USAGE COMP-3.
           10 FILLER              PIC X(25).
           
       01  WS-MISCELLENEOUS.
           
	   10 WS-FINAL-SALARY     PIC S9(04) USAGE COMP.
	   10 WS-FINAL-BONUS      PIC S9(04) USAGE COMP.
	   10 WS-BONUS-PERCENT    PIC S9(04) USAGE COMP.
           10 WS-PHONE            PIC X(04).
           10 WS-JOB              PIC X(08).
           10 WS-EDLEVEL          PIC S9(04) USAGE COMP.
           10 WS-SEX              PIC X(01). 
           10 WS-BIRTHDATE        PIC X(10).
           10 WS-COMM             PIC S9(7)V(2) USAGE COMP-3.
                                                                        
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
                      PHONENO,
                      HIREDATE,
                      JOB,
                      EDLEVEL,
                      SEX,
                      SALARY,
                      BONUS,
                      COMM
                    FROM EMP                                            
                    WHERE BONUS >= 10000                         
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
                          :WS-PHONE,
                          :WS-HIREDATE,
                          :WS-JOB,
                          :WS-EDLEVEL,
                          :WS-SEX,
                          :WS-BIRTHDATE,
                          :WS-SALARY,
                          :WS-BONUS,
                          :WS-COMM
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

      * SET BONUS PERCENTAGE ACCORDING TO THE SALARY OF THE EMPLOYEE 
      
               EVALUATE WS-SALARY
               WHEN < 1000
                  MOVE 30    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 2000
                  MOVE 29    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 3000
                  MOVE 28    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 4000
                  MOVE 27    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 5000
                  MOVE 26    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 6000
                  MOVE 25    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 7000
                  MOVE 24    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 8000
                  MOVE 23    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 9000
                  MOVE 22    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 10000
                  MOVE 21    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 11000
                  MOVE 20    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 12000
                  MOVE 19    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 13000
                  MOVE 18    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 14000
                  MOVE 17    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 15000
                  MOVE 16    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 16000
                  MOVE 15    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 17000
                  MOVE 14    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 18000
                  MOVE 13    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 19000
                  MOVE 12    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 10000
                  MOVE 11    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 21000
                  MOVE 10    TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 22000
                  MOVE 9     TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 23000
                  MOVE 8     TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 24000
                  MOVE 7     TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN < 25000
                  MOVE 6     TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

               WHEN OTHER
                  MOVE 5     TO WS-BONUS-PERCENT    
       		  PERFORM 2250-CALCULATE-SALARY                                                   

          END-EVALUATE.

          
                PRINT WS-PRT-DETAIL.
                                                                                                                                                                                                                                                                                              
       2200-EXIT.                                                       
                EXIT.                                                   

      /                                                                 
      ******************************************************************
      * 2250-CALCULATE-SALARY                                                    
      ******************************************************************
       2250-CALCULATE-SALARY.                                                    
                  MOVE WS-BONUS-PERCENT    TO WS-BONUS-PERCENT    
                  WS-FINAL-BONUS  = WS-BONUS-PERCENT * WS-SALARY / 100
                  WS-FINAL-SALARY = WS-SALARY + BONUS

                                                                                                                                                                                                                      
       2250-EXIT.                                                       
                EXIT.                                                   


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