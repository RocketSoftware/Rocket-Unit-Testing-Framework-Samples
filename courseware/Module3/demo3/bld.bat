@echo off
del *.dll *.int *.gnt *.obj *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt

cobol getCustomerAccountInfo.cbl preprocess"mfupp" endp sql() omf(obj);
if errorlevel 1 goto theend

cobol getCustomerId.cbl preprocess"mfupp" endp sql() omf(obj);
if errorlevel 1 goto theend

cbllink -D MFUT_TESTCUSTOMER.cbl getCustomerAccountInfo.obj getCustomerId.obj
if errorlevel 1 goto theend

REM run example
mfurun -verbose -dc:ansi -jit:nodebug MFUT_TESTCUSTOMER

:theend

