//MFJDEM05 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR IEFBR14 (ALIAS MFJBR14)
//*   -  SUPPORT FOR DATASET ALLOCATION AND DELETION VIA DISPOSITION
//*   -  DEFERRED DD DEFINITION USING THE 'DDNAME=' OPERAND
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM05.JCL
//*
//* ------------------------------------------------------------------
//*
//STEP00   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM05.OUTDATA1,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//DD2       DD DSN=JCLDEMO.MFJDEM05.OUTDATA2,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//*
//STEP01   EXEC PGM=IEFBR14
//DDDEFER   DD DDNAME=DD2
//DD1       DD DSN=JCLDEMO.MFJDEM05.OUTDATA1,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//DD2       DD DSN=JCLDEMO.MFJDEM05.OUTDATA2,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*
//STEPLAST EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM05.OUTDATA1,DISP=(OLD,DELETE)
//DD2       DD DSN=JCLDEMO.MFJDEM05.OUTDATA2,DISP=(OLD,DELETE)
//*
//
