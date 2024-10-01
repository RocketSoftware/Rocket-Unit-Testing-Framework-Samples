//MFJDEMUT PROC SOUT='*',
//             SYSUT1=NULLFILE,
//             SYSUT2=NULLFILE
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
//* ------------------------------------------------------------------
//*        MFJDEMUT.PRC: DISPLAY THE CONTENTS OF A DATASET
//*            SYSUT1    DEFINES THE INPUT DATASET TO DISPLAY
//*            SYSUT2    DEFINES THE OPTIONAL OUTPUT DATASET
//* ------------------------------------------------------------------
//*
//DEMUTS01 EXEC PGM=MFJDEMUT
//SYSOUT    DD SYSOUT=&SOUT
//SYSUT1    DD DSN=&SYSUT1,DISP=SHR
//SYSUT2    DD DSN=&SYSUT2,DISP=(NEW,CATLG),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=F,LRECL=80)
//*        PEND
