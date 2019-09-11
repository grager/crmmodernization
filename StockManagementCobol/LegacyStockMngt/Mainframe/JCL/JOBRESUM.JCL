//JOBRESUM  JOB (ACCT001),'MYTELCO RESUM',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                             *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL PROGRAM "COBRESUM"       *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBRESUM
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBRESUM
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//*
