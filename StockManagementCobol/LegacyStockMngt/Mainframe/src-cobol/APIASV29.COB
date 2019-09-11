      *-----------------------------------------------------------------
      *  APIASV29 - TECHNICAL PROGRAM TO ACCESS DATA NEEDED BY COBASV29.
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   APIASV29.                                          
       AUTHOR.       CAST SOFTWARE                                      
       DATE-WRITTEN. FEBRUARY 2012.                                       
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
       WORKING-STORAGE SECTION.                                         
                                                                        
           EXEC SQL 
               INCLUDE PARTA                                         
           END-EXEC.                                                    

           EXEC SQL 
               INCLUDE SQLCA  
           END-EXEC.                       
                                                                        
       LINKAGE SECTION.
       01 CMD-CODE  PIC 99.
       01 RESP-CODE PIC 99.
       01 DATA-IN   PIC X(512).
       01 DATA-OUT  PIC X(2048)
      *-----------------------------------------------------------------
      * PROCEDURE DIVISION.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION USING CMD-CODE RESP-CODE DATA-IN DATA-OUT.               
      * MAIN PROCESS
       MAIN.
           EVALUATE CMD-CODE
               WHEN 1
                   PERFORM CMD-01
               WHEN OTHER
                   MOVE 99 TO RESP-CODE
           END-EVALUATE.
           GOBACK.           
       CMD-01.
           MOVE DATA-IN TO DCLEMP.
           
           EXEC SQL                                                
                  SELECT                                                
                       PARTNAME                                          
                  INTO                                                  
                      :PFIRSTNME                                        
                  FROM PART                                              
                  WHERE PARTNO = :WS-EMPNO                               
           END-EXEC.                                               
                                                                        
           EVALUATE SQLCODE                                        
               WHEN 0                                              
                   MOVE DCLEMP                  TO DATA-OUT                                       
                   MOVE 0                       TO RESP-CODE
               WHEN OTHER                
                   MOVE SPACES                  TO DATA-OUT                                        
                   MOVE 1                       TO RESP-CODE
           END-EVALUATE.                                           
