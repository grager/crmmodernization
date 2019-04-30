//JOBRSETC  JOB (ACCT001),'MYTELCO RSETC',CLASS=A,
//      MSGCLASS=X,TIME=1440,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL-DB2 PROGRAM "COBRSETC"   *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL-DB2 PROGRAM COBRSETC
//*  "DB2D" IS THE DB2 SUBSYTEM USED FOR DEMO APPLICATION
//*  DB2 PLAN USED FOR DEMO APPLICATION IS "PLCAST01"
//*--------------------------------------------------------------------
//COBOLTC EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)                    
//SYSTSPRT DD SYSOUT=*                                                 
//SYSPRINT DD SYSOUT=*                                                 
//SYSUDUMP DD SYSOUT=*                                                 
//SYSOUT   DD SYSOUT=*                                                 
//SYSTSIN  DD *                                                         
 DSN SYSTEM(DB2D)                                                      
 RUN PROGRAM(COBRSETC) - 
 PLAN(PLCAST01) -                                                     
      LIB('APPCAST.DB2SRC.LOADLIB')                                        
 END                                                                   
//CARDIN   DD DSN=MYTELCO.COBRSETC.CARDIN,DISP=SHR                    
//*                                                                    
