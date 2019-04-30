      *-----------------------------------------------------------------
      *  APIACTVT - TECHNICAL PROGRAM TO ACCESS DATA NEEDED BY COBACTVT.
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   APIACTVT.                                          
       AUTHOR.       CAST SOFTWARE                                      
       DATE-WRITTEN. FEBRUARY 2012.                                       
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
       WORKING-STORAGE SECTION.                                         
                                                                        
           EXEC SQL 
              INCLUDE ACTIV                             
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
           MOVE DATA-IN TO DCLACTVT.
           
           EXEC SQL                                                
                  SELECT                                                
                    ACT_DESC                                            
                  INTO
                    :WACTVTNAME
                  FROM ACTIVITY                                           
                  WHERE ACT_NO = :WACTVTNO                         
                  FETCH FIRST ROW ONLY
           END-EXEC.                                               
                                                                        
           EVALUATE SQLCODE                                        
               WHEN 0                                              
                   MOVE DCLACTVT                TO DATA-OUT                                       
                   MOVE 0                       TO RESP-CODE
               WHEN OTHER                
                   MOVE SPACES                  TO DATA-OUT                                        
                   MOVE 1                       TO RESP-CODE
           END-EVALUATE.                                           
