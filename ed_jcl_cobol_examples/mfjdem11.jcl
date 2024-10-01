//MFJDEM11 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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