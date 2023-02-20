
@del test*.xml *SYSOUT *SYSPRINT *JESYSMSG *RPTADVA *RPTADVB *RPTFBM *RPTLINB *RPTLINA JCL_EXAMPLES.md JCL_EXAMPLES-report.txt JCL_EXAMPLES.mfu >nul

cbllink -D -UMFJDEMO.dir MFJDEM10.CBL
@if errorlevel 1 goto theend

cbllink -D -UMFJDEMO.dir MFJDEM12.CBL
@if errorlevel 1 goto theend

cbllink -D -UMFJDEMO.dir MFJDEMUT.CBL
@if errorlevel 1 goto theend

cbllink -D JCL_EXAMPLES.cbl
@if errorlevel 1 goto theend

mfurun -generate-mfu JCL_EXAMPLES.dll
@if errorlevel 1 goto theend

@echo.
@echo INFO:
@echo        Remember to copy MFJDEM10.dll, MFJDEM12.dll and MFJDEMUT.dll to your 
@echo        region bin area and follow the instructions in DEM00.JCL
@echo.
:theend