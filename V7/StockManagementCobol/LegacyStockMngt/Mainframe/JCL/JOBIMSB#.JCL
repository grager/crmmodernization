//JOBIMSB#  JOB (ACCT001),'MYTELCO IMSB#',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD RUN THE IMS DM BATCH PROGRAMS - COBIMSB1 AND      *
//*  COBIMSB2 TO DEMONSTRATE DL/I CALLS TO HIDAM AND GSAM             * 
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  RUNS THE COBIMSB1 PROGRAM         
//*--------------------------------------------------------------------
//COBOLB1  EXEC PGM=DFSRRC00,PARM='DLI,COBIMSB1,COBIMSB1'
//STEPLIB  DD DSN=SYSCAST.IMS.SDFSRESL,DISP=SHR
//*                                      * IMS DBD AND PSB LIBS
//IMS      DD DSN=APPCAST.IMS.PSBLIB,DISP=SHR
//         DD DSN=APPCAST.IMS.DBDLIB,DISP=SHR
//*                                      * IMS STATISTICS
//DFSSTAT  DD  SYSOUT=P
//*                                      * IMS SYSTEM LOG
//IEFRDER  DD  DUMMY
//CASTCMP1 DD  DSN=MYTELCO.IMSHISAM.DATA,DISP=SHR
//*
//SYSTSPRT DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//SYSABOUT DD  SYSOUT=*
//SYSDBOUT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//*
//*--------------------------------------------------------------------
//*  RUNS THE COBIMSB2 PROGRAM         
//*--------------------------------------------------------------------
//COBOLB2  EXEC PGM=DFSRRC00,PARM='DLI,COBIMSB2,COBIMSB2'
//STEPLIB  DD DSN=SYSCAST.IMS.SDFSRESL,DISP=SHR
//*                                      * IMS DBD AND PSB LIBS
//IMS      DD DSN=APPCAST.IMS.PSBLIB,DISP=SHR
//         DD DSN=APPCAST.IMS.DBDLIB,DISP=SHR
//*                                      * IMS STATISTICS
//DFSSTAT  DD  SYSOUT=P
//*                                      * IMS SYSTEM LOG
//IEFRDER  DD  DUMMY
//*                                      * SEQUENTIAL FILE 
//GSASEQ   DD  DSN=MYTELCO.IMSGSAM.DATA,DISP=OLD
//*
//SYSTSPRT DD  SYSOUT=*
//SYSOUT   DD  SYSOUT=*
//SYSABOUT DD  SYSOUT=*
//SYSDBOUT DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//*

