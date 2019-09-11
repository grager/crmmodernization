//JOBRPT23  JOB (ACCT001),'MYTELCO RPT23',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                             *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL PROGRAM "COBRPT23"       *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBRPT23
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBRPT23
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//*
