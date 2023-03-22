@echo off
setlocal

set TARGET=native
:top_args
if .%1 == . goto args_end
if /I .%1 == .jvm (
  set TARGET=jvm
  goto arg_okay
  )

if /I .%1 == .net6 (
  set TARGET=net6
  goto arg_okay
  )

echo Invalid argument %1 
goto theend

:arg_okay
shift
goto top_args
:args_end

echo TARGET is %TARGET%

set COBCPY=%CD%\cpylib;%CD%\tests;%COBCPY%;.
set "MFUPP_DIR=p(mfupp) CONFIRM VERBOSE endp"

set MFU_DS=%CD%\tests

goto bld_%TARGET%

:check_native_extra
for /f "tokens=4-5 delims= " %%i in ('ver') do (
  if "%%j"=="" (set v=%%i) else (set v=%%j)
)
for /f "tokens=1-3 delims=.]" %%i in ("%v%") do (
  set OS_VER_MAJOR=%%i
  set OS_VER_MINOR=%%j
  set OS_BUILD_NUM=%%k
)
if %OS_VER_MAJOR% == 10 (
    set extra_arg=-dc:windows10 
)
if NOT .%WT_SESSION% == . (
    set extra_arg=-dc:ansi
)
goto theend

:check_jvm_extra
if NOT .%WT_SESSION% == . (
    set extra_arg=-dc:ansi
)
goto theend

:bld_native
call :check_native_extra
echo Compiling Sources:
for %%i in (*.cbl) do cobol %%i omf(obj) anim %MFUPP_DIR%;
dir/b *.obj >examples.lnk
cbllink -Dexamples.dll @examples.lnk
rem mfurun -generate-mfu examples.dll
mfurun %extra_arg% -report:junit -jit:nodebug -verbose examples.dll
@REM @del examples.mfu examples.dll *.obj *.idy examples.lnk examples.mfgcf
goto theend

:bld_jvm
call :check_jvm_extra
mkdir jbin >nul: 2>&1
for %%i in (*.cbl) do cobol %%i jvmgen(sub) anim  iloutput"jbin" ilnamespace"com.microfocus.test" %MFUPP_DIR%;
jar cvf  examples.jar -C jbin .
call mfjarprogmap.bat -jar examples.jar
@REM call mfurunj -generate-mfu examples.jar
call mfurunj.bat %extra_arg% -report:junit -verbose examples.jar

@del examples.mfu examples.jar *.obj *.idy examples.lnk examples.mfgcf
goto theend

:bld_net6
pushd dn6
dotnet build /t:rebuild /t:run
dotnet build /t:clean
popd
goto theend
:theend

