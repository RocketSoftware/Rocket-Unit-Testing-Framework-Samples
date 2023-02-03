@echo off
setlocal
for /f "tokens=4-5 delims= " %%i in ('ver') do (
  if "%%j"=="" (set v=%%i) else (set v=%%j)
)
for /f "tokens=1-3 delims=.]" %%i in ("%v%") do (
  set OS_VER_MAJOR=%%i
  set OS_VER_MINOR=%%j
  set OS_BUILD_NUM=%%k
)

if %OS_VER_MAJOR% == 10 (
    set extra_arg= -dc:windows10 
)

echo Compiling Sources:
for %%i in (MFUT*.cbl) do cobol %%i omf(obj) anim sourceformat"variable";
dir/b *.obj >examples.lnk
cbllink -Dexamples.dll @examples.lnk
mfurun -generate-mfu examples.dll
mfurun %extra_arg% -report:junit -jit:nodebug -verbose examples.mfu
@del examples.mfu examples.dll *.obj *.idy examples.lnk examples.mfgcf
:theend

