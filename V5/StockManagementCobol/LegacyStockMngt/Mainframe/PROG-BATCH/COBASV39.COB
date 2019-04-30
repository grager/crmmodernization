      *-----------------------------------------------------------------
      *     COBASV39 - THIS PROGRAM ACCEPTS PROJECT NAME AND PRINTS PROJECT
      *                DETAILS HAVING PROJECT NAME AS GIVEN SAME AS INPUT PROJECT.
      *
      *		 FOR VIOLATION OF USING RAW SQL QUERY
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV39.                                         
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
                VALUE 'PROJECT ACTIVITY DETAILS'         
           10 FILLER              PIC X(46)
           
       01  WS-RPT-COLUMNS.
           10 FILLER              PIC X(23).
           10 WS-COL1             PIC X(6)   VALUE 'PROJNO'.
           10 FILLER              PIC X(2).
           10 WS-COL2             PIC X(24)  VALUE 'NAME'.
           10 FILLER              PIC X(2).
           10 WS-COL3             PIC X(4)   VALUE 'PROJDEPT'.
           10 FILLER              PIC X(2).
           10 WS-COL4             PIC X(10)  VALUE 'ACTSTARTDATE'.
           10 FILLER              PIC X(2).
           10 WS-COL5             PIC X(10)  VALUE 'ACTENDDATE'.
           10 FILLER              PIC X(2).
           10 WS-COL6             PIC X(12)  VALUE 'PROJ STAFF'.
           10 FILLER              PIC X(23).
           
       01  WS-RPT-DETAIL.
           10 FILLER              PIC X(23).
           10 WS-PROJ-NO          PIC X(6).
           10 FILLER              PIC X(2).
           10 WS-PROJ-NAME        PIC X(24).
           10 FILLER              PIC X(4).
           10 WS-DEPTNO           PIC X(3).
           10 FILLER              PIC X(3).
           10 WS-ACT-STARTDATE	  PIC X(10).
           10 FILLER              PIC X(4).
           10 WS-ACT-ENDDATE	  PIC X(10).
           10 FILLER              PIC X(4).
           10 WS-PROJ-STAFF       PIC S9(3)V9(2). 
           10 FILLER              PIC X(25).
           
       01  WS-MISCELLENEOUS.
           10 WS-COUNT		  PIC S9(6).
           10 WS-ACT-NO           PIC X(6).
           10 WS-ACT-DESC         PIC X(20).
           10 WS-ACT-KEYWORD      PIC X(6).
           10 WS-ACT-STAFF        PIC S9(3)V9(2) USAGE COMP-3.
           10 WS-ACT-ENDDATE	  PIC X(10).
           10 WS-PROJ-EMP         PIC X(6). 
           10 WS-PROJ-STAFF       PIC S9(3)V9(2) USAGE COMP-3. 
           10 WS-CTRLPROJ         PIC X(06).
           10 WS-PROJ-STARTDATE	  PIC X(10).
           10 WS-PROJ-ENDDATE	  PIC X(10).
                                                                        
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
                                                                        
      *-------------------------------*
      *            CURSOR C1          *
      *-------------------------------*
               EXEC SQL DECLARE C1 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_NAME 
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               
                                                                        
      *-------------------------------*
      *            CURSOR C2          *
      *-------------------------------*
               EXEC SQL DECLARE C2 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , ACTIVITY.ACT_KEYWORD
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C3          *
      *-------------------------------*
               EXEC SQL DECLARE C3 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , ACTIVITY.ACT_DESC
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C4          *
      *-------------------------------*
               EXEC SQL DECLARE C4 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PACTIVITY.ACT_NO
                        , PACTIVITY.ACT_STAFF
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C5          *
      *-------------------------------*
               EXEC SQL DECLARE C5 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PACTIVITY.ACT_NO
                        , PACTIVITY.ACT_STARTDATE
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C6          *
      *-------------------------------*
               EXEC SQL DECLARE C6 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PACTIVITY.ACT_NO
                        , PACTIVITY.ACT_ENDDATE
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C7          *
      *-------------------------------*
               EXEC SQL DECLARE C7 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.DEPTNO
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C8          *
      *-------------------------------*
               EXEC SQL DECLARE C8 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_EMP
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C9          *
      *-------------------------------*
               EXEC SQL DECLARE C9 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_STAFF
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C10         *
      *-------------------------------*
               EXEC SQL DECLARE C10 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_STARTDATE
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C11         *
      *-------------------------------*
               EXEC SQL DECLARE C11 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_ENDDATE  
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C12         *
      *-------------------------------*
               EXEC SQL DECLARE C12 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.CTRLPROJ 
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C13         *
      *-------------------------------*
               EXEC SQL DECLARE C13 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_STARTDATE
                        , PROJECT.PROJ_ENDDATE
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C14         *
      *-------------------------------*
               EXEC SQL DECLARE C14 CURSOR                                
                     SELECT 
                          PROJECT.PROJ_NO
                        , PROJECT.PROJ_EMP
                        , PROJECT.DEPTNO 
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C15         *
      *-------------------------------*
               EXEC SQL DECLARE C15 CURSOR                                
                     SELECT 
                          Count(PROJECT.PROJ_NO) 
                     FROM 
                          ACTIVITY
                        , PACTIVITY
                        , PROJECT 
                     WHERE 
                          ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND (PROJECT.PROJ_NAME LIKE :PROJNAME)
                END-EXEC.                                               


      /                                                                 
       LINKAGE SECTION.                                                 
       01  PROJNAME         PIC X(9).
       
       PROCEDURE DIVISION USING PSALARY.                                                                                                                 
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
                                                                                                                                                                                                                      
                EXEC SQL                                                
                  OPEN  C2                                              
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

                EXEC SQL                                                
                  OPEN  C3                                              
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

                EXEC SQL                                                
                  OPEN  C4                                              
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

                EXEC SQL                                                
                  OPEN  C5                                              
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

                EXEC SQL                                                
                  OPEN  C6                                              
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

                EXEC SQL                                                
                  OPEN  C7                                              
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

                EXEC SQL                                                
                  OPEN  C8                                              
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

                EXEC SQL                                                
                  OPEN  C9                                              
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

                EXEC SQL                                                
                  OPEN  C10                                              
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

                EXEC SQL                                                
                  OPEN  C11                                              
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

                EXEC SQL                                                
                  OPEN  C12                                              
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

                EXEC SQL                                                
                  OPEN  C13                                              
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

                EXEC SQL                                                
                  OPEN  C14                                              
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

                EXEC SQL                                                
                  OPEN  C15                                              
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

      *-------------------------------*
      *            FETCH C1           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C1                                            
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-NAME
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

      *-------------------------------*
      *            FETCH C2           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C2
                    INTO  :WS-PROJ-NO
                        , :WS-ACT-KEYWORD
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
                                                                                                                                                                                                                                                                                              

      *-------------------------------*
      *            FETCH C3           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C3
                    INTO  :WS-PROJ-NO
                        , :WS-ACT-DESC
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

      *-------------------------------*
      *            FETCH C4           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C4
                    INTO  :WS-PROJ-NO
                        , :WS-ACT-NO
                        , :WS-ACT-STAFF
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
      *-------------------------------*
      *            FETCH C5           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C5
                    INTO  :WS-PROJ-NO
                        , :WS-ACT-NO
                        , :WS-ACT-STARTDATE
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
      *-------------------------------*
      *            FETCH C6           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C6
                    INTO  :WS-PROJ-NO
                        , :WS-ACT-NO
                        , :WS-ACT-ENDDATE
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
      *-------------------------------*
      *            FETCH C7           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C7
                    INTO  :WS-PROJ-NO
                        , :WS-DEPTNO
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
      *-------------------------------*
      *            FETCH C8           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C8
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-EMP
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
      *-------------------------------*
      *            FETCH C9           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C9
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-STAFF
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
      *-------------------------------*
      *            FETCH C10          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C10
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-STARTDATE
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
      *-------------------------------*
      *            FETCH C11          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C11
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-ENDDATE
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
      *-------------------------------*
      *            FETCH C12          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C12
                    INTO  :WS-PROJ-NO
                        , :WS-CTRLPROJ
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
      *-------------------------------*
      *            FETCH C13          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C13
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-STARTDATE
                        , :WS-PROJ-ENDDATE
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
      *-------------------------------*
      *            FETCH C14          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C14
                    INTO  :WS-PROJ-NO
                        , :WS-PROJ-EMP
                        , :WS-DEPTNO
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
      *-------------------------------*
      *            FETCH C15          *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C15
                    INTO  :WS-COUNT
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
                                                                                                                                                                                                                      
                EXEC SQL                                                
                  CLOSE  C2                                              
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

                EXEC SQL                                                
                  CLOSE  C3                                              
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

                EXEC SQL                                                
                  CLOSE  C4                                              
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

                EXEC SQL                                                
                  CLOSE  C5                                              
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

                EXEC SQL                                                
                  CLOSE  C6                                              
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

                EXEC SQL                                                
                  CLOSE  C7                                              
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

                EXEC SQL                                                
                  CLOSE  C8                                              
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

                EXEC SQL                                                
                  CLOSE  C9                                              
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

                EXEC SQL                                                
                  CLOSE  C10                                              
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

                EXEC SQL                                                
                  CLOSE  C11                                              
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

                EXEC SQL                                                
                  CLOSE  C12                                              
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

                EXEC SQL                                                
                  CLOSE  C13                                              
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

                EXEC SQL                                                
                  CLOSE  C14                                              
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

                EXEC SQL                                                
                  CLOSE  C15                                              
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