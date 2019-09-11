//JOBEMPRJ  JOB (ACCT001),'MYTELCO EMPRJ',CLASS=A,
//      MSGCLASS=X,TIME=1440,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL-DB2 PROGRAM "COBEMPRJ"   *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL-DB2 PROGRAM COBEMPRJ
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBEMPRJ
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//*
