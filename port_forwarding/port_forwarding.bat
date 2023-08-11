@echo off
setlocal EnableExtensions

title Show, Add, Delete netsh interface portproxy

set "menuItem[1]=Show port-forwarding"
set "menuItem[2]=Add port-forwaring"
set "menuItem[3]=Delete port-forwarding"

set "Message="
:Menu
cls
:Menu2
echo.%Message%
echo.  Choise option
echo.
set "x=0"
:MenuLoop
set /a "x+=1"
if defined menuItem[%x%] (
    call echo  %x%. %%menuItem[%x%]%%
    goto MenuLoop
)
echo.
:Prompt
set "Input="
set /p "Input=Select your choice:"

:: Validate Input [Remove Special Characters]
if not defined Input goto Prompt
set "Input=%Input:"=%"
set "Input=%Input:^=%"
set "Input=%Input:<=%"
set "Input=%Input:>=%"
set "Input=%Input:&=%"
set "Input=%Input:|=%"
set "Input=%Input:(=%"
set "Input=%Input:)=%"

set "Input=%Input:^==%"
call :Validate %Input%

call :Process %Input%
goto End


:Validate
set "Next=%2"
if not defined menuItem[%1] (
    set "Message=Invalid Input: %1"
    goto Menu
)
if defined Next shift & goto Validate
goto :eof


:Process
set "Next=%2"
call set "menuItem=%%menuItem[%1]%%"

if "%menuItem%" EQU "Show which port is forwarded" ( 
	cls && netsh interface portproxy show all && goto Menu2
)
if "%menuItem%" EQU "Add port to forward" (
	set "listenports=" && set /p listenports="set listenport: " && set "listenaddress=" && set /p listenaddress="set listenaddress: " && set "connectaddress=" && set /p connectaddress="set connectaddress: " && set "connectport=" && set /p connectport="set connectport: " && goto AddPort
)
if "%menuItem%" EQU "Delete port to forward" (
	set "listenports=" && set /p listenports="set listenport: " && set "listenaddress=" && set /p listenaddress="set listenaddress: " && goto DeletePort
)

set "menuItem[%1]="
if defined Next shift & goto Process
goto :eof

:AddPort
netsh interface portproxy add v4tov4 listenaddress=%listenaddress% listenport=%listenports% connectaddress=%connectaddress% connectport=%connectport%  && cls && netsh interface portproxy show all && goto Menu2

:DeletePort
netsh interface portproxy delete v4tov4 listenport=%listenports% listenaddress=%listenaddress% && cls && netsh interface portproxy show all && goto Menu2

:End
endlocal
pause >nul