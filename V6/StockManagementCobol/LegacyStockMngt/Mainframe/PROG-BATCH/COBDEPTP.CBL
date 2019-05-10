      *-----------------------------------------------------------------
      *    COBDEPTP - SAMPLE COBOL PROGRAM TO DEMONSTRATE CICS CALLS
      *                                                                 
      *    FUNCTIONALITY - READS DEPARTMENT DATA FROM DATABASE AND 
      *                    SENDS TO CICS CALLING PROGRAM. THE COBOL 
      *                    PROGRAM ALSO UPDATES DEPARTMENT DATA IN  
      *                    THE DATABASE IF USER UPDATES IT AND SAVES
      *                    FROM THE CICS SCREEN.                    
      *                    THIS PROGRAM CAN BE CALLED BY ANY OTHER 
      *                    PROGRAM AND CAN ACCESS DEPARTMENT DATA
      *                    USING THE LINKAGE AREA SHARING OF DATA.
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF HR_DB APPLICATION----------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBDEPTP.                                          
       AUTHOR.       CAST SOFTWARE.                                      
       DATE-WRITTEN. OCT  2005.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                         
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
                                                                        
       01 PDEPTNO		PIC X(3).
       01 PDEPTNAME		PIC X(36).
       01 PMGRNO                PIC X(6).
       01 PADMRDEPT		PIC X(3).
       01 PLOCATION		PIC X(16).
       01 PSQLCODE              PIC S9(9) COMP.              
       01 PSQLSTATE             PIC X(5).                    
       01 PSQLERRMC.                                        
           49  PSQLERRMC-LEN    PIC S9(4) COMP.              
           49  PSQLERRMC-TEXT   PIC X(250).                  



      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       01  WS-PARMAREA.                                                 
               02  WS-DEPTNO                PIC X(06).                     
                                                                        
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
               INCLUDE DEPT                                            
           END-EXEC.                                                    
                     
      /                                                                 
       LINKAGE SECTION.                                                 

       01  DEPTNOI           PIC X(3)                                   
       01  DEPTNAMEO         PIC X(36)                                   
       01  MGRNOO            PIC X(6)                                  
       01  ADMRDEPTO         PIC X(3)                                   
       01  LOCATIONO         PIC X(16)                                   
       01  ADD-DEPT-FLAG     PIC X(1)                                   
                                                                        
           EJECT                                                        

      *-----------------------------------------------------------------                                                                  
      * PROCEDURE DIVISION                                                                                                               
      *-----------------------------------------------------------------                                                                  
       PROCEDURE DIVISION USING DEPTNOI, DEPTNAMEO, MGRNOO, 
                                ADMRDEPTO, LOCATIONO, ADD-DEPT-FLAG. 
                                                                        
            IF ADD-DEPT-FLAG = "Y"                                       
                 PERFORM 4000-READ-DEPARTMENT-DETAILS                    
            ELSE                                                        
                 PERFORM 5000-UPDATE-DEPARTMENT-DETAILS                    
            END-IF.                                                     
                                                                        
      *-----------------------------------------------------------------                                                                  
      * READ EMPLOYEE RECORDS BY MAKING A CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       4000-READ-DEPARTMENT-DETAILS.                                       
                                                                        
                MOVE SPACES       TO ADD-DEPT-FLAG.                       
                MOVE DEPTNOI      TO PDEPTNO.                             
                MOVE PDEPTNO      TO WS-DEPTNO.                           
                                                                        
                DISPLAY 'WS-DEPTNO = ' WS-DEPTNO.                         
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      DEPTNO	
                    , DEPTNAME		                                       
                    , MGRNO		                                       
                    , ADMRDEPT	                                       
                    , LOCATION	                                       
                  INTO          
                      :DEPTNO
                    , :DEPTNAME		                                   
                    , :MGRNO	                                       
                    , :ADMEDEPT	                                   
                    , :LOCATION                                         
                  FROM DEPT                                                 
                  WHERE DEPTNO  = :WS-DEPTNO                              
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.           
                                                                        
                MOVE SQLCODE  TO PSQLCODE.                              
                MOVE SQLSTATE TO PSQLSTATE.                             
                MOVE SQLERRMC TO PSQLERRMC.                             
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                
                         MOVE SPACES     TO DEPTNO                                       
                                            DEPTNAME	                                   
                                            MGRNO   	                                       
                                            ADMRDEPT  	                                   
                                            LOCATION                                         
                                            
                         PERFORM 9000-DBERROR THRU 9000-EXIT                           
                END-EVALUATE.                                           
                                                                        
		MOVE DEPTNO              TO DEPTNOI                            
		MOVE DEPTNAME            TO DEPTNAMEO.                             
		MOVE MGRNO   	         TO MGRNOO.                                
		MOVE ADMRDEPT            TO ADMRDEPTO.                          
		MOVE LOCATION            TO LOCATIONO.                        
                                                                        
      *-----------------------------------------------------------------                                                                  
      * UPDATE PROJECTS RECORDS BY MAKING CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       5000-UPDATE-DEPARTMENT-DETAILS.                                     
                                                                        
           MOVE DEPTNOI   TO PDEPTNO.                                    
           MOVE PDEPTNO   TO WS-DEPTNO.                                
                                                                        
           DISPLAY 'WS-DEPTNO = ' WS-DEPTNO.                              
                                                                        
           EXEC SQL                                                     
             SELECT                                                     
                 DEPTNO                                                 
             INTO                                                       
                :DEPTNO                                                
             FROM 
                 DEPT                                                   
             WHERE 
                  DEPTNO = :WS-DEPTNO                                    
           END-EXEC.                                                    
                                                                        
           DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.                
                                                                        
           MOVE SQLCODE  TO PSQLCODE.                                   
           MOVE SQLSTATE TO PSQLSTATE.                                  
           MOVE SQLERRMC TO PSQLERRMC.                                  
                                                                        
           EVALUATE SQLCODE                                             
               WHEN 0                                                   
                    CONTINUE                                            
                    MOVE "Y"        TO ADD-DEPT-FLAG                     
               WHEN OTHER                                               
                    PERFORM 9000-DBERROR THRU 9000-EXIT                 
           END-EVALUATE.                                                 
                                                                        

           MOVE DEPTNOI              TO DEPTNO.                          
           MOVE DEPTNAMEO            TO DEPTNAME.                       
           MOVE MGRNOO               TO MGRNO.                        
           MOVE ADMRDEPTO            TO ADMRDEPT.                            
           MOVE LOCATIONO            TO LOCATION.  
                                                                        
           IF  ADD-DEPT-FLAG = "Y"  THEN                                 
               EXEC SQL                                                 
                       INSERT INTO                                      
                          DEPT                                  
                          (                                             
                            DEPTNO		
                          , DEPTNAME	
                          , MGRNO		
                          , ADMRDEPT	
                          , PLOCATION	
                          )                                             
                           VALUES                                       
                          (  
                            :DEPTNO       
                          , :DEPTNAME     
                          , :MGRNO       
                          , :ADMRDEPT     
                          , :LOCATION
                          )                                             
               END-EXEC                                                 
               MOVE SQLCODE  TO PSQLCODE                               
               MOVE SQLSTATE TO PSQLSTATE                              
               MOVE SQLERRMC TO PSQLERRMC                              
                                                                        
               EVALUATE SQLCODE                                         
                   WHEN 0                                               
                        CONTINUE                                        
                        MOVE SPACES TO ADD-DEPT-FLAG                     
                   WHEN OTHER                                           
                        PERFORM 9000-DBERROR THRU 9000-EXIT                            
               END-EVALUATE                                             
                                                                        
           ELSE                                                         
                                                                        
               EXEC SQL                                                 
                       UPDATE                                           
                           DEPT                                 
                       SET  DEPTNAME       = :DEPTNAME     
                          , MGRNO          = :MGRNO        
                          , ADMRDEPT       = :ADMRDEPT     
                          , LOCATION       = :LOCATION
                       WHERE                                            
                          (                                             
                            ( EMP.DEPTNO   = :DEPTNO )          
                          )                                             
               END-EXEC                                                 
                                                                        
               EVALUATE SQLCODE                                         
                   WHEN 0                                               
                        CONTINUE                                        
                   WHEN OTHER                                           
                        PERFORM 9000-DBERROR THRU 9000-EXIT             
               END-EVALUATE                                            
                                                                        
           END-IF.                                                      
                                                                        
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
                                                                        