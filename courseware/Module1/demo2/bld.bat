set COBSW=+S5
cbllink -D MFUT_mytest.cbl CalcSalesComm.cbl 
if errorlevel 1 goto theend
mfurun -verbose -jit:nodebug -dc:ansi MFUT_mytest.dll

:theend
