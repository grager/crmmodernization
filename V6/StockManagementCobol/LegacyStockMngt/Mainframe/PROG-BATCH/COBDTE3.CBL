      *-----------------------------------------------------------------
      *    COBEMPDP - COBOL SUBROUTINE TO CHANGE THE DATE FORMAT        
      *                                                                 
      *    FUNCTIONALITY - THIS COBOL PROGRAM ACCEPTS PRESENATIONS AND  
      *                    STOREAGE DATE FORMATES AND CHANGES THEM TO   
      *                    STORAGE AND PRESENTATION DATE FORMATS        
      *                    RESPECTIVELY.                                
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   COBDTE3                                            
       AUTHOR.       CAST SOFTWARE                                      
       DATE-WRITTEN. JUNE 1997.                                         
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
                                                                        
       INPUT-OUTPUT SECTION.                                            
                                                                        
       FILE-CONTROL.                                                    
                                                                        
                                                                        
       EJECT                                                            
       DATA DIVISION.                                                   
                                                                        
       WORKING-STORAGE SECTION.                                         
                                                                        
       COPY COBDTE3C.                                                   
                                                                        
       01  COUNT-DDD                     PIC 999    VALUE ZERO.         
       01  CNT                           PIC 99     VALUE ZERO.         
       01  WHOLE-NUMBER                  PIC 999    VALUE ZERO.         
       01  INDX                          PIC 99     VALUE ZERO.         
       01  ERROR-CODE                    PIC 99     VALUE ZERO.         
                                                                        
                                                                        
       01  ERROR-TABLE.                                                 
           03  FILLER   PIC X(30) VALUE "E - INVALID INPUT FORMAT ".    
           03  FILLER   PIC X(30) VALUE "E - INVALID DATE         ".    
           03  FILLER   PIC X(30) VALUE "E - INVALID OUTPUT FORMAT".    
                                                                        
       01  ERROR-MESSAGES REDEFINES ERROR-TABLE.                        
           03  ERROR-MSG PIC X(30) OCCURS 3 TIMES.                      
                                                                        
                                                                        
       LINKAGE SECTION.                                                 
                                                                        
       01  INPUT-DATE                     PIC X(8).                     
       01  INPUT-FORMAT                   PIC X(8).                     
       01  OUTPUT-FORMAT                  PIC X(8).                     
       01  MSG                            PIC X(30).                    
                                                                        
       PROCEDURE DIVISION USING INPUT-DATE                              
                                INPUT-FORMAT                            
                                OUTPUT-FORMAT                           
                                MSG.                                    
                                                                        
           MOVE SPACES TO MSG.                                          
           MOVE ZEROS  TO COUNT-DDD CNT WHOLE-NUMBER INDX ERROR-CODE.   
                                                                        
           IF  INPUT-FORMAT = "MM/DD/YY" OR "MM-DD-YY"                  
               MOVE INPUT-DATE TO WRK-DATE-MMXDDXYY                     
               MOVE CORRESPONDING WRK-DATE-MMXDDXYY TO WRK-DATE         
               MOVE CORRESPONDING WRK-DATE-MMXDDXYY TO WRK-DATE-YYDDD   
           ELSE                                                         
               IF INPUT-FORMAT = "YY/DD/MM" OR "YY-DD-MM"               
                  MOVE INPUT-DATE TO WRK-DATE-YYXDDXMM                  
                  MOVE CORRESPONDING WRK-DATE-YYXDDXMM TO WRK-DATE      
                  MOVE CORRESPONDING WRK-DATE-YYXDDXMM TO WRK-DATE-YYDDD
               ELSE                                                     
                  IF INPUT-FORMAT = "YYDDD"                             
                     MOVE INPUT-DATE TO WRK-DATE-YYDDD                  
                     MOVE CORRESPONDING WRK-DATE-YYDDD TO WRK-DATE      
                  ELSE                                                  
                     IF INPUT-FORMAT = "YYMMDD"                         
                        MOVE INPUT-DATE TO WRK-DATE                     
                     ELSE                                               
                        MOVE 1  TO ERROR-CODE                           
                        GO TO COBDATE-END                               
                     END-IF                                             
                  END-IF                                                
               END-IF                                                   
           END-IF.                                                      
                                                                        
      *    **  verify input date                                        
                                                                        
           EVALUATE INPUT-FORMAT                                        
                                                                        
           WHEN ("YYDDD")                                               
                                                                        
             IF  WRK-DATE-YYDDD IS NUMERIC THEN                         
                 PERFORM 100-CALC-LEAP-DAYS THRU 100-EXIT               
                 PERFORM 200-CALC-JULIAN-MONTH THRU 200-EXIT            
             ELSE                                                       
                 MOVE 2  TO ERROR-CODE                                  
             END-IF                                                     
                                                                        
           WHEN OTHER                                                   
                                                                        
             IF  WRK-DTE-YY < "00" OR > "99" THEN                       
                 MOVE 2  TO ERROR-CODE                                  
             ELSE                                                       
                 PERFORM 100-CALC-LEAP-DAYS THRU 100-EXIT               
                 IF  WRK-DTE-MM < "01" OR > "12" THEN                   
                     MOVE 2  TO ERROR-CODE                              
                 ELSE                                                   
                     MOVE WRK-DTE-MM        TO INDX                     
                     IF  WRK-DTE-DD < "01" OR > WRK-MTH-DAYS(INDX) THEN 
                         MOVE 2  TO ERROR-CODE                          
                     END-IF                                             
                 END-IF                                                 
             END-IF                                                     
                                                                        
           END-EVALUATE.                                                
                                                                        
           IF  ERROR-CODE > ZEROS THEN                                  
               GO TO COBDATE-END                                        
           END-IF.                                                      
                                                                        
      *    **  setup output date as required (yymmdd or yyddd)          
                                                                        
           EVALUATE OUTPUT-FORMAT                                       
                                                                        
             WHEN ("YYMMDD")                                            
               MOVE WRK-DATE    TO INPUT-DATE                           
                                                                        
             WHEN ("YYDDD")                                             
               MOVE 1 TO CNT                                            
               MOVE WRK-DTE-DD TO COUNT-DDD                             
               PERFORM UNTIL CNT = WRK-DTE-MM-NUM                       
                   ADD WRK-MTH-DAYS(CNT) TO COUNT-DDD                   
                   ADD 1 TO CNT                                         
               END-PERFORM                                              
               MOVE COUNT-DDD      TO WRK-DATE-DDD                      
               MOVE WRK-DATE-YYDDD TO INPUT-DATE                        
                                                                        
             WHEN ("MM/DD/YY")                                          
               MOVE CORRESPONDING WRK-DATE TO WRK-DATE-MMXDDXYY         
               MOVE "/"            TO WRK-DATE-MMXDDXYY(3:1)            
                                      WRK-DATE-MMXDDXYY(6:1)            
               MOVE WRK-DATE-MMXDDXYY TO INPUT-DATE                     
                                                                        
             WHEN OTHER                                                 
               MOVE 3  TO ERROR-CODE                                    
                                                                        
           END-EVALUATE.                                                
                                                                        
       COBDATE-END.                                                     
                                                                        
           IF  ERROR-CODE > ZEROS THEN                                  
               MOVE ERROR-MSG(ERROR-CODE) TO MSG                        
           END-IF.                                                      
                                                                        
           GOBACK.                                                      
                                                                        
       100-CALC-LEAP-DAYS.                                              
                                                                        
           MOVE WRK-DTE-YY  TO WRK-YEAR-YY                              
           DIVIDE WRK-YEAR-YYYY-NUM BY 4 GIVING WHOLE-NUMBER            
                                        REMAINDER WRK-LEAP              
           IF  WRK-LEAP = 0 THEN                                        
               MOVE 29 TO WRK-MTH-DAYS(2)                               
           ELSE                                                         
               MOVE 28 TO WRK-MTH-DAYS(2)                               
           END-IF.                                                      
                                                                        
       100-EXIT.                                                        
           EXIT.                                                        
                                                                        
       200-CALC-JULIAN-MONTH.                                           
           PERFORM UNTIL COUNT-DDD >= WRK-DATE-DDD                      
               ADD 1 TO CNT                                             
               ADD WRK-MTH-DAYS(CNT) TO COUNT-DDD                       
           END-PERFORM.                                                 
           IF  CNT > 12 OR WRK-DATE-DDD = ZEROS THEN                    
               MOVE 2  TO ERROR-CODE                                    
           ELSE                                                         
               MOVE CORRESPONDING WRK-DATE-YYDDD TO WRK-DATE            
               MOVE CNT TO WRK-DATE-MM OF WRK-DATE                      
               COMPUTE WRK-DTE-DD-NUM = WRK-MTH-DAYS(CNT) -             
                       (COUNT-DDD - WRK-DATE-DDD-NUM)                   
           END-IF.                                                      
       200-EXIT.                                                        
           EXIT.                                                        
