//JOBPHOTO  JOB (ACCT001),'MYTELCO PHOTO',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                             *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL PROGRAM "COBPHOTO"       *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBPHOTO
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBPHOTO
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//*
