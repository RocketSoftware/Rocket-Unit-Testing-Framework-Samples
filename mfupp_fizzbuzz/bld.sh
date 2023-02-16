#!/bin/sh

TEST_NOEXT="fizzbuzz"
SRC_NOEXT="$TEST_NOEXT"
MFUPP_DIR="p(mfupp) verbose endp"

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

# make it pretty, if we can
MFU_ARG=
if [ "$TERM" = "xterm-256color" ]
then
	cobmfurun | grep diagnostics-color >/dev/null
	test $? -eq 0  && MFU_ARG=-diagnostics-color:ansi
fi

for i in $TEST_NOEXT
do
	echo Running unit test for $i
	cobmfurun -verbose $MFU_ARG -report:junit -report:printfile -outdir:results $i.so
	rm -f $i.o $i.int $i.idy $i.so
	echo
done
