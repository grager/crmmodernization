      *-----------------------------------------------------------------
      *    COBHDAT1 - SAMPLE COBOL PROGRAM TO DEMONSTRATE CICS CALLS
      *                                                                 
      *    FUNCTIONALITY - READS EMPLOYEE DATA FROM DATABASE. THIS PROGRAM    
      *                    FETCHS DETAILS OF TOP 10 EMPLOYEES WHO HAVE BEEN 
      *                    HIRED AFTER OR ON THE DATE ENETRED BY USER ON CICS SCREEN. 
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBHDAT1.                                          
       AUTHOR.       CAST SOFTWARE.                                      
       DATE-WRITTEN. OCT 2005.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                         
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
                                                                        
                                                                        
       01  PEMPNO                          PIC X(6).                    
       01  PEMPNAME                                                     
           05 PFIRSTNME.                                                
              49  PFIRSTNME-LEN            PIC S9(4) COMP.              
              49  PFIRSTNME-TEXT           PIC X(12).                   
           05 PMIDINIT                     PIC X(1).                    
           05 PLASTNAME.                                                
              49  PLASTNAME-LEN            PIC S9(4) COMP.              
              49  PLASTNAME-TEXT           PIC X(15).                   
       01  PWORKDEPT                       PIC X(4).                    
       01  PPHONENO                        PIC X(30).                   
       01  PHIREDATE                       PIC X(8).                    
       01  PBIRTHDATE                      PIC X(8).                    
       01  PJOB                            PIC X(8).                    
       01  PEDLEVEL                        PIC X(8).                    
       01  PSEX                            PIC X(1)                     
       01  PBONUS                          PIC X(1)                     
       01  PCOMM                           PIC X(1)                     
       01  PSALARY                         PIC S9(7)V9(2) COMP-3.       
       01  PSQLCODE                        PIC S9(9) COMP.              
       01  PSQLSTATE                       PIC X(5).                    
       01  PSQLERRMC.                                                   
           49  PSQLERRMC-LEN               PIC S9(4) COMP.              
           49  PSQLERRMC-TEXT              PIC X(250).                  
      
                                                                        
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       01  WS-WORKING-VARS.                                                 
               02  WS-EMPNO                PIC X(06).                     
               02  WS-EMPNAME              PIC X(36).                                                                        
               02  WS-HIREDATE             PIC X(8).                                                                        
               02  WS-EMP-HIREDATE         PIC X(8).                                                                        
               02  WS-COUNTER              PIC S9(2).       
               02  WS-FETCH-COUNT          PIC S9(2).       
               02  WS-TOTAL-EMPLOYEE       PIC S9(9) VALUE 10.
      *-----------------------------------------------------------------
      * VARIABLES FOR ERROR-HANDLING                                    
      *-----------------------------------------------------------------
       01  ERROR-MESSAGE.                                               
               02  ERROR-LEN   PIC S9(4)  COMP VALUE +960.              
               02  ERROR-TEXT  PIC X(80)  OCCURS 12 TIMES                
                                          INDEXED BY ERROR-INDEX.       
       77  ERROR-TEXT-LEN      PIC S9(9)  COMP VALUE +80.               
                                                                        
      /                                                                 
      *-----------------------------------------------------------------
      * SQLCA                                     
      *-----------------------------------------------------------------
           EXEC SQL                                                     
               INCLUDE SQLCA                                            
           END-EXEC.                                                    
                                                                        
      *-----------------------------------------------------------------
      * DCLGENS FOR TABLES                                    
      *-----------------------------------------------------------------
           EXEC SQL                                                     
               INCLUDE EMP                                              
           END-EXEC.                                                    
                                                                        
      *-----------------------------------------------------------------
      * DECLARE CURSOR FOR GETTING EMPLOYEE WHO HAVE BEEN HIRED ON  
      * OR AFTER THE GIVEN DATE.                                    
      *-----------------------------------------------------------------
           EXEC SQL
           
                 DECLARE EMPHDATE-CUR Cursor for

                  SELECT   
                      EMPNO
                    , CONCAT (FIRSTNME | ' ' | MIDINIT | ' ' | LASTNAME) AS EMPNAME
                    , HIREDATE                                            
                  INTO                                                  
                      :WS-EMPNO                                     
                    , :WS-EMPNAME                                         
                    , :WS-HIREDATE                                          
                  FROM 
                       EMP                                              
                  WHERE 
                       HIREDATE >= :WS-EMP-HIREDATE
                  ORDER BY 
                       HIREDATE
                  FETCH FIRST 10 RECORDS ONLY

           END-EXEC.


      /                                                                 
       LINKAGE SECTION.                                                 
                                                                        
       01  CASTMHDATEI          PIC X(8).                                   
       01  CASTMEMPDETAILSO     PIC X(45) OCCURS WS-TOTAL-EMPLOYEE TIMES.                                  
          03  CASTMEMPO         PIC X(6)                                   
          03  CASTMNAMEO        PIC X(30)                                  
          03  CASTMHDATEO       PIC X(8)                                  
          03  FILLER            PIC X(1)                                  
                                                                        
           EJECT                                                        

      *-----------------------------------------------------------------                                                                  
      * PROCEDURE DIVISION                                                                                                               
      *-----------------------------------------------------------------                                                                  
       PROCEDURE DIVISION USING CASTMHDATEI, CASTMEMPDETAILSO. 
                                                                        
              PERFORM 2000-EMPHDATE-OPEN-CURSOR.                      
                                                                        
              PERFORM 3000-FETCH-EMPLOYEE-RECORD 
                      VARYING WS-FETCH-COUNT FROM 1 BY 1 
                      UNTIL WS-FETCH-COUNT > WS-TOTAL-EMPLOYEE.       
              
              PERFORM 4000-EMPHDATE-CLOSE-CURSOR.                      
                                                                        
      *-----------------------------------------------------------------                                                                  
      * OPEN EMPLOYEE SALARY CURSOR                                                                               
      *-----------------------------------------------------------------                                                                  
       2000-EMPHDATE-OPEN-CURSOR.
       
           MOVE CASTMHDATEI          TO WS-EMP-HIREDATE.                           

           DISPLAY 'WS-EMP-HIREDATE = ' WS-EMP-HIREDATE.                         

           EXEC SQL 
               OPEN EMPHDATE-CUR 
           END-EXEC

           DISPLAY '++ SQLCODE AFTER OPEN CURSOR = ' SQLCODE.           

           MOVE SQLCODE  TO PSQLCODE.                              
           MOVE SQLSTATE TO PSQLSTATE.                             
           MOVE SQLERRMC TO PSQLERRMC.                             

           EVALUATE SQLCODE
           
             WHEN 0 
                 CONTINUE

             WHEN +100
                 DISPLAY '* FINISHED: END-OF-DATA'

             WHEN OTHER
             
                 DISPLAY  '* ABENDING: '
                 DISPLAY  '* SQLCODE:  ' SQLCODE
                 DISPLAY  ' ERROR OPEN EMPHDATE-CUR'
               

		 PERFORM VARYING WS-COUNTER 
			 FROM 1 BY 1 
			 UNTIL WS-COUNTER > WS-TOTAL-EMPLOYEE
			 
		   MOVE SPACES    TO CASTMEMPO(WS-COUNTER)
		   MOVE SPACES    TO CASTMNAMEO(WS-COUNTER)
		   MOVE SPACES    TO CASTMHDATEO(WS-COUNTER)
		   
		 END-PERFORM

		 PERFORM 9000-DBERROR THRU 9000-EXIT                           
                 
               
           END-EVALUATE
           
        EXIT.


      *-----------------------------------------------------------------                                                                  
      * READ EMPLOYEE RECORDS BY MAKING A CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       3000-FETCH-EMPLOYEE-RECORD.                                       
                                                                        
           	EXEC SQL 
           	   FETCH EMPHDATE-CUR INTO 
               	     :WS-EMPNO
                   , :WS-EMPNAME
                   , :WS-HIREDATE
           	END-EXEC
           	
                EVALUATE SQLCODE
           
                  WHEN 0 
 			 
		      MOVE WS-EMPNO       TO CASTMEMPO(WS-FETCH-COUNT)
		      MOVE WS-EMPNAME     TO CASTMNAMEO(WS-FETCH-COUNT)
		      MOVE WS-HIREDATE    TO CASTMHDATEO(WS-FETCH-COUNT)

                      CONTINUE

                  WHEN +100
                      DISPLAY '* FINISHED: END-OF-DATA'
    
                  WHEN OTHER
                  
                      DISPLAY  '* ABENDING: '
                      DISPLAY  '* SQLCODE:  ' SQLCODE
                      DISPLAY  ' ERROR FETCHING EMPHDATE-CUR'
               
 			 
		      MOVE SPACES    TO CASTMEMPO(WS-FETCH-COUNT)
		      MOVE SPACES    TO CASTMNAMEO(WS-FETCH-COUNT)
		      MOVE SPACES    TO CASTMHDATEO(WS-FETCH-COUNT)

		      PERFORM 9000-DBERROR THRU 9000-EXIT                           
                 
                END-EVALUATE

        EXIT.
           
                
      *-----------------------------------------------------------------                                                                  
      * CLOSE EMPLOYEE SALARY CURSOR                                                                               
      *-----------------------------------------------------------------                                                                  
       4000-EMPHDATE-CLOSE-CURSOR.
       
           EXEC SQL 
               CLOSE EMPHDATE-CUR 
           END-EXEC

           DISPLAY '++ SQLCODE AFTER CLOSE CURSOR = ' SQLCODE.           

           MOVE SQLCODE  TO PSQLCODE.                              
           MOVE SQLSTATE TO PSQLSTATE.                             
           MOVE SQLERRMC TO PSQLERRMC.                             

           EVALUATE SQLCODE
           
             WHEN 0 
                 CONTINUE

             WHEN +100
                 DISPLAY '* FINISHED: END-OF-DATA'

             WHEN OTHER
             
                 DISPLAY  '* ABENDING: '
                 DISPLAY  '* SQLCODE:  ' SQLCODE
                 DISPLAY  ' ERROR CLOSE EMPHDATE-CUR'
               
		 PERFORM 9000-DBERROR THRU 9000-EXIT                           
                 
               
           END-EVALUATE
           
        EXIT.

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
       9000-EXIT.                                                       
                EXIT.
      *-----------------------------------------------------------------
      * 9999-ERROR-DISPLAY                                              
      *-----------------------------------------------------------------
       9999-ERROR-DISPLAY.                                              
                DISPLAY ERROR-TEXT (ERROR-INDEX).                       
       9999-EXIT.                                                       
                EXIT.                                                   
                                                                        