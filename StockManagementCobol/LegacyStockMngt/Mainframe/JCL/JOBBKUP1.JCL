//JOBBKUP1  JOB (ACCT001),'MYTELCO BKUP1',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD TAKE THE QUATERLY BACKUP OF THE GDG'S CREATE      *
//*  IN JOBDYNSQ - (0), (-1), (-2) VERSIONS                           * 
//*                                                                   *
//*  IT USES BKPPROC FOR THE PURPOSE                                  *
//*                                                                   *  
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//PROCLIB  DD DSN=APPCAST.DEMO.PROCLIB
//*
//*--------------------------------------------------------------------
//*  EXECUTES THE CATALOGUED PROCEDURE 
//*--------------------------------------------------------------------
//BKUP1    EXEC BKPPROC
//*