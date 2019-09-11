//JOBPAYRL  JOB (ACCT001),'MYTELCO PAYROLL',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                             *
//*                                                                   *
//*  THIS JOB WOULD RUN THE C BATCH PROGRAM - CCCDB201 		      *
//*  WHICH CREATES PAYROLL DATA FILE                                  * 
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS THE CCCDB201 PROGRAM         
//*--------------------------------------------------------------------
//PAYROLL  EXEC PGM=CCCDB201
//STEPLIB  DD DSN=APPCAST.C.LOADLIB,DISP=SHR
//*                                      * C LOAD MODULE PDS
//PAYDATA  DD  DSN=MYTELCO.PAYROLL.DATA,DISP=(,CATLG,DELETE),
//         DCB=(LRECL=80,BLKSIZE=0,DSORG=PS),SPACE=(CYL,(5,1),RLSE)
//*
//SYSTSPRT DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//SYSABOUT DD  SYSOUT=*
//SYSDBOUT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//*
