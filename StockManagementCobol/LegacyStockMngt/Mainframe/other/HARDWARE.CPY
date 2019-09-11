      ******************************************************************
      * DCLGEN TABLE(HR_DB.HARDWARE)                                  *
      *        LIBRARY(HR_DB.TEST.SOURCE(HARDWARE))                     *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        QUOTE                                                   *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE HARDWARE TABLE
           ( HARDWARE_ID   		CHAR(10)        NOT NULL,
             MOUSE_ID      		VARCHAR(10)             ,
             KEYBOARD_ID   		VARCHAR(10)             ,  
             CPU_ID        		VARCHAR(10)             ,
             MONITOR_ID    		VARCHAR(10)             ,
             MOUSE_INS_VALUE            INTEGER			,
             KEYBOARD_INS_VALUE         INTEGER 		,
             CPU_INS_VALUE		INTEGER			,
             MONITOR_INS_VALUE	        INTEGER			,	         
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE HARDWARE                            *
      ******************************************************************
       01  DCLHARDWARE.
           10 HARDWARE-ID          PIC X(10).
           10 MOUSE-ID             PIC X(10).
           10 KEYBOARD-ID          PIC X(10).
           10 CPU-ID               PIC X(10).
           10 MONITOR-ID           PIC X(10).
           10 MOUSE-INS-VALUE      PIC S9(7)V9(2) USAGE COMP-3.
           10 KEYBOARD-INS-VALUE   PIC S9(7)V9(2) USAGE COMP-3. 
           10 CPU-INS-VALUE        PIC S9(7)V9(2) USAGE COMP-3.            
           10 MONITOR-INS-VALUE    PIC S9(7)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 9       *
      ******************************************************************
