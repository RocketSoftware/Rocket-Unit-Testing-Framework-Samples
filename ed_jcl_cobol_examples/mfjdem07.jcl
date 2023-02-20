//MFJDEM07 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*
//* ------------------------------------------------------------------
//*<CR_TAG_JCL\>
//*
//* Copyright (C) Micro Focus 1984 - 2019 or one of its affiliates.
//* This sample code is supplied for demonstration purposes only
//* on an "as is" basis and "is for use at your own risk".
//*
//*<CR_TAG_JCL_END\>
//* ------------------------------------------------------------------
//*
//* DEMONSTRATES THE FOLLOWING:
//*
//*   -  SUPPORT FOR IEFBR14  (ALIAS MFJBR14)
//*   -  SUPPORT FOR IEBGENER (ALIAS MFJGENER) COPY OPERATION
//*   -  APPENDING DATA TO AN EXISTING DATASET USING DISP=MOD
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM07.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEMUT.CBL
//*   -  ADD-EXISTING   DSN=MFJDEM.PERMNENT.JCLDEMO.DATA
//*                         FILENAME=..\JCL-examples\DATA\MFJDEMO.DAT
//*                         DSORG=PS,RECFM=FB,LRECL=80,CHARSET=EBCDIC
//*
//* ------------------------------------------------------------------
//*
//STEP00   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM07.OUTDATA,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//*
//STEP01   EXEC PGM=IEBGENER
//SYSPRINT  DD SYSOUT=*
//SYSUT1    DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//SYSUT2    DD DSN=JCLDEMO.MFJDEM07.OUTDATA,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*MFE:       %CHARSET=EBCDIC
//SYSIN     DD DUMMY
//*
//STEP02   EXEC PGM=IEBGENER
//SYSPRINT  DD SYSOUT=*
//SYSUT1    DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//SYSUT2    DD DSN=JCLDEMO.MFJDEM07.OUTDATA,DISP=MOD
//*MFE:       %CHARSET=EBCDIC
//SYSIN     DD DUMMY
//*
//STEP03   EXEC PGM=MFJDEMUT,
//             PARM='JOB MFJDEM07 STEP03'
//SYSOUT    DD SYSOUT=*
//SYSUT1    DD DSN=JCLDEMO.MFJDEM07.OUTDATA,DISP=SHR
//*MFE:       %CHARSET=EBCDIC
//SYSUT2    DD DUMMY
//*
//STEP99   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM07.OUTDATA,DISP=(MOD,DELETE)
//*MFE:       %CHARSET=EBCDIC
//*
//
