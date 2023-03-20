#!/bin/sh
TEST_NOEXT="ScanEmployeeTable"
SRC_NOEXT="$TEST_NOEXT"
TARGET=native
MFUPP_DIR="-C p(mfupp) verbose CONFIRM SQL(IGNORE) MOCK(SQL) endp"
JVMARGS="-C jvmclasspath(mfunit.jar) -C ilref(com.microfocus.cobol.mfunit.internal.mfunit_api_file) -C ilref(com.microfocus.cobol.mfunit.internal.mfunit_pp_runtime)"
MF_RM="rm -f"
NAME=scan_employee_table

# ensure any copybook can be found
COBCPY=./tests:$COBCPY
export COBCPY

MFU_DD_DIR=$(pwd)/tests
export MFU_DD_DIR

# ensure we can find the .json files
MFU_DS=$(pwd)/tests
export MFU_DS

# make it pretty, if we can
MFU_ARG=
if [ "$TERM" = "xterm-256color" ]
then
	cobmfurun | grep diagnostics-color >/dev/null
	test $? -eq 0  && MFU_ARG=-diagnostics-color:ansi
fi

bld_native() {
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
	CLASSPATH=$COBDIR/lib/mfunit.jar:$CLASSPATH
	export CLASSPATH

	rm -rf jbin
	mkdir -p jbin	
	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -vj $JVMARGS -C 'use"'$i.dir'"' -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" "$MFUPP_DIR" $i.cbl
		else
			cob -vj $JVMARGS -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" "$MFUPP_DIR" $i.cbl
		fi
	done

	jar cvf examples.jar -C jbin .
	mfjarprogmap -jar examples.jar
	cobmfurunj -verbose $MFU_ARG $REPORT_ARGS -outdir:results examples.jar
	$MF_RM $i.o $i.int $i.idy $i.so examples.jar
}

bld_net6() {
	cd dn6
	dotnet build /t:clean
	dotnet build /t:rebuild "/p:MFUnitRunnerCommandGenerateArguments=$REPORT_ARGS" /t:run
	cd ..
	mkdir -p results
	cp dn6/bin/*/net6.0/TEST*.xml results/
	cp dn6/bin/*/net6.0/*-report.txt results/
}

for i in $*
do
	case .$i in
		.native) TARGET=native ;;
		.jvm) TARGET=jvm ;;
		.net6) TARGET=net6 ;;
		.norm) MF_RM="echo norm set: leaving files: " ;;
		*) echo $0: Invalid argument $i
		   exit 1 
		   ;;
	esac
done

JUNIT_PACKAGE=com.microfocus.sample.$TARGET
REPORT_NAME=${NAME}_${TARGET}-report.txt
REPORT_ARGS="-report:junit -junit-packname:$JUNIT_PACKAGE -report:printfile -reportfile:$REPORT_NAME"

echo TARGET is $TARGET

bld_$TARGET
