//MFJDEM10 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR IDCAMS (ALIAS MFJAMS) COMMANDS
//*   -  DELETE ENTRY AND SET MAXCC CONDITION CODE TO ZERO
//*   -  DEFINE CLUSTER/AIX/PATH, LISTCAT, REPRO, AND PRINT
//*   -  SUPPORT FOR BOTH EXPLICIT DSN AND DDNAME REFERENCES
//*   -  PROGRAM ACCESS VIA VSAM PRIMARY AND ALTERNATE KEYS
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM10.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM10.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEM10.CBL
//*
//* ------------------------------------------------------------------
//*
//STEP00   EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  DELETE JCLDEMO.MFJDEM10.KSDS
  SET    MAXCC=0
  DEFINE CLUSTER (NAME(JCLDEMO.MFJDEM10.KSDS)        -
                  TRACKS(1 1)                        -
                  KEYS(20 0)                         -
                  RECSZ(80 80))
  DEFINE AIX     (NAME(JCLDEMO.MFJDEM10.KSDS.AIX1)   -
                  TRACKS(1 1)                        -
                  RELATE(JCLDEMO.MFJDEM10.KSDS)      -
                  KEYS(10 20)                        -
                  UNIQUEKEY)
  DEFINE AIX     (NAME(JCLDEMO.MFJDEM10.KSDS.AIX2)   -
                  TRACKS(1 1)                        -
                  RELATE(JCLDEMO.MFJDEM10.KSDS)      -
                  KEYS(10 30)                        -
                  NONUNIQUEKEY)
  DEFINE PATH    (NAME(JCLDEMO.MFJDEM10.KSDS.PTH1)   -
                  PENT(JCLDEMO.MFJDEM10.KSDS.AIX1))
  DEFINE PATH    (NAME(JCLDEMO.MFJDEM10.KSDS.PTH2)   -
                  PENT(JCLDEMO.MFJDEM10.KSDS.AIX2))
  LISTC  LVL     (JCLDEMO.MFJDEM10.KSDS)
  REPRO  IFILE   (VSAMDATA)                          -
         ODS     (JCLDEMO.MFJDEM10.KSDS)             -
         REPLACE
  PRINT  IDS     (JCLDEMO.MFJDEM10.KSDS)             -
         COUNT   (2)
//VSAMDATA  DD *
VSAM-KSDS-RECORD01  AX1-KEY05 AX2-KEYZZ
VSAM-KSDS-RECORD02  AX1-KEY04 AX2-KEYAA
VSAM-KSDS-RECORD03  AX1-KEY03 AX2-KEYZZ
VSAM-KSDS-RECORD04  AX1-KEY02 AX2-KEYAA
VSAM-KSDS-RECORD05  AX1-KEY01 AX2-KEYZZ
//*
//STEP01   EXEC PGM=MFJDEM10,PARM='ALT1'
//*            PARM='JOB MFJDEM10 STEP01'
//*            PARM='ALT1'
//*            PARM='ALT2'
//SYSPRINT  DD SYSOUT=*
//SYSOUT    DD SYSOUT=*
//KSDSFILE  DD DSN=JCLDEMO.MFJDEM10.KSDS,DISP=SHR
//*
//STEPLAST EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  DELETE JCLDEMO.MFJDEM10.KSDS
  SET    MAXCC=0
//
