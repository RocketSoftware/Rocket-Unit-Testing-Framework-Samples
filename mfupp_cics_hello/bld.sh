#!/bin/sh
rm -f ./*.int ./*.so ./*.mfupp.txt ./*.lst
COBCPY=$(pwd)/tests:$(pwd)/cpylib:.:$COBCPY
export COBCPY

for i in CICSHello
do
	cob -via -C "P(mfupp) CONFIRM VERBOSE CICS(IGNORE) MOCK(CICS) EXEC-REPORT-FILE P(cp) ENDP" $i.cbl 
done
cob -zg -e "" -o tests.so ./*.int

# ensure we can find the .csv files
MFU_DS=$(pwd)/tests:
export MFU_DS


cobmfurun -report:junit -outdir:results -junit-packname:com.microfocus.mfunit.cics.bankdemo. -verbose tests.so

rm -f ./TEST*xml
rm -f  ./*.int ./*.so ./*.mfupp-et ./*.o ./*.idy
