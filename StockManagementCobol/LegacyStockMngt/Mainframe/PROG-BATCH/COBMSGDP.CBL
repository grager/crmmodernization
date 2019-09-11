      *-----------------------------------------------------------------
      *    COBMSGDP - SAMPLE COBOL PROGRAM TO GET MESSAGES FOR EMPLOYEE
      *                                                                 
      *    FUNCTIONALITY - GET   EMPLOYEE NUMBER FROM INPUT PARM.                    
      *                    FETCHES EMPLOYEE MESSAGES FROM DATABASES 
      *                    SORTED BY RECEIVED DATE.                           
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBMSGDP.                                          
       AUTHOR.       CAST SOFTWARE.                                      
       DATE-WRITTEN. OCTOBER 2005.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                         
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
                                                                        
                                                                        
       01  PEMPNO                          PIC X(6)                                   
       01  PRCVD                           PIC X(10)                                   
       01  PSRC                            PIC X(8)                                  
       01  PSUB                            PIC X(64)                                   
       01  PNOTE                           PIC X(3000)                                   
       01  PSQLCODE                        PIC S9(9) COMP.              
       01  PSQLSTATE                       PIC X(5).                    
       01  PSQLERRMC.                                                   
           49  PSQLERRMC-LEN               PIC S9(4) COMP.              
           49  PSQLERRMC-TEXT              PIC X(250).                  
      
                                                                        
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       01  WS-PARMAREA.                                                 
               02  WS-EMPNO                PIC X(06).                     
                                                                        
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
      * SQLCA AND DCLGENS FOR TABLES                                    
      *-----------------------------------------------------------------
           EXEC SQL                                                     
               INCLUDE SQLCA                                            
           END-EXEC.                                                    
                                                                        
           EXEC SQL                                                     
               INCLUDE EMP                                              
           END-EXEC.                                                    

	   COPY MSGINTRY                                                                        
      /                                                                 
       LINKAGE SECTION.                                                 
                                                                        
       01  MSGMEMPI         PIC X(6)                                   
       01  MSGMRCVDO        PIC X(10)                                   
       01  MSGMSRCO         PIC X(8)                                  
       01  MSGMSUBO         PIC X(64)                                   
       01  MSGMNOTEO        PIC X(3000).                                   
                                                                        
           EJECT                                                        

      *-----------------------------------------------------------------                                                                  
      * PROCEDURE DIVISION                                                                                                               
      *-----------------------------------------------------------------                                                                  
       PROCEDURE DIVISION USING MSGMEMPI, MSGMRCVDO, MSGMSRCO, 
                                MSGMSUBO, MSGMNOTEO. 
                                                                        
            PERFORM 4000-READ-EMPLOYEE-MESSAGES.
                                                                        
      *-----------------------------------------------------------------                                                                  
      * READ EMPLOYEE MESSAGES FROM DB2 DATABASE.                                                                              
      *-----------------------------------------------------------------                                                                  
       4000-READ-EMPLOYEE-MESSAGES.                                       
                                                                        
                MOVE MSGMEMPI    TO PEMPNO.                           
                MOVE PEMPNO      TO WS-EMPNO.                           
                                                                        
                DISPLAY 'WS-EMPNO = ' WS-EMPNO.                         
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      RECEIVED
                    , SOURCE                                          
                    , SUBJECT                                         
                    , NOTE_TEXT                                         
                  INTO                                                  
                      :RECEIVED                                        
                    , :SOURCE                                        
                    , :SUBJECT                                       
                    , :NOTE-TEXT                                          
                  FROM MSG_IN_TRAY                                              
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
                         MOVE SPACES     TO PEMPNO                      
                                            PRCVD                   
                                            PSRC                   
                                            PSUB                    
                                            PNOTE                   
                         PERFORM 9000-DBERROR THRU 9000-EXIT                           
                END-EVALUATE.                                           
                                                                        
                MOVE PRCVD               TO MSGMRCVDO                    
                MOVE PSRC                TO MSGMSRCO                     
                MOVE PSUB                TO MSGMSUBO                     
                MOVE PNOTE               TO MSGMNOTEO.                    
                                                                        
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
                                                                        