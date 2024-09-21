@echo off
for /f "tokens=*" %%i in ('type %1') do set last=%%i
echo %last%

