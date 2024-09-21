@echo off
for /L %%n in (1,1,%2) do (
    for /f "tokens=*" %%i in ('findstr /n "^" %1') do (
        if %%n leq %2 echo %%i
    )
)

