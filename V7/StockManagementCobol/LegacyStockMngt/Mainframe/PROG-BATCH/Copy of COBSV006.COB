       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBSV006.                                           
       
       ENVIRONMENT DIVISION.                                            
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
            SELECT DBDCOMP1 ASSIGN TO CASTCMP1.             
            
       DATA DIVISION.                                                   
       FILE SECTION.                                                    
       FD  DBDCOMP1.                                     
             LABEL RECORD STANDARD.                                 
       01  DBDCOMP1-REC     PIC X(80).                                           
          
      *-----------------------------------------------------------------
      * WORKAREAS                                                       
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.                                         
       01  GET-UNIQUE      PIC  X(4)  VALUE 'GU  '.                     
       01  GET-HOLD-UNIQUE PIC  X(4)  VALUE 'GHU '.                     
       01  GET-NEXT        PIC  X(4)  VALUE 'GN  '.                     
       01  ISRT            PIC  X(4)  VALUE 'ISRT'.                     
       01  DLET            PIC  X(4)  VALUE 'DLET'.                     
       01  REPL            PIC  X(4)  VALUE 'REPL'. 
       01  COUNT 	   PIC  S9(5)  VALUE +4 COMPUTATIONAL. 
       01  UNQUAL-SSA.
       	   10 SEG-NAME 	   PIC  X(8)  VALUE '        '.
       	   10 FILLER 	   PIC  X     VALUE ' '.
       01  DEPT-SEG-IN.
           10 DEPTNO               PIC X(3).
           10 DEPTNAME.
              49 DEPTNAME-LEN      PIC S9(4) USAGE COMP.
              49 DEPTNAME-TEXT     PIC X(36).
           10 MGRNO                PIC X(6).
           10 ADMRDEPT             PIC X(3).
           10 LOCATION             PIC X(16).           
                      
      *-----------------------------------------------------------------
      * LINKAGE SECTION                                                       
      *-----------------------------------------------------------------
       LINKAGE SECTION.             
       01 DEPTPCB.                                                       
          02  DBD-NAME      PIC X(8).                                   
          02  SEG-LEVEL     PIC X(2).                                   
          02  STATUS-CODE   PIC X(2).                                   
          02  PROC-OPTIONS  PIC X(4).                                   
          02  RESERVE-DLI   PIC S9(9) USAGE IS BINARY.                  
          02  SEG-NAME-FB   PIC X(8).                                   
          02  KEY-LENGTH    PIC S9(9) USAGE IS BINARY.                  
          02  NO-SENSE-SEG  PIC S9(9) USAGE IS BINARY.                  
          02  KEY-AREA      PIC X(3).                                    
      
       PROCEDURE DIVISION USING DEPTPCB.                                              
      *-----------------------------------------------------------------
      * MAIN SECTION                                                       
      *-----------------------------------------------------------------
       000-MAIN-SECTION SECTION.
           GO TO 001-NEXT-SECTION.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       001-NEXT-SECTION SECTION.
           GO TO 002-NEXT-SECTION.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       002-NEXT-SECTION SECTION.
           GO TO 003-NEXT-SECTION.
       SEC-002-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       003-NEXT-SECTION SECTION.
           GO TO 004-NEXT-SECTION.
       SEC-003-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       004-NEXT-SECTION SECTION.
           GO TO 005-NEXT-SECTION.
       SEC-004-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       005-NEXT-SECTION SECTION.
           GO TO 006-NEXT-SECTION.
       SEC-005-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       006-NEXT-SECTION SECTION.
           GO TO 007-NEXT-SECTION.
       SEC-006-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       007-NEXT-SECTION SECTION.
           GO TO 008-NEXT-SECTION.
       SEC-007-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       008-NEXT-SECTION SECTION.
           GO TO 009-NEXT-SECTION.
       SEC-008-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       009-NEXT-SECTION SECTION.
           GO TO 010-NEXT-SECTION.
       SEC-009-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       010-NEXT-SECTION SECTION.
           GO TO 011-NEXT-SECTION.
       SEC-010-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       011-NEXT-SECTION SECTION.
           GO TO 012-NEXT-SECTION.
       SEC-011-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       012-NEXT-SECTION SECTION.
           GO TO 013-NEXT-SECTION.
       SEC-012-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       013-NEXT-SECTION SECTION.
           GO TO 014-NEXT-SECTION.
       SEC-013-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       014-NEXT-SECTION SECTION.
           GO TO 015-NEXT-SECTION.
       SEC-014-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       015-NEXT-SECTION SECTION.
           GO TO 016-NEXT-SECTION.
       SEC-015-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       016-NEXT-SECTION SECTION.
           GO TO 017-NEXT-SECTION.
       SEC-016-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       017-NEXT-SECTION SECTION.
           GO TO 018-NEXT-SECTION.
       SEC-017-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       018-NEXT-SECTION SECTION.
           GO TO 019-NEXT-SECTION.
       SEC-018-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       019-NEXT-SECTION SECTION.
           GO TO 020-NEXT-SECTION.
       SEC-019-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       020-NEXT-SECTION SECTION.
           GO TO 021-NEXT-SECTION.
       SEC-020-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       021-NEXT-SECTION SECTION.
           GO TO 022-NEXT-SECTION.
       SEC-021-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       022-NEXT-SECTION SECTION.
           GO TO 023-NEXT-SECTION.
       SEC-022-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       023-NEXT-SECTION SECTION.
           GO TO 024-NEXT-SECTION.
       SEC-023-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       024-NEXT-SECTION SECTION.
           GO TO 025-NEXT-SECTION.
       SEC-024-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       025-NEXT-SECTION SECTION.
           GO TO 026-NEXT-SECTION.
       SEC-025-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       026-NEXT-SECTION SECTION.
           GO TO 027-NEXT-SECTION.
       SEC-026-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       027-NEXT-SECTION SECTION.
           GO TO 028-NEXT-SECTION.
       SEC-027-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       028-NEXT-SECTION SECTION.
           GO TO 029-NEXT-SECTION.
       SEC-028-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       029-NEXT-SECTION SECTION.
           GO TO 030-NEXT-SECTION.
       SEC-029-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       030-NEXT-SECTION SECTION.
           GO TO 031-NEXT-SECTION.
       SEC-030-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       031-NEXT-SECTION SECTION.
           GO TO 032-NEXT-SECTION.
       SEC-031-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       032-NEXT-SECTION SECTION.
           GO TO 033-NEXT-SECTION.
       SEC-032-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       033-NEXT-SECTION SECTION.
           GO TO 034-NEXT-SECTION.
       SEC-033-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       034-NEXT-SECTION SECTION.
           GO TO 035-NEXT-SECTION.
       SEC-034-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       035-NEXT-SECTION SECTION.
           GO TO 036-NEXT-SECTION.
       SEC-035-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       036-NEXT-SECTION SECTION.
           GO TO 037-NEXT-SECTION.
       SEC-036-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       037-NEXT-SECTION SECTION.
           GO TO 038-NEXT-SECTION.
       SEC-037-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       038-NEXT-SECTION SECTION.
           GO TO 039-NEXT-SECTION.
       SEC-038-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       039-NEXT-SECTION SECTION.
           GO TO 040-NEXT-SECTION.
       SEC-039-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       040-NEXT-SECTION SECTION.
           GO TO 041-NEXT-SECTION.
       SEC-040-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       041-NEXT-SECTION SECTION.
           GO TO 042-NEXT-SECTION.
       SEC-041-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       042-NEXT-SECTION SECTION.
           GO TO 043-NEXT-SECTION.
       SEC-042-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       043-NEXT-SECTION SECTION.
           GO TO 044-NEXT-SECTION.
       SEC-043-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       044-NEXT-SECTION SECTION.
           GO TO 045-NEXT-SECTION.
       SEC-044-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       045-NEXT-SECTION SECTION.
           GO TO 046-NEXT-SECTION.
       SEC-045-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       046-NEXT-SECTION SECTION.
           GO TO 047-NEXT-SECTION.
       SEC-046-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       047-NEXT-SECTION SECTION.
           GO TO 048-NEXT-SECTION.
       SEC-047-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       048-NEXT-SECTION SECTION.
           GO TO 049-NEXT-SECTION.
       SEC-048-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       049-NEXT-SECTION SECTION.
           GO TO 050-NEXT-SECTION.
       SEC-049-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       050-NEXT-SECTION SECTION.
           GO TO 051-NEXT-SECTION.
       SEC-050-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       051-NEXT-SECTION SECTION.
           GO TO 052-NEXT-SECTION.
       SEC-051-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       052-NEXT-SECTION SECTION.
           GO TO 053-NEXT-SECTION.
       SEC-052-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       053-NEXT-SECTION SECTION.
           GO TO 054-NEXT-SECTION.
       SEC-053-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       054-NEXT-SECTION SECTION.
           GO TO 055-NEXT-SECTION.
       SEC-054-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       055-NEXT-SECTION SECTION.
           GO TO 056-NEXT-SECTION.
       SEC-055-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       056-NEXT-SECTION SECTION.
           GO TO 057-NEXT-SECTION.
       SEC-056-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       057-NEXT-SECTION SECTION.
           GO TO 058-NEXT-SECTION.
       SEC-057-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       058-NEXT-SECTION SECTION.
           GO TO 059-NEXT-SECTION.
       SEC-058-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       059-NEXT-SECTION SECTION.
           GO TO 060-NEXT-SECTION.
       SEC-059-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       060-NEXT-SECTION SECTION.
           GO TO 061-NEXT-SECTION.
       SEC-060-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       061-NEXT-SECTION SECTION.
           GO TO 062-NEXT-SECTION.
       SEC-061-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       062-NEXT-SECTION SECTION.
           GO TO 063-NEXT-SECTION.
       SEC-062-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       063-NEXT-SECTION SECTION.
           GO TO 064-NEXT-SECTION.
       SEC-063-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       064-NEXT-SECTION SECTION.
           GO TO 065-NEXT-SECTION.
       SEC-064-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       065-NEXT-SECTION SECTION.
           GO TO 066-NEXT-SECTION.
       SEC-065-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       066-NEXT-SECTION SECTION.
           GO TO 067-NEXT-SECTION.
       SEC-066-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       067-NEXT-SECTION SECTION.
           GO TO 068-NEXT-SECTION.
       SEC-067-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       068-NEXT-SECTION SECTION.
           GO TO 069-NEXT-SECTION.
       SEC-068-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       069-NEXT-SECTION SECTION.
           GO TO 070-NEXT-SECTION.
       SEC-069-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       070-NEXT-SECTION SECTION.
           GO TO 071-NEXT-SECTION.
       SEC-070-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       071-NEXT-SECTION SECTION.
           GO TO 072-NEXT-SECTION.
       SEC-071-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       072-NEXT-SECTION SECTION.
           GO TO 073-NEXT-SECTION.
       SEC-072-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       073-NEXT-SECTION SECTION.
           GO TO 074-NEXT-SECTION.
       SEC-073-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       074-NEXT-SECTION SECTION.
           GO TO 075-NEXT-SECTION.
       SEC-074-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       075-NEXT-SECTION SECTION.
           GO TO 076-NEXT-SECTION.
       SEC-075-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       076-NEXT-SECTION SECTION.
           GO TO 077-NEXT-SECTION.
       SEC-076-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       077-NEXT-SECTION SECTION.
           GO TO 078-NEXT-SECTION.
       SEC-077-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       078-NEXT-SECTION SECTION.
           GO TO 079-NEXT-SECTION.
       SEC-078-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       079-NEXT-SECTION SECTION.
           GO TO 080-NEXT-SECTION.
       SEC-079-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       080-NEXT-SECTION SECTION.
           GO TO 081-NEXT-SECTION.
       SEC-080-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       081-NEXT-SECTION SECTION.
           GO TO 082-NEXT-SECTION.
       SEC-081-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       082-NEXT-SECTION SECTION.
           GO TO 083-NEXT-SECTION.
       SEC-082-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       083-NEXT-SECTION SECTION.
           GO TO 084-NEXT-SECTION.
       SEC-083-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       084-NEXT-SECTION SECTION.
           GO TO 085-NEXT-SECTION.
       SEC-084-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       085-NEXT-SECTION SECTION.
           GO TO 086-NEXT-SECTION.
       SEC-085-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       086-NEXT-SECTION SECTION.
           GO TO 087-NEXT-SECTION.
       SEC-086-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       087-NEXT-SECTION SECTION.
           GO TO 088-NEXT-SECTION.
       SEC-087-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       088-NEXT-SECTION SECTION.
           GO TO 089-NEXT-SECTION.
       SEC-088-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       089-NEXT-SECTION SECTION.
           GO TO 090-NEXT-SECTION.
       SEC-089-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       090-NEXT-SECTION SECTION.
           GO TO 091-NEXT-SECTION.
       SEC-090-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       091-NEXT-SECTION SECTION.
           GO TO 092-NEXT-SECTION.
       SEC-091-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       092-NEXT-SECTION SECTION.
           GO TO 093-NEXT-SECTION.
       SEC-092-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       093-NEXT-SECTION SECTION.
           GO TO 094-NEXT-SECTION.
       SEC-093-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       094-NEXT-SECTION SECTION.
           GO TO 095-NEXT-SECTION.
       SEC-094-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       095-NEXT-SECTION SECTION.
           GO TO 096-NEXT-SECTION.
       SEC-095-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       096-NEXT-SECTION SECTION.
           GO TO 097-NEXT-SECTION.
       SEC-096-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       097-NEXT-SECTION SECTION.
           GO TO 098-NEXT-SECTION.
       SEC-097-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       098-NEXT-SECTION SECTION.
           GO TO 099-NEXT-SECTION.
       SEC-098-EXIT.
           EXIT.

      *-----------------------------------------------------------------
      * NEXT SECTION                                                       
      *-----------------------------------------------------------------
       099-NEXT-SECTION SECTION.
           GO TO 100-NEXT-SECTION.
       SEC-099-EXIT.
           EXIT.


       100-NEXT-SECTION SECTION.

           DISPLAY 'DISPLAYS ARE TO INCREASE LINES OF CODE'.
           DISPLAY 'IN THIS SECTION'.
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
           DISPLAY 'THESE DISPLAYS HAVE NO MEANING'. 
       
       110-MAIN-MODULE.     
           
           ENTRY 'DLITCBL'.
           
           PERFORM 120-PRINTDEPT-MODULE THRU 120-EXIT 
              UNTIL STATUS-CODE EQUAL TO 'QC'.
           
           STOP RUN.    
           
       110-EXIT.                                                        
           EXIT.                                              
           
       120-PRINTDEPT-MODULE.
           
           CALL 'CBLTDLI' USING GET-NEXT, DEPTPCB, DEPT-SEG-IN.
           
           DISPLAY 'DEPARTMENT NUMBER IS : ' DEPTNO.
           
           EVALUATE DEPTNO
             WHEN '001' DISPLAY 'CORPORATE DEPARTMENT'
             WHEN '002' DISPLAY 'ABC DEPARTMENT'
             WHEN '003' DISPLAY 'XYZ DEPARTMENT'
           END-EVALUATE.  
                      
       120-EXIT.
           EXIT.                  
           
       SEC-100-EXIT.
           EXIT.