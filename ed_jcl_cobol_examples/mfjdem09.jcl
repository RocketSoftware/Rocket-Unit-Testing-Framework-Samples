//MFJDEM09 JOB 'Open Text',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*
//* ------------------------------------------------------------------
//*<CR_TAG_JCL\>
//*
//* Copyright (C) Open Text 1984 - 2019 or one of its affiliates.
//* This sample code is supplied for demonstration purposes only
//* on an "as is" basis and "is for use at your own risk".
//*
//*<CR_TAG_JCL_END\>
//* ------------------------------------------------------------------
//*
//* DEMONSTRATES THE FOLLOWING:
//*
//*   -  SUPPORT FOR SORT/DFSORT (ALIAS MFJSORT)
//*   -  CONCATENATED EBCDIC INPUT FILES
//*   -  SUPPORT FOR INSTREAM CONTROL CARDS
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM09.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEMUT.CBL
//*   -  ADD-EXISTING   DSN=MFJDEM.PERMNENT.JCLDEMO.DATA
//*                         FILENAME=..\JCL-examples\DATA\MFJDEMO.DAT
//*                         DSORG=PS,RECFM=FB,LRECL=80,CHARSET=EBCDIC
//*
//* ------------------------------------------------------------------
//*
//STEP01   EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//          DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//SORTOUT   DD DSN=&&TEMP,DISP=(NEW,PASS),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//SYSIN     DD *
  SORT FIELDS=(1,30,CH,A)
//*
//STEP02   EXEC PGM=MFJDEMUT,
//             PARM='JOB MFJDEM09 STEP02'
//SYSOUT    DD SYSOUT=*
//SYSUT1    DD DSN=&&TEMP,DISP=(OLD,PASS)
//SYSUT2    DD DUMMY
//*
//
