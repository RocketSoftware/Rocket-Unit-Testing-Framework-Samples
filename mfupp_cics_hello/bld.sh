TARGET=native
SRC_NOEXT="CICSHello"
MFUPP_DIR="-C p(mfupp) CONFIRM VERBOSE CICS(IGNORE) MOCK(CICS) endp"
MF_RM="rm -f"
NAME=cicshello

. ./bld_is_enterprise.sh
if [ "x$_DFHEIBLK_FILE" = "x" ]
then
	echo Sorry demo $NAME is not supported for use with this product
	exit 1
fi


rm -f ./*.int ./*.so ./*.mfupp.txt ./*.lst
COBCPY=$(pwd)/tests:$(pwd)/cpylib:.:$COBCPY
export COBCPY

# ensure we can find the .csv files
MFU_DS=$(pwd)/tests:
export MFU_DS

# make it pretty, if we can
MFU_ARG=
if [ "x$TERM" = "xxterm-256color" ]
then
	cobmfurun | grep diagnostics-color >/dev/null
	test $? -eq 0  && MFU_ARG=-diagnostics-color:ansi
fi

bld_native() {
	set -x
	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		cob -via "$MFUPP_DIR" $i.cbl 

	done
	cob -zg -e "" -o tests.so ./*.int

	cobmfurun -verbose $MFU_ARG $REPORT_ARGS -outdir:results tests.so

	$MF_RM ./TEST*xml
	$MF_RM  ./*.int ./*.so ./*.mfupp-et ./*.o ./*.idy
}


bld_jvm() {
	rm -rf jbin
	mkdir -p jbin	
	
	for i in tests/*.cbl
	do
		if [ -f $i ]
		then
			echo Compiling : $i
			cob -vj -C nolitlink -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" "$MFUPP_DIR" $i
		fi
	done

	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -vj -C 'use"'$i.dir'"' -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" "$MFUPP_DIR" $i.cbl
		else
			cob -vj -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" "$MFUPP_DIR" $i.cbl
		fi
	done

	jar cvf examples.jar -C jbin .
	mfjarprogmap -jar examples.jar
	cobmfurunj $MFU_ARG $REPORT_ARGS -outdir:results examples.jar
	$MF_RM $i.o $i.int $i.idy $i.so examples.jar
}

bld_net6() {
	cd dn6
	dotnet build /t:rebuild "/p:MFUnitRunnerCommandGenerateArguments=$REPORT_ARGS" /t:run
	dotnet build /t:clean
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
REPORT_ARGS="-report:junit -junit-packname:$JUNIT_PACKAGE. -report:printfile -reportfile:$REPORT_NAME"

echo TARGET is $TARGET

bld_$TARGET
