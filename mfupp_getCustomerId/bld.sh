#!/bin/sh

TEST_NOEXT="MFUT_TESTCUSTOMER"
SRC_NOEXT="getCustomerId getCustomerAccountInfo"
MFUPP_DIR="-C p(mfupp) verbose mock sql(ignore) endp"
MF_RM="rm -f"
TARGET=native

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
		cobmfurun -verbose $MFU_ARG -report:junit -report:printfile -outdir:results $i.so
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

echo TARGET is $TARGET

bld_$TARGET
