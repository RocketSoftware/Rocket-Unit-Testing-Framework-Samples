//MFJDEM01 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  PARAMETER PASSING
//*   -  DISPLAY UPON CONSOLE SCREEN MANAGEMENT
//*   -  FILE ACCESS VIA JCL USING MVS DATA SET NAMES
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
//STEP01   EXEC PGM=MFJDEMUT,
//             PARM='JOB MFIDSAD1 STEP01'
//SYSOUT    DD SYSOUT=*
//SYSUT1    DD DSN=MFJDEM.PERMNENT.JCLDEMO.DATA,DISP=SHR
//SYSUT2    DD DUMMY
//*
//
