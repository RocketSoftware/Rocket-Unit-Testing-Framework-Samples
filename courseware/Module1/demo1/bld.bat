set COBSW=+S5
cbllink -D MFUT_mytest.cbl
@REM if errorlevel 1 goto theend
@REM mfurun -verbose -jit:nodebug -dc:ansi MFUT_mytest.dll

@REM :theend
