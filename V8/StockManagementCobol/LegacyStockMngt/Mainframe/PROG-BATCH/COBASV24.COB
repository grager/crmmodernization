      *-----------------------------------------------------------------
      *    COBASV24 - SAMPLE COBOL PROGRAM TO INVOKE A STORED PROCEDURE 
      *               COBASV22                                    
      *               WHICH HAS PARAMTER STYLE GENERAL                  
      *                                                                 
      *    MODULE NAME = COBASV24
      *                                                                 
      *    FUNCTION = VIOLATES HIGH FAN IN RULE. THIS PROGRAM IS ONE 
      *               OF THE FIVE COBOL PROGRAMS              
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV24.                                         
      /                                                                 
       ENVIRONMENT DIVISION.                                            
      *--------------------                                             
       CONFIGURATION SECTION.                                           
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
           SELECT CARDIN                                                
                  ASSIGN TO DA-S-CARDIN.                                
                                                                        
       DATA DIVISION.                                                   
      *-------------                                                    
       FILE SECTION.                                                    
       FD      CARDIN                                                   
               RECORD CONTAINS 6 CHARACTERS                             
               BLOCK CONTAINS 0 RECORDS                                 
               LABEL RECORDS ARE OMITTED.                               
       01  CARDREC                    PIC X(6).                         
                                                                        
      /                                                                 
       WORKING-STORAGE SECTION.                                         
                                                                        
      *-----------------------------------------------------------------
      * STRUCTURE FOR INPUT                                             
      *-----------------------------------------------------------------
       01  PEMPNO        PIC X(6).                                      
       01  PFIRSTNME.                                                   
               49  PFIRSTNME-LEN  PIC S9(4) COMP.                       
               49  PFIRSTNME-TEXT PIC X(12).                            
       01  PMIDINIT      PIC X(1).                                      
       01  PLASTNAME.                                                   
           49  PLASTNAME-LEN  PIC S9(4) COMP.                           
           49  PLASTNAME-TEXT PIC X(15).                                
       01  PWORKDEPT     PIC X(3).                                      
       01  PHIREDATE     PIC X(10).                                     
       01  PSALARY       PIC S9(7)V9(2) COMP-3.                         
       01  PSQLCODE      PIC S9(9) COMP.                                
       01  PSQLSTATE     PIC X(5).                                      
       01  PSQLERRMC.                                                   
           49  PSQLERRMC-LEN   PIC S9(4) COMP.                          
           49  PSQLERRMC-TEXT  PIC X(250).                              
       01  NULL-IND-VARS.                                               
           05  PEMPNO-IV     PIC S9(4) COMP.                            
           05  PFIRSTNME-IV  PIC S9(4) COMP.                            
           05  PMIDINIT-IV   PIC S9(4) COMP.                            
           05  PLASTNAME-IV  PIC S9(4) COMP.                            
           05  PWORKDEPT-IV  PIC S9(4) COMP.                            
           05  PHIREDATE-IV  PIC S9(4) COMP.                            
           05  PSALARY-IV    PIC S9(4) COMP.                            
           05  PSQLCODE-IV   PIC S9(4) COMP.                            
           05  PSQLSTATE-IV  PIC S9(4) COMP.                            
           05  PSQLERRMC-IV  PIC S9(4) COMP.                            
       01  D5    PIC X(5).                                              
       01  D27.                                                         
           49  D27-LEN           PIC S9(4) COMP.                        
           49  D27-TEXT          PIC X(27).                             
       01  D18.                                                         
           49  D18-LEN           PIC S9(4) COMP.                        
           49  D18-TEXT          PIC X(18).                             
       01  D70.                                                         
           49  D70-LEN           PIC S9(4) COMP.                        
           49  D70-TEXT          PIC X(70).                             
                                                                        
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       77  INPUT-SWITCH        PIC X          VALUE  SPACES.            
               88  NOMORE-INPUT               VALUE  'N'.               
       77  END-OF-C1-SWITCH    PIC X          VALUE  SPACES.            
               88  END-OF-C1                  VALUE  'Y'.               
       01  WS-TIMESTAMP         PIC X(26).                              
       01  WS-SQLCODE           PIC 9(9).                               
                                                                        
      *-----------------------------------------------------------------
      * VARIABLES FOR ERROR-HANDLING                                    
      *-----------------------------------------------------------------
       01  ERROR-MESSAGE.                                               
               02  ERROR-LEN   PIC S9(4)  COMP VALUE +960.              
               02  ERROR-TEXT  PIC X(80) OCCURS 12 TIMES                
                                          INDEXED BY ERROR-INDEX.       
       77  ERROR-TEXT-LEN      PIC S9(9)  COMP VALUE +80.               
                                                                        
      /                                                                 
      *-----------------------------------------------------------------
      * SQLCA AND DCLGENS FOR TABLES                                    
      *-----------------------------------------------------------------
                EXEC SQL INCLUDE SQLCA  END-EXEC.                       
                                                                        
           EXEC SQL INCLUDE EMP                                         
           END-EXEC.                                                    
                                                                        
      /                                                                 
      *-----------------------------------------------------------------
      * SQL CURSORS AND STATEMENTS                                      
      *-----------------------------------------------------------------
                                                                        
      /                                                                 
       PROCEDURE DIVISION.                                              
      *------------------                                               
                                                                        
      *-----------------------------------------------------------------
      * MAIN PROGRAM ROUTINE                                            
      *-----------------------------------------------------------------
       MAINLINE.                                                        
                DISPLAY '++ COBDTL1C STARTING ++'.                      
                                                                        
                EXEC SQL                                                
                     SET :WS-TIMESTAMP = CURRENT TIMESTAMP              
                END-EXEC.                                               
                                                                        
                DISPLAY 'WS-TIMESTAMP = ' WS-TIMESTAMP.                 
                                                                        
                PERFORM 1000-OPEN-AND-READ                              
                THRU    1000-EXIT.                                      
                                                                        
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                        
                PERFORM 3000-CLOSE                                      
                THRU    3000-EXIT.                                      
                                                                        
                DISPLAY '++ COBDTL1C ENDING ++'.                        
                                                                        
                GOBACK.                                                 
      /                                                                 
      *-----------------------------------------------------------------
      * 1000-OPEN-AND-READ                                              
      *-----------------------------------------------------------------
       1000-OPEN-AND-READ.                                              
                OPEN INPUT  CARDIN.                                     
                                                                        
                READ CARDIN RECORD INTO PEMPNO                          
                   AT END MOVE 'N' TO INPUT-SWITCH.                     
                                                                        
                IF  NOMORE-INPUT                                        
                    DISPLAY '++ COBDTL1C EMPTY FILE ++'                 
                    CLOSE CARDIN                                        
                    GOBACK.                                             
                                                                        
               MOVE 0      TO  PFIRSTNME-LEN.                           
               MOVE SPACES TO  PFIRSTNME-TEXT.                          
               MOVE SPACES TO  PMIDINIT.                                
               MOVE 0      TO  PLASTNAME-LEN.                           
               MOVE SPACES TO  PLASTNAME-TEXT.                          
               MOVE SPACES TO  PWORKDEPT.                               
               MOVE '0001-01-01' TO  PHIREDATE.                         
               MOVE 0      TO  PSALARY.                                 
               MOVE 0      TO  PSQLCODE.                                
               MOVE SPACES TO  PSQLSTATE.                               
               MOVE 0      TO  PSQLERRMC-LEN.                           
               MOVE SPACES TO  PSQLERRMC-TEXT.                          
                                                                        
               MOVE 0 TO PEMPNO-IV.                                     
               MOVE 0 TO PFIRSTNME-IV.                                  
               MOVE 0 TO PMIDINIT-IV.                                   
               MOVE 0 TO PLASTNAME-IV.                                  
               MOVE 0 TO PWORKDEPT-IV.                                  
               MOVE 0 TO PHIREDATE-IV.                                  
               MOVE 0 TO PSALARY-IV.                                    
               MOVE 0 TO PSQLCODE-IV.                                   
               MOVE 0 TO PSQLSTATE-IV.                                  
               MOVE 0 TO PSQLERRMC-IV.                                  
                                                                        
       1000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 2000-PROCESS. THIS PARAGRAPH MAKES CALL COBOL STORED STORED 
      * PROCEDURE COBASV22. THIS PROCEDURE IS A DB2 OBJECT.
      *-----------------------------------------------------------------
       2000-PROCESS.                                                    
                DISPLAY 'PEMPNO = ' PEMPNO.                             
                DISPLAY 'PEMPNO-IV = ' PEMPNO-IV.                       
                                                                        
                EXEC SQL                                                
                     CALL COBASV22( :PEMPNO                             
                                   ,:PHIREDATE                          
                                  )                                     
                END-EXEC.                                               
                                                                        
                MOVE SQLCODE TO WS-SQLCODE.                             
                DISPLAY 'WS-SQLCODE AFTER CALL = ' WS-SQLCODE.          
                                                                        
                EVALUATE SQLCODE                                        
                    WHEN 0                                              
                         CONTINUE                                       
                    WHEN OTHER                                          
                         PERFORM 9000-DBERROR                           
                         THRU    9000-EXIT                              
                END-EVALUATE.                                           
                                                                        
                DISPLAY 'PHIREDATE  = ' PHIREDATE.                      
                                                                        
                                                                        
       2000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 3000-CLOSE                                                      
      *-----------------------------------------------------------------
       3000-CLOSE.                                                      
                CLOSE CARDIN.                                           
      *-----------------------------------------------------------------
      * EXIT PARA FOR THE CLOSE CARDIN PARA                                           
      *-----------------------------------------------------------------
       3000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 9000-DBERROR - GET ERROR MESSAGE
      * THIS PARA PROCEESSES THE SQLCA AREA AND DISPLAYS THE PROPER USER 
      * UNDERSTANDABLE SQL ERROR MESSAGES
      *-----------------------------------------------------------------
       9000-DBERROR.                                                    
                CALL 'DSNTIAR' USING SQLCA ERROR-MESSAGE ERROR-TEXT-LEN.
                IF RETURN-CODE = ZERO                                   
                   PERFORM 9999-ERROR-DISPLAY THRU                      
                           9999-EXIT                                    
                   VARYING ERROR-INDEX                                  
                   FROM    1 BY 1                                       
                   UNTIL   ERROR-INDEX GREATER THAN 12.                 
                                                                        
                PERFORM 3000-CLOSE                                      
                THRU    3000-EXIT.                                      
                                                                        
                GOBACK.                                                 
                                                                        
      *-----------------------------------------------------------------
      * EXIT BLOCK OF FOR THE PARA DBERROR                                            
      *-----------------------------------------------------------------
       9000-EXIT.                                                       
                EXIT.                                                   
      /                                                                 
      *-----------------------------------------------------------------
      * 9999-ERROR-DISPLAY                                              
      *-----------------------------------------------------------------
       9999-ERROR-DISPLAY.                                              
                DISPLAY ERROR-TEXT (ERROR-INDEX).                       

      *-----------------------------------------------------------------
      * EXIT BLOCK FOR ERROR DISPLAY PARAGRAPH.                                            
      *-----------------------------------------------------------------
       9999-EXIT.                                                       
                EXIT.                                                   
