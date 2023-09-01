//MFJDEM06 JOB 'Open Text',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR IEBGENER (ALIAS MFJGENER) COPY OPERATION
//*   -  CREATION OF A TEMPORARY DATASET (&&TEMP)
//*   -  PASSING A TEMPORARY DATASET TO A SUBSEQUENT STEP
//*   -  DELETION OF THE TEMPORARY DATASET AT END-OF-JOB
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM01.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEMUT.CBL
//*   -  ADD-EXISTING   DSN=MFJDEM.PERMNENT.JCLDEMO.DATA
//*                         FILENAME=..\JCL-examples\DATA\MFJDEMO.DAT
//*                         DSORG=PS,RECFM=FB,LRECL=80,CHARSET=EBCDIC
//*
//* ------------------------------------------------------------------
//*
//STEP01   EXEC PGM=IEBGENER
//SYSPRINT  DD SYSOUT=*
//SYSUT1    DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//SYSUT2    DD DSN=&&TEMP,DISP=(NEW,PASS),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*MFE:       %CHARSET=EBCDIC
//SYSIN     DD DUMMY
//*
//STEP02   EXEC PGM=MFJDEMUT,
//             PARM='JOB MFJDEM06 STEP02'
//SYSOUT    DD SYSOUT=*
//SYSUT1    DD DSN=&&TEMP,DISP=(OLD,PASS)
//SYSUT2    DD DUMMY,
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*
//
