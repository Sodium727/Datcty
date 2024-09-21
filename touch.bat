@echo off
if exist %1 (
    copy /b %1+,, >nul
) else (
    echo.>%1
)

