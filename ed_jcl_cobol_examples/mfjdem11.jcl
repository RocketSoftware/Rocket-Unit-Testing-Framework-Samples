//MFJDEM11 JOB 'MICRO FOCUS',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR CATALOGED JCL PROCEDURES
//*   -  SYMBOLIC PARAMETER SUBSTITUTION
//*
//* BEFORE RUNNING:
//*
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM11.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.PRC
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEMUT.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEMUT.CBL
//*   -  ADD-EXISTING   DSN=MFJDEM.PERMNENT.JCLDEMO.DATA
//*                         FILENAME=..\JCL-examples\DATA\MFJDEMO.DAT
//*                         DSORG=PS,RECFM=FB,LRECL=80,CHARSET=EBCDIC
//*   - DEFINE DYNAMIC PDS, DSN=MFE.PROCLIB.L01
//*                         FILENAME=<CATALOGFOLDER>\
//*                         DSORG=PO,RECFM=LSEQ,LRECL=80
//*                         DYNAMIC PDS EXTENSION=PRC
//*   NOTE: THIS WILL ADD THE MFJDEMUT.PRC AS A MEMBER OF THE
//*   MFE.PROCLIB.L01 PDS
//*
//* ------------------------------------------------------------------
//*
//MYLIBS1  JCLLIB ORDER=MFE.PROCLIB.L01,SYS1.PROCLIB
//STEP01   EXEC MFJDEMUT,
//             SOUT=C,
//             SYSUT1='MFJDEM.PERMNENT.JCLDEMO.DATA'
//