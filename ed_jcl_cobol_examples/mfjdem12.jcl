//MFJDEM12 JOB 'Open Text',CLASS=A,MSGCLASS=A,NOTIFY=&SYSUID
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