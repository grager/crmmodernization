      *-----------------------------------------------------------------
      *     COBASV38 - THIS PROGRAM ACCEPTS EMP NAME AND PRINTS EMPLOYEE 
      *                DETAILS HAVING EMP NAME AS GIVEN SAME AS INPUT EMPLOYEE.
      *
      *		 FOR VIOLATION OF HIGH FAN OUT
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV38.                                         
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
                VALUE 'EMPLOYEES NAMES SIMILAR TO INPUT NAME'         
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
           10 WS-PHONE            PIC X(04).
           10 WS-COUNT            PIC S9(6).
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
                                                                        
      *-------------------------------*
      *            CURSOR C1          *
      *-------------------------------*
               EXEC SQL DECLARE C1 CURSOR                                
		     SELECT 
		          Count(EMP.EMPNO) AS EMPCOUNT 
                     FROM 
                          EMP
                        , EMP_PHOTO
                        , PROJECT PROJECT_1
                        , PACTIVITY
                        , PROJECT
                        , DEPT
                        , EMP_PROJ_ACT
                        , EMP_RESUME
                        , MSG_IN_TRAY
                        , ACTIVITY
                        , DEPT DEPT_1
                        , ACTIVITY ACTIVITY_1
                        , EMP EMP_1
                        , EMP_PHOTO EMP_PHOTO_1
                        , MSG_IN_TRAY MSG_IN_TRAY_1   
                     WHERE 
                          EMP.EMPNO = EMP_PHOTO.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PROJ_ACT.EMPNO 
                      AND PROJECT_1.PROJ_NO = PACTIVITY.PROJ_NO
                      AND PROJECT_1.PROJ_NO = PROJECT.CTRLPROJ 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND PROJECT_1.DEPTNO = DEPT.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT.DEPTNO   
                      AND PACTIVITY.PROJ_NO = EMP_PROJ_ACT.PROJ_NO 
                      AND PACTIVITY.ACT_NO = EMP_PROJ_ACT.ACT_NO 
                      AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
                      AND EMP_PHOTO.EMPNO = EMP_RESUME.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY.EMPNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY.ACT_NO   
                      AND PROJECT_1.DEPTNO = DEPT_1.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT_1.DEPTNO   
                      AND DEPT.MGRNO = DEPT_1.DEPTNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY_1.ACT_NO 
                      AND EMP_PHOTO.EMPNO = EMP_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PHOTO_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY_1.EMPNO 
                      AND EMP.FIRSTNAME = empName;
                END-EXEC.                                               
                                                                        
      *-------------------------------*
      *            CURSOR C2          *
      *-------------------------------*
                EXEC SQL DECLARE C2 CURSOR                                
		     SELECT 
		          EMP.EMPNO
                     FROM 
                          EMP
                        , EMP_PHOTO
                        , PROJECT PROJECT_1
                        , PACTIVITY
                        , PROJECT
                        , DEPT
                        , EMP_PROJ_ACT
                        , EMP_RESUME
                        , MSG_IN_TRAY
                        , ACTIVITY
                        , DEPT DEPT_1
                        , ACTIVITY ACTIVITY_1
                        , EMP EMP_1
                        , EMP_PHOTO EMP_PHOTO_1
                        , MSG_IN_TRAY MSG_IN_TRAY_1   
                     WHERE 
                          EMP.EMPNO = EMP_PHOTO.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PROJ_ACT.EMPNO 
                      AND PROJECT_1.PROJ_NO = PACTIVITY.PROJ_NO
                      AND PROJECT_1.PROJ_NO = PROJECT.CTRLPROJ 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND PROJECT_1.DEPTNO = DEPT.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT.DEPTNO   
                      AND PACTIVITY.PROJ_NO = EMP_PROJ_ACT.PROJ_NO 
                      AND PACTIVITY.ACT_NO = EMP_PROJ_ACT.ACT_NO 
                      AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
                      AND EMP_PHOTO.EMPNO = EMP_RESUME.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY.EMPNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY.ACT_NO   
                      AND PROJECT_1.DEPTNO = DEPT_1.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT_1.DEPTNO   
                      AND DEPT.MGRNO = DEPT_1.DEPTNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY_1.ACT_NO 
                      AND EMP_PHOTO.EMPNO = EMP_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PHOTO_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY_1.EMPNO 
                      AND EMP.FIRSTNAME = empName;
                END-EXEC.                                               

      *-------------------------------*
      *            CURSOR C3          *
      *-------------------------------*
                EXEC SQL DECLARE C3 CURSOR                                
		     SELECT 
		          EMP.FIRSTNAME
		        , EMP.LASTNAME
                     FROM 
                          EMP
                        , EMP_PHOTO
                        , PROJECT PROJECT_1
                        , PACTIVITY
                        , PROJECT
                        , DEPT
                        , EMP_PROJ_ACT
                        , EMP_RESUME
                        , MSG_IN_TRAY
                        , ACTIVITY
                        , DEPT DEPT_1
                        , ACTIVITY ACTIVITY_1
                        , EMP EMP_1
                        , EMP_PHOTO EMP_PHOTO_1
                        , MSG_IN_TRAY MSG_IN_TRAY_1   
                     WHERE 
                          EMP.EMPNO = EMP_PHOTO.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PROJ_ACT.EMPNO 
                      AND PROJECT_1.PROJ_NO = PACTIVITY.PROJ_NO
                      AND PROJECT_1.PROJ_NO = PROJECT.CTRLPROJ 
                      AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
                      AND PROJECT_1.DEPTNO = DEPT.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT.DEPTNO   
                      AND PACTIVITY.PROJ_NO = EMP_PROJ_ACT.PROJ_NO 
                      AND PACTIVITY.ACT_NO = EMP_PROJ_ACT.ACT_NO 
                      AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
                      AND EMP_PHOTO.EMPNO = EMP_RESUME.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY.EMPNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY.ACT_NO   
                      AND PROJECT_1.DEPTNO = DEPT_1.DEPTNO 
                      AND PROJECT.DEPTNO = DEPT_1.DEPTNO   
                      AND DEPT.MGRNO = DEPT_1.DEPTNO 
                      AND PACTIVITY.ACT_NO = ACTIVITY_1.ACT_NO 
                      AND EMP_PHOTO.EMPNO = EMP_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = EMP_PHOTO_1.EMPNO 
                      AND EMP_PHOTO.EMPNO = MSG_IN_TRAY_1.EMPNO 
                      AND EMP.FIRSTNAME = empName;
                END-EXEC.                                               

      /                                                                 
       LINKAGE SECTION.                                                 
       01  PEMPNAME         PIC S9(7)V(2) USAGE COMP-3.
       
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

      *-------------------------------*
      *            FETCH C2           *
      *-------------------------------*
                EXEC SQL                                                
                    FETCH C2
                    INTO  :WS-EMPNO
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
                    INTO  :WS-FIRSTNAME,
                          :WS-LASTNAME 
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