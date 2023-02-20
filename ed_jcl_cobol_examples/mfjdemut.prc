//MFJDEMUT PROC SOUT='*',
//             SYSUT1=NULLFILE,
//             SYSUT2=NULLFILE
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
