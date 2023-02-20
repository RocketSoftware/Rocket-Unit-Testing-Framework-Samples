//MFJDEM08 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR IDCAMS (ALIAS MFJAMS) DELETE/DEFINE OPERATIONS
//*   -  CREATION OF A GENERATION DATASET GROUP (GDG) MODEL ENTRY
//*   -  SUPPORT FOR IEBGENER (ALIAS MFJGENER) COPY OPERATION
//*   -  CREATION OF A GENERATION DATASET GROUP (GDG) BIAS ENTRY
//*   -  SUPPRESSION OF SYSPRINT BY THE SYSOUT MANAGER
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM08.JCL
//*
//* ------------------------------------------------------------------
//*
//STEP00   EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  DELETE JCLDEMO.MFJDEM08.GDGMODEL                   -
         FORCE
  DEFINE GDG (NAME(JCLDEMO.MFJDEM08.GDGMODEL)        -
              LIMIT(3)                               -
              SCRATCH)
  SET    MAXCC=0
//*
//STEP01   EXEC PGM=IEBGENER
//SYSPRINT  DD SYSOUT=*
//SYSUT1    DD *
MFJDEM08 STEP01 INSTREAM DATA RECORD 01
MFJDEM08 STEP01 INSTREAM DATA RECORD 02
MFJDEM08 STEP01 INSTREAM DATA RECORD 03
MFJDEM08 STEP01 INSTREAM DATA RECORD 04
MFJDEM08 STEP01 INSTREAM DATA RECORD 05
//SYSUT2    DD DSN=JCLDEMO.MFJDEM08.GDGMODEL(+1),DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//SYSIN     DD DUMMY
//*
//STEP02   EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//GDGBIAS   DD DSN=JCLDEMO.MFJDEM08.GDGMODEL(+1),DISP=SHR
//SYSIN     DD *
  PRINT  IFILE (GDGBIAS)                             -
         CHAR
//*
//STEPLAST EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  DELETE JCLDEMO.MFJDEM08.GDGMODEL                   -
         FORCE
//*
//
