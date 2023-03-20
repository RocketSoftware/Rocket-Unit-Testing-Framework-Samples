#!/bin/sh

SRC_NOEXT="MFUT_MyFirstTest"
TARGET=native
MFU_ARG=
NAME=MyFirstTest
MF_RM="rm -f"

if [ "x$TERM" = "xxterm-256color" ]
then
	MFU_ARG=-diagnostics-color:ansi
fi

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

bld_native() {
	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -Ug -C 'use"'$i.dir'"' -z -e "" $i.cbl
		else
			cob -zgU -e "" $i.cbl
		fi
	done


	for i in $SRC_NOEXT
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
	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -j -C 'use"'$i.dir'"' -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" $i.cbl
		else
			cob -j -C iloutput\"jbin\" -C ilnamespace\"com.microfocus.test\" $i.cbl
		fi
	done

	jar cvf  examples.jar -C jbin .
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

echo TARGET is $TARGET

bld_$TARGET
