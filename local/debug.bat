@echo off
:: --- raddbg Debug Script ---
:: Usage: debug or debug raddbg

:: Unpack arguments
for %%a in (%*) do set "%%a=1"
if not "%raddbg%"=="1" set raddbg=1

:: --- Set executable and raddbg project paths ---
set exe=%_build_%\%_project_name_%.exe
set raddbg_flags=--project:%_config_%\project.raddbg %exe%

:: --- Run raddbg debugger ---
if "%raddbg%"=="1" (
    echo [raddbg debug]
    pushd %_build_%
    start raddbg %raddbg_flags%
    popd
)

:: --- Cleanup ---
set exe=
set raddbg=
set raddbg_flags=
