

set COBSW=+S5
del *.dll *.int *.gnt *.obj *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt

cobol fizzbuzz.cbl preplist"fizzbuzz.prep" verbose preprocess"mfupp" "INC_PROC_COPYBOOK(MFUT_FIZZBUZZ)" verbose endp int() verbose list"fizzbuzz.lst";

REM cobol fizzbuzz.cbl omf(obj);
if errorlevel 1 goto theend

cbllink -D fizzbuzz.obj
if errorlevel 1 goto theend

run fizzbuzz 10 20

REM mfurun -verbose -jit:nodebug -redirect:true MFUT_TESTCUSTOMER
mfurun -verbose -dc:ansi -redirect:true fizzbuzz

:theend
