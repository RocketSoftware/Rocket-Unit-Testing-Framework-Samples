//MFJDEM05 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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