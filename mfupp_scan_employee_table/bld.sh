#!/bin/sh
rm -f ./*.int ./*.so ./*.mfupp.txt ./*.lst
COBCPY=$(pwd)/tests:$(pwd)/cpylib:.:$COBCPY
export COBCPY

for i in ScanEmployeeTable
do
	cob -via -C "P(mfupp) CONFIRM VERBOSE SQL(IGNORE) MOCK(SQL) P(cp) ENDP" $i.cbl 
done
cob -zg -e "" -o tests.so ./*.int

# ensure we can find the .json files
MFU_DS=$(pwd)/tests
export MFU_DS

cobmfurun -report:junit -outdir:results -junit-packname:com.microfocus.mfunit.sql.scan_employee_table. -verbose tests.so

rm -f ./TEST*xml
rm -f  ./*.int ./*.so ./*.mfupp-et ./*.o ./*.idy
