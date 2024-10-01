//MFJDEM12 JOB 'Rocket',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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
//*   -  SUPPORT FOR INSTREAM JCL PROCS AND SYMBOLIC PARAMETERS
//*   -  SUPPORT FOR "SYSOUT=*,CHARS=XXXX,COPIES=X" JCL OPERANDS
//*   -  SUPPORT FOR BOTH ANSI (FBA) AND MACHINE (FBM) PRINT FILES
//*   -  SUPPORT FOR WRITE AFTER/BEFORE ADVANCING AND LINAGE CLAUSES
//*
//* BEFORE RUNNING:
//*
//*   -  REVIEW         PROJECT-PROJECT-SETTINGS-BATCH
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM12.JCL
//*   -  ADD-TO-PROJ    ..\JCL-examples\MFJDEM12.CBL
//*   -  COMPILE        ..\JCL-examples\MFJDEM12.CBL
//*
//* ------------------------------------------------------------------
//*
//INSTREAM PROC SOUT='*',
//             RPTCLASS=S
//INSTRS01 EXEC PGM=MFJDEM12,
//             PARM='JOB MFJDEM12 PROC INSTREAM'
//SYSOUT    DD SYSOUT=&SOUT
//RPTADVA   DD SYSOUT=&RPTCLASS
//RPTADVB   DD SYSOUT=&RPTCLASS
//RPTLINA   DD SYSOUT=&RPTCLASS
//RPTLINB   DD SYSOUT=&RPTCLASS
//RPTFBM    DD SYSOUT=&RPTCLASS,
//             DCB=(RECFM=FBM,LRECL=133)
//         PEND
//*
//* ------------------------------------------------------------------
//*
//STEP01   EXEC INSTREAM,
//             RPTCLASS='S,CHARS=LAND,COPIES=1'
//*
//
