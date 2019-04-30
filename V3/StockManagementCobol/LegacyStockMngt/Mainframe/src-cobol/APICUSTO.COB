      *-----------------------------------------------------------------
      *  APICUSTO - TECHNICAL PROGRAM TO ACCESS DATA NEEDED BY COBCUSTO.
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID.   APICUSTO.                                          
       AUTHOR.       CAST SOFTWARE                                      
       DATE-WRITTEN. FEBRUARY 2012.                                       
                                                                        
       EJECT                                                            
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
                                                                        
       WORKING-STORAGE SECTION.                                         
                                                                        
           EXEC SQL 
              INCLUDE SUPP                          
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
           MOVE DATA-IN TO DCL-CUSTOMER.
           
           EXEC SQL                                                
                  SELECT                                                
                    SUPNAME                                            
                  INTO
                    :W-CUST-NAME
                  FROM SUPPLY                                           
                  WHERE SUPNO = :W-CUST-NO                         
                  FETCH FIRST ROW ONLY
           END-EXEC.                                               
                                                                        
           EVALUATE SQLCODE                                        
               WHEN 0                                              
                   MOVE DCL-CUSTOMER            TO DATA-OUT                                       
                   MOVE 0                       TO RESP-CODE
               WHEN OTHER                
                   MOVE SPACES                  TO DATA-OUT                                        
                   MOVE 1                       TO RESP-CODE
           END-EVALUATE.                                           
