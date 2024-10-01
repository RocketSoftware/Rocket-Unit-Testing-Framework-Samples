//MFJDEM04 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR JCL DISPOSITION PROCESSING
//*   -  DETECTION OF A DUPLICATE DSN JCL ERROR
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM04.JCL
//*
//* SPECIAL NOTES:
//*
//*   -  THIS JOB WILL FAIL WITH A DUPLICATE DATASET JCL ERROR
//*   -  COMMENT OUT STEP02.DD2 TO CORRECT THIS AND RESUBMIT
//*
//* ------------------------------------------------------------------
//*
//STEP00   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM04.OUTDATA,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//*
//STEP01   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM04.OUTDATA,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//DD2       DD DSN=JCLDEMO.MFJDEM04.OUTDATA,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*
//STEPBYP  EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM04.OUTDATA,DISP=(MOD,DELETE)
//*
//
