@echo off
setlocal EnableDelayedExpansion
cls
goto :main

:lengthFunction <codeVar> <codeLenVar>
(
	set /a %~2=0
	for /l %%i in ( 0, 1, 8190) do (
		if "!%~1:~%%i,1!" neq "" (
			set /a %~2+=1
		)
	)
	REM echo Len !%~2!
)
goto :eof

:databaseFunction

goto :eof

:main
setlocal

	REM set database=..........0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	set database=..........abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	set /p "code=Code: "
	set /p decrypt=Decrypt your password: 
	
	call :lengthFunction database databaseLen
	set /a databaseLen-=1
	call :lengthFunction decrypt codeLenVar
	REM set /a codeLenVar-=1
	
	
	for /l %%g in ( 10, 1, !databaseLen! ) do (
		for /f %%h in ( "!database:~%%g,1!" ) do (
			set /a MATH=%%g*!code!
			for /f %%m in ( "!MATH!" ) do (
				set "decrypt=!decrypt:%%m=%%h!"
			)
		)
	)
	cls
	for /f %%m in ( "!decrypt!" ) do (
		set "decrypt=!decrypt:-=!"
	)
	echo !decrypt!
	set "decrypt="
endlocal
goto :main
:eof
