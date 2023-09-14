set COBSW=+S5
set -e
export TERM=xterm-color
export DISPLAY=:0.0
rm -f *.dll *.int *.gnt *.obj *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt *.so *.o *.pgc *.mfu

cob -vgzc getCustomerAccountInfo.cbl -C 'preprocess"mfupp" endp' -C 'sql'
cob -vgzc getCustomerId.cbl -C 'preprocess"mfupp" endp' -C 'sql'
cob -vzUg MFUT_TESTCUSTOMER.cbl getCustomerAccountInfo.o getCustomerId.o

cobmfurun_t -dc:ansi -verbose MFUT_TESTCUSTOMER.so

