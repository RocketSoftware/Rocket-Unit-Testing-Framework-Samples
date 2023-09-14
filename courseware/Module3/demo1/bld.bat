

@set COBSW=+S5
@del *.dll *.int *.gnt *.obj *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt

cbllink -D fizzbuzz.cbl
run fizzbuzz 10 20

@REM cobol fizzbuzz.cbl  omf(obj) verbose preprocess"mfupp" verbose endp;
@REM cbllink -D fizzbuzz.obj
@REM if errorlevel 1 goto theend
@REM mfurun -verbose -dc:ansi fizzbuzz.dll

:theend
