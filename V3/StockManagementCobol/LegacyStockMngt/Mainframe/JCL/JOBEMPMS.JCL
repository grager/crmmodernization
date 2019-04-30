//JOBEMPMS  JOB (ACCT001),'MYTELCO EMPMS',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                             *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL PROGRAM "COBEMPMS"       *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBEMPMS
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBEMPMS
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//*
