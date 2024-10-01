//MFJDEM06 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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