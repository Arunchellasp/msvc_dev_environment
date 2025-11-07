@echo off
:: Simple build script for main.cpp only (no third-party)

:: --- Unpack arguments
for %%a in (%*) do set "%%a=1"
if not "%msvc%"=="1" set msvc=1
if not "%release%"=="1" set debug=1
if "%debug%"=="1"   set release=0 && echo [debug mode]
if "%release%"=="1" set debug=0 && echo [release mode]
if "%msvc%"=="1"    echo [msvc compile]

:: --- Set compiler flags
set cl_warnings= /WX /W4 /wd4201 /wd4267 /wd4244 /wd4576 /wd4005 /wd4245 /wd4310 /wd4100 /wd4018 /wd4189 /wd4996 /wd4146 /wd4505 /wd4611 /wd4702 /wd4305 /wd4309
set cl_common=   /nologo /MT /EHsc /FC /Z7 /Oi /std:c++20 /D_CRT_SECURE_NO_WARNINGS %cl_warnings%
set cl_debug=    call cl /Od /Ob1 /DBUILD_DEBUG=1 %cl_common%
set cl_release=  call cl /O2 /DBUILD_DEBUG=0 %cl_common%

:: Linker (minimal system libs only)
set cl_link= /link /SUBSYSTEM:console /incremental:no
set cl_out=  /out:

:: --- Choose compiler
if "%msvc%"=="1"      set compile_debug=%cl_debug%
if "%msvc%"=="1"      set compile_release=%cl_release%
if "%msvc%"=="1"      set compile_link=%cl_link%
if "%msvc%"=="1"      set compile_out=%cl_out%
if "%debug%"=="1"     set compile=%cl_debug%
if "%release%"=="1"   set compile=%cl_release%

:: --- Prep build directory
set _build_=build
if not exist "%_build_%" mkdir "%_build_%"
cd /D %~dp0

:: --- Compile main.cpp
pushd %_build_%
del *.pdb >nul 2>&1
%compile% code\main.c %compile_link% %compile_out%main.exe || exit /b 1
popd

:: --- Cleanup env vars
set msvc=
set debug=
set release=
set compile=
set compile_debug=
set compile_release=
set compile_link=
set compile_out=
set _build_=
