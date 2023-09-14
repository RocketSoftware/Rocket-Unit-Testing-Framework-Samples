@del *.dll *.o *.idy *.int *report.txt TEST*.xml *.pdf *.trx tests.html tests.md
cbllink -D -Otests CalcSalesComm.cbl MFUT_TestSalesComm.cbl
@if errorlevel 1 goto theend
mfurun -verbose -dc:ansi -jit:nodebug -report:junit -report:trx -report:markdown tests.dll

:theend

