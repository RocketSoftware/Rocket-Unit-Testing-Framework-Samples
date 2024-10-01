//MFJDEM08 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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