//JOBDYNSQ  JOB (ACCT001),'MYTELCO DYNSQ',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL-DB2 PROGRAM "COBDYNSQ"   *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL-DB2 PROGRAM COBDYNSQ
//*  "DB2D" IS THE DB2 SUBSYTEM USED FOR DEMO APPLICATION
//*  DB2 PLAN USED FOR DEMO APPLICATION IS "PLCAST01"
//*--------------------------------------------------------------------
//COBOLSQ  EXEC PGM=IKJEFT01
//SYSTSPRT DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//PARMIN   DD  DSN=MYTELCO.COBDYNSQ.PARMIN,DISP=SHR
//GDGFIL   DD  DSN=MYTELCO.COBDYNSQ.GDG(+1),DISP=(NEW,CATLG,DELETE),
//         DCB=(LRECL=80,BLKSIZE=0,DSORG=PS,RECFM=FB)
//         SPACE=(TRK,(5,5))
//SYSTSIN  DD  *
  DSN SYSTEM(DB2D)
  RUN PROGRAM(COBDYNSQ)  -
  PLAN(PLCAST01)         -
  LIB('APPCAST.DB2SRC.LOADLIB')
/*

  
     
