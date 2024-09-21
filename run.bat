
@echo off
REM Check if the input file is provided
if "%1"=="" (
    echo Please provide the C/C++ source file.
    exit /b 1
)

REM Get the filename without extension
set filename=%~n1

REM Compile the source file
gcc -DNDEBUG -O2 "%1" -o "%filename%.exe"

REM Check if compilation was successful
if errorlevel 1 (
    echo Compilation failed.
    exit /b 1
)

REM Run the executable
"%filename%.exe"
echo.
