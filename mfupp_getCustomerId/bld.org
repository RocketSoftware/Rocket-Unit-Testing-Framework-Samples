#!/bin/sh

TEST_NOEXT="MFUT_TESTCUSTOMER"
SRC_NOEXT="getCustomerId getCustomerAccountInfo"
MFUPP_DIR="p(mfupp) verbose mock sql(ignore) endp"

# ensure any copybook can be found
COBCPY=./tests:$COBCPY
export COBCPY

for i in $SRC_NOEXT
do
	echo Compiling : $i.cbl
    if [ -f $i.dir ]
	then
		cob -zU -e "" -C 'use"'$i.dir'"' -C "$MFUPP_DIR" $i.cbl
	else
		cob -zU -e "" -C "$MFUPP_DIR" $i.cbl
	fi
done

# assume all .cbl are to test cases, so compile to shared obj
for i in tests/*.cbl
do
	if [ -f $i ]
	then
		echo Compiling : $i
		cob -zU -C nolitlink -e "" $i
	fi
done

# make it pretty, if we can
MFU_ARG=
if [ "$TERM" = "xterm-256color" ]
then
	cobmfurun | grep diagnostics-color >/dev/null
	test $? -eq 0  && MFU_ARG=-diagnostics-color:ansi
fi

MFU_DD_DIR=$PWD/tests
export MFU_DD_DIR

for i in $TEST_NOEXT
do
	echo Running unit test for $i
	cobmfurun -verbose $MFU_ARG -report:junit -report:printfile -outdir:results $i.so
	rm -f $i.o $i.int $i.idy $i.so
	echo
done
