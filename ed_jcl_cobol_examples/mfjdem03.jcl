//MFJDEM03 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*
//* ------------------------------------------------------------------
//*<CR_TAG_JCL\>
//*
//* Copyright (C) Micro Focus 1984 - 2019 or one of its affiliates.
//* This sample code is supplied for demonstration purposes only
//* on an "as is" basis and "is for use at your own risk".
//*
//*<CR_TAG_JCL_END\>
//* -----------------------------------------------------------------
//*
//* DEMONSTRATES THE FOLLOWING:
//*
//*   -  SUPPORT FOR IEFBR14 (ALIAS MFJBR14)
//*   -  SUPPORT FOR JCL DISPOSITION PROCESSING
//*   -  DETECTION OF A PROGRAM NOT FOUND JCL ERROR
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM03.JCL
//*
//* SPECIAL NOTES:
//*
//*   -  THIS JOB WILL NOT RUN BECAUSE PGM=XXXXXXXX DOES NOT EXIST
//*   -  JCLDEMO.MFJDEM03.OUTDATA1,DISP=(NEW,CATLG,CATLG)  IS CREATED
//*   -  JCLDEMO.MFJDEM03.OUTDATA2,DISP=(NEW,CATLG,DELETE) IS NOT
//*
//* -----------------------------------------------------------------
//*
//STEP00   EXEC PGM=IEFBR14
//DD1       DD DSN=JCLDEMO.MFJDEM03.OUTDATA1,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//DD2       DD DSN=JCLDEMO.MFJDEM03.OUTDATA2,DISP=(MOD,DELETE),
//             SPACE=(TRK,1)
//*
//STEP01   EXEC PGM=XXXXXXXX
//DD1       DD DSN=JCLDEMO.MFJDEM03.OUTDATA1,DISP=(NEW,CATLG,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//DD2       DD DSN=JCLDEMO.MFJDEM03.OUTDATA2,DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*
//STEPBYP  EXEC PGM=IEFBR14
//*
//STEPLAST EXEC PGM=IEFBR14,COND=ONLY
//DD1       DD DSN=JCLDEMO.MFJDEM03.OUTDATA1,DISP=(OLD,DELETE)
//*
//
