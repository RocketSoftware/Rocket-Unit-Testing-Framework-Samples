set -e
rm -f *.so *.o *.idy *.int
cob -zgtU -o tests.so -e "" CalcSalesComm.cbl MFUT_mytest.cbl MFUT_AlwaysBroken.cbl
# cobmfurun_t -verbose -dc:ansi -report:junit -report:trx -report:markdown tests.so

