//MFJDEM04 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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