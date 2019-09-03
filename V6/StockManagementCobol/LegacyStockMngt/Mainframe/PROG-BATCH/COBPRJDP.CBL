      *-----------------------------------------------------------------
      *    COBPRJDP - SAMPLE COBOL PROGRAM TO DEMONSTRATE CICS CALLS
      *                                                                 
      *    FUNCTIONALITY - READS PROJECT DATA FROM DATABASE AND    
      *                    SENDS TO CICS CALLING PROGRAM. THE COBOL 
      *                    PROGRAM ALSO UPDATES DATABASE WITH THE   
      *                    PROJECT  DATA IF REQUESTED BY THE CALLING
      *                    CICS PROGRAM.                            
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBPRJDP.                                          
       AUTHOR.       CAST SOFTWARE.                                      
       DATE-WRITTEN. OCT  2005.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                         
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
                                                                        
                                                                        
       01  ADD-PRJ-FLAG         PIC X VALUE SPACES.          
                                                                        
       01 PROJ-NO		PIC X(6).
       01 PROJ-NAME		PIC X(24).
       01 DEPTNO		PIC X(3).
       01 PROJ-EMP		PIC X(6).
       01 PROJ-STAFF		PIC S9(5).
       01 PROJ-STARTDATE	PIC X(8).
       01 PROJ-ENDDATE	    	PIC X(8).
       01 CTRLPROJ		PIC X(6).
       01  PSQLCODE             PIC S9(9) COMP.              
       01  PSQLSTATE            PIC X(5).                    
       01  PSQLERRMC.                                        
           49  PSQLERRMC-LEN    PIC S9(4) COMP.              
           49  PSQLERRMC-TEXT   PIC X(250).                  
      
                                                                        
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       01  WS-PARMAREA.                                                 
               02  WS-PRJNO                PIC X(06).                     
                                                                        
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
               INCLUDE PROJECT                                            
           END-EXEC.                                                    
                                                                        
      /                                                                 
       LINKAGE SECTION.                                                 

       01  CASTMPRJI         PIC X(6)                                   
       01  CASTMDEPO         PIC X(4)                                   
       01  CASTMNAMEO        PIC X(30)                                  
       01  CASTMEMPO         PIC X(8)                                   
       01  CASTMSDATEO       PIC X(8)                                   
       01  CASTMEDATEO       PIC X(8)                                   
       01  ADD-PRJ-FLAG      PIC X(1)                                   
                                                                        
           EJECT                                                        

      *-----------------------------------------------------------------                                                                  
      * PROCEDURE DIVISION                                                                                                               
      *-----------------------------------------------------------------                                                                  
       PROCEDURE DIVISION USING CASTMPRJI, CASTMDEPO, CASTMNAMEO, 
                                CASTMEMPO, CASTMSDATEO,CASTMEDATEO, ADD-PRJ-FLAG. 
                                                                        
            IF ADD-PRJ-FLAG = "Y"                                       
                 PERFORM 4000-READ-PROJECT-DETAILS                    
            ELSE                                                        
                 PERFORM 5000-UPDATE-PROJECT-DETAILS                    
            END-IF.                                                     
                                                                        
      *-----------------------------------------------------------------                                                                  
      * READ EMPLOYEE RECORDS BY MAKING A CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       4000-READ-PROJECT-DETAILS.                                       
                                                                        
                MOVE SPACES      TO ADD-PRJ-FLAG.                       
                MOVE CASTMPRJI   TO WS-PRJNO.                           
                                                                        
                DISPLAY 'WS-PRJNO = ' WS-PRJNO.                         
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      PROJ_NAME	                                       
                    , DEPTNO		                                       
                    , PROJ_EMP	                                       
                    , PROJ_STAFF	                                       
                    , PROJ_STARTDATE	                                       
                    , PROJ_ENDDATE	                                       
                  INTO          
                      :PROJ-NAME                                        
                    , :DEPTNO		                                   
                    , :PROJ-EMP	                                       
                    , :PROJ-STAFF	                                   
                    , :PROJ-STARTDATE                                   
                    , :PROJ-ENDDATE                                   
                  FROM PROJECT                                              
                  WHERE PROJ_NO = :WS-PRJNO                               
                END-EXEC.                                               
                                                                        
                DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.           
                                                                        
                MOVE SQLCODE  TO PSQLCODE.                              
                MOVE SQLSTATE TO PSQLSTATE.                             
                MOVE SQLERRMC TO PSQLERRMC.                             
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                
                         MOVE SPACES     TO PROJ-NAME                                        
                                            DEPTNO		                                   
                                            PROJ-EMP	                                       
                                            PROJ-STAFF	                                   
                                            PROJ-STARTDATE                                   
                                            PROJ-ENDDATE                                   
                                            
                         PERFORM 9000-DBERROR THRU 9000-EXIT                           
                END-EVALUATE.                                           
                                                                        
		MOVE PROJ-NAME           TO CASTMNAMEO.                            
		MOVE DEPTNO	         TO CASTMDEPO.                             
		MOVE PROJ-EMP	         TO CASTMEMPO.                                
		MOVE PROJ-STARTDATE      TO CASTMSDATEO.                          
		MOVE PROJ-ENDDATE        TO CASTMEDATEO.                        
                                                                        
      *-----------------------------------------------------------------                                                                  
      * UPDATE PROJECTS RECORDS BY MAKING CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       5000-UPDATE-PROJECT-DETAILS.                                     
                                                                        
           MOVE CASTMPRJI TO WS-PRJNO.                                
                                                                        
           DISPLAY 'WS-PRJNO = ' WS-PRJNO.                              
                                                                        
           EXEC SQL                                                     
             SELECT                                                     
                 PROJ_NO                                                 
             INTO                                                       
                :PROJ-NO                                                
             FROM 
                 PROJECT                                                   
             WHERE 
                  PROJ_NO = :WS-PRJNO                                    
           END-EXEC.                                                    
                                                                        
           DISPLAY '++ SQLCODE AFTER SELECT = ' SQLCODE.                
                                                                        
           MOVE SQLCODE  TO PSQLCODE.                                   
           MOVE SQLSTATE TO PSQLSTATE.                                  
           MOVE SQLERRMC TO PSQLERRMC.                                  
                                                                        
           EVALUATE SQLCODE                                             
               WHEN 0                                                   
                    CONTINUE                                            
                    MOVE "Y"        TO ADD-PRJ-FLAG                     
               WHEN OTHER                                               
                    PERFORM 9000-DBERROR THRU 9000-EXIT                 
           END-EVALUATE.                                                 
                                                                        
           MOVE CASTMPRJI            TO PROJ-NO.                          
           MOVE CASTMDEPO            TO DEPTNO.                       
           MOVE CASTMNAMEO           TO PROJ-NAME.                        
           MOVE CASTMEMPO            TO PROJ-EMP.                            
           MOVE CASTMSDATEO          TO PROJ-STARTDATE.  
           MOVE CASTMEDATEO          TO PROJ-ENDDATE. 
                                                                        
           IF  ADD-PRJ-FLAG = "Y"  THEN                                 
               EXEC SQL                                                 
                       INSERT INTO                                      
                          PROJECT                                  
                          (                                             
                            PROJ_NO		
                          , PROJ_NAME	
                          , DEPTNO		
                          , PROJ_EMP	
                          , PROJ_STARTDATE	
                          , PROJ_ENDDATE	
                          )                                             
                           VALUES                                       
                          (  
                            :PROJ-NO       
                          , :PROJ-NAME     
                          , :DEPTNO        
                          , :PROJ-EMP      
                          , :PROJ-STARTDATE
                          , :PROJ-ENDDATE 
                          )                                             
               END-EXEC                                                 
               MOVE SQLCODE  TO PSQLCODE                               
               MOVE SQLSTATE TO PSQLSTATE                              
               MOVE SQLERRMC TO PSQLERRMC                              
                                                                        
               EVALUATE SQLCODE                                         
                   WHEN 0                                               
                        CONTINUE                                        
                        MOVE SPACES TO ADD-PRJ-FLAG                     
                   WHEN OTHER                                           
                        PERFORM 9000-DBERROR THRU 9000-EXIT                            
               END-EVALUATE                                             
                                                                        
           ELSE                                                         
                                                                        
               EXEC SQL                                                 
                       UPDATE                                           
                           PROJECT                                 
                       SET  PROJ_NO	   = :PROJ-NO       
                          , PROJ_NAME      = :PROJ-NAME     
                          , DEPTNO         = :DEPTNO        
                          , PROJ_EMP       = :PROJ-EMP      
                          , PROJ_STARTDATE = :PROJ-STARTDATE
                          , PROJ_ENDDATE   = :PROJ-ENDDATE
                       WHERE                                            
                          (                                             
                            ( EMP.PROJ_NO = :WS-PRJNO )          
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
                                                                        