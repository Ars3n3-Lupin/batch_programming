@echo off
setlocal EnableDelayedExpansion
cls
goto :main

:lengthFunction <passVar> <passLenVar>
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
	set /p "pass=Encrypt your password: "

	
	call :lengthFunction database databaseLen
	set /a databaseLen-=1
	call :lengthFunction pass passLenVar
	REM set /a passLenVar-=1

	for /l %%g in ( 10, 1, !databaseLen! ) do (
		for /f %%h in ( "!database:~%%g,1!" ) do (
		
			for /l %%i in ( 0, 1, !passLenVar! ) do (
			
				if "%%h" equ "!pass:~%%i,1!" (
					
					set /a MATH=%%g*!code!
					for /f %%m in ( "!MATH!" ) do (
						set "pass=!pass:%%h=-%%m!"
					)
				)
			)
		)
	)
	cls
	REM echo !passLenVar!
	echo !pass!
	REM set "pass="
endlocal
goto :main
:eof
