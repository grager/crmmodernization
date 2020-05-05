      *-----------------------------------------------------------------
      *    COBEMPDP - SAMPLE COBOL PROGRAM TO DEMONSTRATE CICS CALLS
      *                                                                 
      *    FUNCTIONALITY - READS EMPLOYEE DATA FROM DATABASE AND    
      *                    SENDS TO CICS CALLING PROGRAM. THE COBOL 
      *                    PROGRAM ALSO UPDATES DATABASE WITH THE   
      *                    EMPLOYEE DATA IF REQUESTED BY THE CALLING
      *                    CICS PROGRAM.                            
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBEMPDP.                                          
       AUTHOR.       CAST SOFTWARE.                                      
       DATE-WRITTEN. OCT 2005.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
      *-----------------------------------------------------------------
      * WORKING STORAGE SECTION                                         
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
                                                                        
                                                                        
       01  ADD-REC-FLAG                    PIC X VALUE SPACES.          
                                                                        
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
                                                                        
      /                                                                 
       LINKAGE SECTION.                                                 
                                                                        
       01  CASTMEMPI         PIC X(6)                                   
       01  CASTMDEPO         PIC X(4)                                   
       01  CASTMNAMEO        PIC X(30)                                  
       01  CASTMJOB          PIC X(8)                                   
       01  CASTMBDATEO       PIC X(8)                                   
       01  ADD-REC-FLAG      PIC X(1)                                   
                                                                        
           EJECT                                                        

      *-----------------------------------------------------------------                                                                  
      * PROCEDURE DIVISION                                                                                                               
      *-----------------------------------------------------------------                                                                  
       PROCEDURE DIVISION USING CASTMEMPI, CASTMDEPO, CASTMNAMEO, 
                                CASTMJOB, CASTMBDATEO, ADD-REC-FLAG. 
                                                                        
            IF ADD-REC-FLAG = "Y"                                       
                 PERFORM 4000-READ-EMPLOYEE-RECORD                      
            ELSE                                                        
                 PERFORM 5000-UPDATE-EMPLOYEE-RECORD                    
            END-IF.                                                     
                                                                        
      *-----------------------------------------------------------------                                                                  
      * READ EMPLOYEE RECORDS BY MAKING A CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       4000-READ-EMPLOYEE-RECORD.                                       
                                                                        
                MOVE SPACES      TO ADD-REC-FLAG.                       
                MOVE CASTMEMPI   TO PEMPNO.                             
                MOVE PEMPNO      TO WS-EMPNO.                           
                                                                        
                DISPLAY 'WS-EMPNO = ' WS-EMPNO.                         
                                                                        
                EXEC SQL                                                
                  SELECT                                                
                      FIRSTNME,                                         
                      MIDINIT,                                          
                      LASTNAME,                                         
                      WORKDEPT,                                         
                      HIREDATE,                                         
                      BIRTHDATE,                                        
                      SALARY                                            
                  INTO                                                  
                      :PFIRSTNME                                        
                    , :PMIDINIT                                         
                    , :PLASTNAME                                        
                    , :PWORKDEPT                                        
                    , :PHIREDATE                                        
                    , :PBIRTHDATE                                       
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
                         MOVE SPACES     TO PEMPNO                      
                                            PWORKDEPT                   
                                            PFIRSTNME                   
                                            PMIDINIT                    
                                            PLASTNAME                   
                                            PHIREDATE                   
                         PERFORM 9000-DBERROR THRU 9000-EXIT                           
                END-EVALUATE.                                           
                                                                        
                MOVE PEMPNO               TO CASTMEMPI                       
                MOVE PWORKDEPT            TO CASTMDEPO                       
                MOVE PEMPNAME             TO CASTMNAMEO                      
                MOVE PJOB                 TO CASTMJOB                        
                MOVE PBIRTHDATE           TO CASTMBDATEO.                    
                                                                        
                                                                        
      *-----------------------------------------------------------------                                                                  
      * UPDATE EMPLOYEE RECORDS BY MAKING CALL TO DB2 TABLE                                                                              
      *-----------------------------------------------------------------                                                                  
       5000-UPDATE-EMPLOYEE-RECORD.                                     
                                                                        
           MOVE CASTMEMPI TO PEMPNO.                                    
           MOVE PEMPNO    TO WS-EMPNO.                                
                                                                        
           DISPLAY 'WS-EMPNO = ' WS-EMPNO.                              
                                                                        
           EXEC SQL                                                     
             SELECT                                                     
                 EMPNO,                                                 
             INTO                                                       
               , :PEMPNO                                                
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
                    MOVE "Y"        TO ADD-REC-FLAG                     
               WHEN OTHER                                               
                    PERFORM 9000-DBERROR THRU 9000-EXIT                 
           END-EVALUATE.                                                 
                                                                        
           MOVE CASTMEMPI            TO PEMPNO                          
           MOVE CASTMDEPO            TO PWORKDEPT                       
           MOVE CASTMNAMEO           TO PEMPNAME                        
           MOVE CASTMJOB             TO PJOB                            
           MOVE CASTMBDATEO          TO PBIRTHDATE.                     
                                                                        
           IF  ADD-REC-FLAG = "Y"  THEN                                 
               EXEC SQL                                                 
                       INSERT INTO                                      
                          EMP                                  
                          (                                             
                             FIRSTNME,                                  
                             MIDINIT,                                   
                             LASTNAME,                                  
                             WORKDEPT,                                  
                             PHONENO,                                   
                             HIREDATE,                                  
                             JOB,                                       
                             EDLEVEL,                                   
                             SEX,                                       
                             BIRTHDATE,                                 
                             SALARY,                                    
                             BONUS,                                     
                             COMM                                       
                          )                                             
                           VALUES                                       
                          (                                             
                            :PFIRSTNME                                  
                          , :PMIDINIT                                   
                          , :PLASTNAME                                  
                          , :PWORKDEPT                                  
                          , :PPHONENO                                   
                          , :PHIREDATE                                  
                          , :PJOB                                       
                          , :PEDLEVEL                                   
                          , :PSEX                                       
                          , :PBIRTHDATE                                 
                          , :PSALARY                                    
                          , :PBONUS                                     
                          , :PCOMM                                      
                          )                                             
               END-EXEC                                                 
               MOVE SQLCODE  TO PSQLCODE                               
               MOVE SQLSTATE TO PSQLSTATE                              
               MOVE SQLERRMC TO PSQLERRMC                              
                                                                        
               EVALUATE SQLCODE                                         
                   WHEN 0                                               
                        CONTINUE                                        
                        MOVE SPACES TO ADD-REC-FLAG                     
                   WHEN OTHER                                           
                        PERFORM 9000-DBERROR THRU 9000-EXIT                            
               END-EVALUATE                                             
                                                                        
           ELSE                                                         
                                                                        
               EXEC SQL                                                 
                       UPDATE                                           
                           EMP                                 
                       SET FIRSTNME  = :PFIRSTNME,                      
                           MIDINIT   = :PMIDINIT,                       
                           LASTNAME  = :PLASTNAME,                      
                           WORKDEPT  = :PWORKDEPT,                      
                           PHONENO   = :PPHONENO,                       
                           HIREDATE  = :PHIREDATE,                      
                           JOB       = :PJOB,                           
                           EDLEVEL   = :PEDLEVEL,                       
                           SEX       = :PSEX,                           
                           BIRTHDATE = :PBIRTHDATE,                     
                           SALARY    = :PSALARY,                        
                           BONUS     = :PBONUS,                         
                           COMM      = :PCOMM                           
                       WHERE                                            
                          (                                             
                            ( EMP.EMPNO = :WS-EMPNO )          
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
                                                                        