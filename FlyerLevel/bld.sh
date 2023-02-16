#!/bin/sh

TEST_NOEXT="MFUT_TESTFLYER"
SRC_NOEXT="$TEST_NOEXT GetFlyerLevel"
for i in $SRC_NOEXT
do
	echo Compiling : $i.cbl
    if [ -f $i.dir ]
	then
		cob -U -C 'use"'$i.dir'"' -z -e "" $i.cbl
	else
		cob -zU -e "" $i.cbl
	fi
done

MFU_ARG=
if [ "$TERM" = "xterm-256color" ]
then
	MFU_ARG=-diagnostics-color:ansi
fi

for i in $TEST_NOEXT
do
	echo Running unit test for $i
	cobmfurun -verbose $MFU_ARG -report:junit -report:printfile -outdir:results $i.so
	rm -f $i.o $i.int $i.idy $i.so
	echo
done
