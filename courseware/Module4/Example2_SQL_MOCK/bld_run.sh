set -e
rm -f *.mfupp-et *.mfupp.txt *snippet *.?nt *.idy *report.txt FRED.cbl
cob -via -C 'use(ScanEmployeeTable.dir)' -C 'SQL(ODBC BEHAVIOR==OPTIMIZED)' -C REENTRANT  ScanEmployeeTable.cbl
cobrun ScanEmployeeTable
