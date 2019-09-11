//BKPPROC  PROC
//*
//*===================================================================*
//*                            MYTELCO HR                            *
//*                                                                   *
//*  THIS PROC WOULD TAKE THE QUATERLY BACKUP OF THE GDG'S CREATED    *
//*  IN JOBDYNSQ - LAST THREE VERSIONS                                * 
//*                                                                   *
//*  CAUTION: THIS PROC IS FOR DEMO PURPOSE AND MAY NOT BE USED AS IS *
//*                                                                   *
//*===================================================================*
//*
//*--------------------------------------------------------------------
//*  SORT DATA OF LAST THREE GDG'S AND PUTS IT INTO A TEMP FILE
//*--------------------------------------------------------------------
//SORGDG  EXEC PGM=SORT
//SYSOUT   DD  SYSOUT=*
//SORTIN   DD  DISP=SHR,DSN=MYTELCO.COBDYNSQ.GDG(0)
//         DD  DISP=SHR,DSN=MYTELCO.COBDYNSQ.GDG(-1)
//         DD  DISP=SHR,DSN=MYTELCO.COBDYNSQ.GDG(-2)
//SORTOUT  DD  DSN=&&TEMP,DISP=(NEW,PASS,DELETE),
//         DCB=(LRECL=80,BLKSIZE=0,DSORG=PS,RECFM=FB),
//         SPACE=(CYL,(5,5) 
//SYSIN    DD  *
  SORT FIELDS=(1,6,CH,A)
  SUM FIELDS=NONE
/*
//*--------------------------------------------------------------------
//*  TAKES THE BACKUP OF SORTED DATA ON A TAPE
//*--------------------------------------------------------------------
//BKPTAPE  EXEC PGM=IEBGENER
//SYSOUT   DD SYSOUT=*
//SYSUT1   DD DSN=&&TEMP,DISP=(OLD,DELETE,DELETE) 
//SYSUT2   DD DSN=MYTELCO.GDGDATA.TAPE,DISP=(,CATLG),
//            UNIT=TAPE,
//            DCB=(LRECL=80,RECFM=FB)  
//SYSPRINT DD SYSOUT=* 
//SYSIN    DD DUMMY
//*
