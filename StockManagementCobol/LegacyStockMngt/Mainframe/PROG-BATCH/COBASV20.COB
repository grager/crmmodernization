      *-----------------------------------------------------------------
      *     COBASV20 - THIS PROGRAM PASSES EMPLOYEE NUMBER TO ANOTHER            
      *                COBOL PROGRAM. CALLED PROGRAM PRINTS REPORT OF 
      *                THOSE EMPLOYEE WHO HAVE BONUS MORE THAN $10,000.00
      *
      *		 FOR VIOLATION OF HIGH FAN IN(ONE OF THE 10 CALLING COBOL PROGRAMS)      	
      *                                                                 
      *-----------------------------------------------------------------
      *                                                                 
      *--------------------PART OF MYTELCO HR APPLICATION-------------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.                                         
      *-----------------------                                          
       PROGRAM-ID.    COBASV20.                                         
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
           
       01  WS-MISCELLENEOUS.
           10 WS-PHONE            PIC X(04).
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
      * VARIABLES FOR READING PARM VALUES 
      ******************************************************************

       LINKAGE SECTION.                                                 
       01  EMPSTART         PIC X(6).                                      
       01  EMPEND           PIC X(6).                                      

       PROCEDURE DIVISION USING EMPSTART, EMPEND.                                                                                                                     
      ******************************************************************
      * MAIN PROGRAM ROUTINE                                            
      ******************************************************************
       MAINLINE.                                                        
                                  
                DISPLAY "PORGRAM STARTED".

                DISPLAY "EMPSTART RANGE: " EMPSTART.

                DISPLAY "EMPEND RANGE: "   EMPEND.
                
      * CALL THE PROGRAM TO PRINT REPORT FOR EMPLOYEES
      
                                  
                PERFORM 2000-PROCESS                                    
                THRU    2000-EXIT.                                      
                                                                                                                                         
                STOP RUN.                                                 
      /                                                                 
      ******************************************************************
      * 2000-PROCESS                                                    
      ******************************************************************
       2000-PROCESS.                                                    
      *         CALL EXTERNAL COBOL PROGRAM
                CALL "COBASV11" USING EMPSTART
                                      EMPEND.

                                                                
       2000-EXIT.                                                       
                EXIT.                                                   

      /    
      
      ******************************************************************
      * 9999-ERROR-DISPLAY                                              
      ******************************************************************
       9999-ERROR-DISPLAY.                                              
                DISPLAY ERROR-TEXT (ERROR-INDEX).                       
       9999-EXIT.                                                       
                EXIT.                                                              