//MFJDEM02 JOB 'Open Text',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
//*
//* ------------------------------------------------------------------
//*<CR_TAG_JCL\>
//*
//* Copyright (C) Open Text 1984 - 2019 or one of its affiliates.
//* This sample code is supplied for demonstration purposes only
//* on an "as is" basis and "is for use at your own risk".
//*
//*<CR_TAG_JCL_END\>
//* ------------------------------------------------------------------
//*
//* DEMONSTRATES THE FOLLOWING:
//*
//*   -  PARAMETER PASSING
//*   -  DISPLAY UPON CONSOLE SCREEN MANAGEMENT
//*   -  INSTREAM DATA (DD *) IS ASCII LINE SEQUENTIAL FORMAT
//*   -  INSTREAM DATA CONVERTED TO EBCDIC BEFORE INPUT TO PROGRAM
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM02.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEMUT.CBL
//*
//* ------------------------------------------------------------------
//*
//STEP01   EXEC PGM=MFJDEMUT,
//             PARM='JOB MFJDEM02 STEP01'
//SYSOUT    DD SYSOUT=*
//SYSUT1    DD *
MFJDEM02 STEP01 INSTREAM DATA RECORD 01
MFJDEM02 STEP01 INSTREAM DATA RECORD 02
MFJDEM02 STEP01 INSTREAM DATA RECORD 03
MFJDEM02 STEP01 INSTREAM DATA RECORD 04
MFJDEM02 STEP01 INSTREAM DATA RECORD 05
//SYSUT2    DD DUMMY
//*
//
