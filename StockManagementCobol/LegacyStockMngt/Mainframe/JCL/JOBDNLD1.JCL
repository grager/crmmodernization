//JOBDNLD1  JOB (ACCT001),'MYTELCO DNLD1',CLASS=A,
//      MSGCLASS=X,TIME=60,REGION=0M
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS JOB WOULD DOWNLOAD THE EMPLOYEE TABLE DATA AND STORE IT IN  *
//*  A VSAM FILE - MYTELCO.EMPDATA.VSAM  - BUILDS IT DAILY           * 
//*                                                                   *
//*  CAUTION: THIS JCL IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS  *
//*                                                                   *
//*===================================================================*
//*
//JOBLIB   DD  DSN=SYSCAST.DSNUTIL.LOAD,DISP=SHR
//*
//*--------------------------------------------------------------------
//*  DELETE DEFINES VSAM CLUSTER
//*--------------------------------------------------------------------
//DELDEF   EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
  DELETE MYTELCO.EMPDATA.VSAM 
  IF LASTCC = 8 THEN SET MAXCC = 0
  DEFINE CLUSTER                                                -
       ( NAME(MYTELCO.EMPDATA.VSAM)                            -
       VOLUMES(VOLCAST)                                         -
       BUFFERSPACE(37888)                                       -
       FREESPACE(0 0)                                           -
       INDEXED                                                  -
       KEYS(10,0)                                               -
       RECORDSIZE(120,120)                                      -
       SHAREOPTIONS(2,3)                                        -
       DATACLAS (CAST )                                         -
       SPEED )                                                  -
   DATA                                                         -
       ( NAME(MYTELCO.EMPDATA.VSAM.DATA)                       -
        CYLINDERS    (   10          5)                 )       -
   INDEX                                                        -       
       ( NAME(MYTELCO.EMPDATA.VSAM.INDEX)              ) 
/*       
//*--------------------------------------------------------------------
//*  DOWNLOADS THE EMP TABLE RECORDS INTO A WORKING FILE
//*--------------------------------------------------------------------
//DNLDEMP  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)
//SYSTSPRT DD SYSOUT=*                                                  
//SYSPRINT DD SYSOUT=*                                                  
//SYSUDUMP DD SYSOUT=*                                                  
//SYSPUNCH DD SYSOUT=* 
//SYSREC00 DD DSN=MYTELCO.WRKEMP,DISP=(,CATLG,DELETE),
//         UNIT=SYSDA,SPACE=(CYL,(5,5))
//REPORT   DD SYSOUT=*                                                  
//SYSIN    DD *                                                         
  SELECT * FROM MYTELCO.EMP;                        
//SYSTSIN DD * 
  DSN  SYSTEM(DSN) 
  RUN  PROGRAM(DSNTIAUL)    - 
       PLAN(DSNTIAUL)       -                                
       PARMS('SQL')         -
       LIB('SYSCAST.DSNUTIL.LOAD')                                  
/* 
//*--------------------------------------------------------------------
//*  SORTS THE DATA OF WORKING FILE AND COPIES TO TEMP FILE 
//*--------------------------------------------------------------------
//SORTEMP  EXEC PGM=SORT
//SYSOUT   DD  SYSOUT=*
//SORTIN   DD  DSN=MYTELCO.WRKEMP,DISP=SHR
//SORTOUT  DD  DSN=&&TEMP,DISP=(NEW,PASS,DELETE),
//         DCB=(LRECL=120,BLKSIZE=0,DSORG=PS,RECFM=FB),
//         SPACE=(CYL,(5,5) 
//SYSIN    DD  *
  SORT FIELDS=(1,6,CH,A)
  SUM FIELDS=NONE
/*
//*--------------------------------------------------------------------
//*  COPIES THE SORTED DATA TO VSAM FILE
//*--------------------------------------------------------------------
//STORE    EXEC PGM=IDCAMS,COND(0,NE)
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//FILEIN   DD DSN=&&TEMP,DISP=(OLD,DELETE,DELETE) 
//FILEOUT  DD DSN=MYTELCO.EMPDATA.VSAM,DISP=OLD
//SYSIN    DD * 
  REPRO IFILE(FILEIN) OFILE(FILEOUT)
/*
//*--------------------------------------------------------------------
//*  DELETES THE WORKING FILE
//*--------------------------------------------------------------------
//DELWRK   EXEC PGM=IEFBR14
//WORKFILE DD  DSN=MYTELCO.WRKEMP,DISP=(OLD,DELETE,DELETE) 
//*
