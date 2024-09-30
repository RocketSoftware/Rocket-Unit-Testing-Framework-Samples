#!/bin/sh

SRC_NOEXT="MFUT_MyFirstFail"
TARGET=native
MFU_ARG=
NAME=MyFirstFail

if [ "$TERM" = "xterm-256color" ]
then
	MFU_ARG=-diagnostics-color:ansi
fi

for i in $*
do
	case .$i in
		.native) TARGET=native ;;
		.jvm) TARGET=jvm ;;
		.net8) TARGET=net8 ;;
		*) echo $0: Invalid argument $i
		   exit 1 
		   ;;
	esac
done

JUNIT_PACKAGE=com.rocketsoftware.sample.$TARGET
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
		#rm -f $i.o $i.int $i.idy $i.so
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
			cob -j -C 'use"'$i.dir'"' -C iloutput\"jbin\" -C ilnamespace\"com.rocketsoftware.test\" $i.cbl
		else
			cob -j -C iloutput\"jbin\" -C ilnamespace\"com.rocketsoftware.test\" $i.cbl
		fi
	done

	jar cvf  examples.jar -C jbin .
	mfjarprogmap -jar examples.jar
	cobmfurunj -verbose $MFU_ARG $REPORT_ARGS -outdir:results examples.jar
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

echo TARGET is $TARGET

bld_$TARGET
