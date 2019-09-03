//JOBFUNC#  JOB (ACCT001),'MYTELCO FUNC#',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD BE USED TO RUN THE COBOL PROGRAMS "COBFUNC#"      *
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBFUNC1 : SORT
//*--------------------------------------------------------------------
//COBOL1  EXEC PGM=COBFUNC1
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//SORT01   DD  UNIT=SYSDA,SPACE=(CYL,5)
//VSAMF    DD  DSN=MYTELCO.EMPDATA.VSAM,DISP=SHR  
//SEQTF    DD  DSN=MYTELCO.COBFUNC1.SEQ1,DISP=(NEW,CATLG,DELETE),
//         DCB=(LRECL=120,BLKSIZE=0,DSORG=PS,RECFM=FB)
//         SPACE=(TRK,(5,5))
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBFUNC2 : MERGE
//*--------------------------------------------------------------------
//COBOL2  EXEC PGM=COBFUNC2
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//SORT01   DD  UNIT=SYSDA,SPACE=(CYL,5)
//SEQM1    DD  DSN=MYTELCO.COBFUNC2.DEPT1,DISP=SHR  
//SEQM2    DD  DSN=MYTELCO.COBFUNC2.DEPT2,DISP=SHR  
//MERGED   DD  DSN=MYTELCO.COBFUNC2.SEQ,DISP=(NEW,CATLG,DELETE),
//         DCB=(LRECL=120,BLKSIZE=0,DSORG=PS,RECFM=FB)
//         SPACE=(TRK,(5,5))
//
//*
//*--------------------------------------------------------------------
//*  RUNS COBOL PROGRAM COBFUNC3 : TABLE AND ARRAYS
//*--------------------------------------------------------------------
//COBOL3  EXEC PGM=COBFUNC3
//STEPLIB  DD  DSN=APPCAST.SOURCE.LOADLIB
//VSAMF    DD  DSN=MYTELCO.EMPDATA.VSAM,DISP=SHR  
//*
