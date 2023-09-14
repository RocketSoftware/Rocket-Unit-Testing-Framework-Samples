set -e
rm -f *.so *.o *.idy *.int tests.trx MyReport.txt tests.md TEST-*.xml
cob -zgtU -o tests.so -e "" *.cbl
cobmfurun_t -verbose -dc:ansi -report:junit -report:trx -report:markdown tests.so

