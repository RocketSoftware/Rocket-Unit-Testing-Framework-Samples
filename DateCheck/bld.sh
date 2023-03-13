#!/bin/sh

SRC_NOEXT="MFUT_DATECHK"
TARGET=native
MFU_ARG=
MF_RM="rm -f"

if [ "$TERM" = "xtemrm-256color" ]
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

bld_native() {
	for i in $SRC_NOEXT
	do
		echo Compiling : $i.cbl
		if [ -f $i.dir ]
		then
			cob -Ug -C 'use"'$i.dir'"' -z -e "" $i.cbl
		else
			cob -zU -e "" $i.cbl
		fi
	done


	for i in $SRC_NOEXT
	do
		echo Running unit test for $i
		cobmfurun -verbose $MFU_ARG -report:junit -report:printfile -outdir:results $i.so
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
	cobmfurunj $MFU_ARG -report:junit -verbose -report:junit -report:printfile -outdir:results examples.jar
	$MF_RM $i.o $i.int $i.idy $i.so examples.jar
}

bld_net6() {
	cd dn6
	dotnet build /t:rebuild /t:run
	dotnet build /t:clean
	cd ..
	mkdir -p results
	cp dn6/bin/*/net6.0/TEST*.xml results/
	cp dn6/bin/*/net6.0/*-report.txt results/
}

echo TARGET is $TARGET

bld_$TARGET
