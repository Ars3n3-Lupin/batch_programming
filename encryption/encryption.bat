@echo off
setlocal EnableDelayedExpansion
cls
goto :main

:length <inputVar> <inputLenVar>
(
	set /a %2=0
	for /l %%i in ( 0, 1, 8191) do (
		if "!%1:~%%i,1!" neq "" (
			set /a %2+=1
		)
	)
	echo Len !%~2!
)
goto :eof

:main
setlocal

	set database=..........0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
	set /p input=Encrypt your password: 
	
	call :length input inputLenVar

	for /l %%g in ( 10, 1, 94 ) do (
		for /f %%h in ( "!database:~%%g,1!" ) do (
			REM set "input=!input:%%h=-%%g!"
			
			for /l %%i in ( 0, 1, !inputLenVar! ) do (
				if "!input:~%%i,1!" neq "" (
					if "!input:~%%i,1!" == "!database:~%%g,1!"  (
					set "input=!input:%%h=%%g!"
					)
				)
			)
		)
	)
	cls
	echo !inputLenVar!
	echo !input!
	set "input="
endlocal
goto :main
:eof
