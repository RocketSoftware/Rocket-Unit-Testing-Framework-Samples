#!/bin/sh

TEST_NOEXT="MFUT_TESTCUSTOMER"
SRC_NOEXT="getCustomerId getCustomerAccountInfo"
TARGET=native
MFUPP_DIR="-C p(mfupp) verbose mock sql(ignore) endp"
MF_RM="rm -f"
NAME=customerid

. ./bld_is_enterprise.sh
if [ "x$_SQLCA_FILE" = "x" ]
then
	echo Sorry demo $NAME is not supported for use with this product
	exit 1
fi

# ensure any copybook can be found
COBCPY=./tests:$COBCPY
export COBCPY

MFU_DD_DIR=$(pwd)/tests
export MFU_DD_DIR

# make it pretty, if we can
MFU_ARG=
if [ "$TERM" = "xterm-256color" ]
then
	cobmfurun | grep diagnostics-color >/dev/null
	test $? -eq 0  && MFU_ARG=-diagnostics-color:ansi
fi

bld_native() {
	# assume all .cbl are to test cases, so compile to shared obj
	for i in tests/*.cbl
	do
		if [ -f $i ]
		then
			echo Compiling : $i
			cob -zU -C nolitlink -e "" $i
		fi
	done

	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -zUg -e "" -C 'use"'$i.dir'"' "$MFUPP_DIR" $i.cbl
		else
			cob -zUg -e "" "$MFUPP_DIR" $i.cbl
		fi
	done
	for i in $TEST_NOEXT
	do
		echo Running unit test for $i
		cobmfurun -verbose $MFU_ARG $REPORT_ARGS -outdir:results $i.so
		$MF_RM $i.o $i.int $i.idy $i.so
		echo
	done
}

bld_jvm() {
	rm -rf jbin
	mkdir -p jbin	
	
	for i in tests/*.cbl
	do
		if [ -f $i ]
		then
			echo Compiling : $i
			cob -vj -C nolitlink -C iloutput\"jbin\" -C ilnamespace\"com.rocketsoftware.test\" "$MFUPP_DIR" $i
		fi
	done

	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -vj -C 'use"'$i.dir'"' -C iloutput\"jbin\" -C ilnamespace\"com.rocketsoftware.test\" "$MFUPP_DIR" $i.cbl
		else
			cob -vj -C iloutput\"jbin\" -C ilnamespace\"com.rocketsoftware.test\" "$MFUPP_DIR" $i.cbl
		fi
	done

	jar cvf examples.jar -C jbin .
	mfjarprogmap -jar examples.jar
	cobmfurunj $MFU_ARG $REPORT_ARGS -outdir:results examples.jar
	$MF_RM $i.o $i.int $i.idy $i.so examples.jar
}

bld_net8() {
	cd dn8
	dotnet build /t:rebuild "/p:MFUnitRunnerCommandGenerateArguments=$REPORT_ARGS" /t:run
	dotnet build /t:clean
	cd ..
	mkdir -p results
	cp dn8/bin/*/net8.0/TEST*.xml results/
	cp dn8/bin/*/net8.0/*-report.txt results/
}

for i in $*
do
	case .$i in
		.native) TARGET=native ;;
		.jvm) TARGET=jvm ;;
		.net8) TARGET=net8 ;;
		.norm) MF_RM="echo norm set: leaving files: " ;;
		*) echo $0: Invalid argument $i
		   exit 1 
		   ;;
	esac
done

JUNIT_PACKAGE=com.rocketsoftware.sample.$TARGET
REPORT_NAME=${NAME}_${TARGET}-report.txt
REPORT_ARGS="-report:junit -junit-packname:$JUNIT_PACKAGE -report:printfile -reportfile:$REPORT_NAME"

echo TARGET is $TARGET

bld_$TARGET
