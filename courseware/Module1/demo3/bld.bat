del *.dll *.o *.idy *.int *report.txt TEST*.xml *.pdf *.trx tests.html tests.md
cbllink -V -D -Otests CalcSalesComm.cbl MFUT_mytest.cbl MFUT_AlwaysBroken.cbl
if errorlevel 1 goto theend
mfurun -verbose -dc:ansi -jit:nodebug -report:junit -report:trx -report:markdown tests.dll

:theend

