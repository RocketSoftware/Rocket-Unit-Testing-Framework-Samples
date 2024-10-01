//MFJDEM07 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*
//* ------------------------------------------------------------------
//* Copyright 1984-2024 Rocket Software, Inc. or its affiliates. 
//* All Rights Reserved.
//* This software may be used, modified, and distributed
//* 
//* (provided this notice is included without modification)
//* solely for internal demonstration purposes with other
//* Rocket® products, and is otherwise subject to the EULA at
//* https://www.rocketsoftware.com/company/trust/agreements.
//*
//* THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED
//* WARRANTIES, INCLUDING THE IMPLIED WARRANTIES OF
//* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE,
//* SHALL NOT APPLY.
//*
//* TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL
//* ROCKET SOFTWARE HAVE ANY LIABILITY WHATSOEVER IN CONNECTION
//* WITH THIS SOFTWARE.
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