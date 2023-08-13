@echo off
setlocal EnableDelayedExpansion
cls
goto :main

:create_string <var> <cont>
(
	set "string=%~2"
	set /a countbites=5
	
	for /f "usebackq tokens=*" %%a in ( '!string!' ) do (
		if "!string!" EQU "%%~a" (
			set /a countbites=3
		)
		set "string=%%~a"
	)
	echo %~2 >%TEMP%\temptfile.txt
	
	for %%b in ( %TEMP%\temptfile.txt ) do (
		set /a %~1_length=%%~zb - !countbites!
	)
	del %TEMP%\temptfile.txt
	
	set "%~1=!string!"

)
goto :eof


:set_index <vars> <index> <contents>
(
	call :create_string %~1[%~2] "!%~3!"
)
goto :eof

:lengthFunction <characterVar> <characterLen>
(
	set /a %~2=0
	for /l %%y in ( 0, 1, 8190) do (
		if "!%~1:~%%y,1!" neq "" (
			set /a %~2+=1
		)
	)
	REM echo Len !%~2!
)
goto :eof

:array_sets <var> <delimiter> <content>
(
	set "delimiter=%~2"
	set "content=%~3"
	
	call :lengthFunction content contentLength

	
	set /a index=0
	set /a offset=0
	
	for /l %%b in ( 0, 1, !contentLength! ) do (
		set character=!content:~%%b,1!

		if !character! equ !delimiter! (
			set /a length=%%b - !offset!
			call :set_index %~1 !index! "content:~!offset!,!length!"
			set /a index+=1
			set /a offset=%%b+1
		)
	)
	call :set_index %~1 !index! content:~%offset%,%length%
	
	
	set delimiter=
	set content=
	set length=
	set character=
	set index=
	set offset=
)	
goto :eof

:set_pass <vars> <index> <contents>
(
	call :create_string %~1[%~2] "!%~3!"
)
goto :eof


:main
setlocal
	
	REM set /p "code=Code: "
	set /p "pass=Encrypt your password: "

	call :lengthFunction pass passLenVar
	REM set /a passLenVar-=1
	call :array_sets characters "," ",,,,,,,,,,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,"
	REM set /a contentLength-=1

	for /l %%t in ( 10, 1, %contentLength% ) do (
		if "!characters[%%t]!" neq "" (
			REM if "!characters[%%t]!" neq "?" (

				for /l %%y in ( 0, 1, !passLenVar! ) do (
					if "!characters[%%t]!" equ "!pass:~%%y,1!" (
					
					echo Input: !pass:~%%y,1! database: !characters[%%t]! %%t
					
							REM set /a MATH=%%t*!code!

							REM for /f %%m in ( "!MATH!" ) do (
								set "charac=!pass:~%%y,1!"
								set "pass=!pass:%charac%=-%%t!"
								REM !pass:search=replace!
							REM )
					)
				)
			REM )
		)
	)
	REM cls
	echo !pass!
	REM set "characters="
	
endlocal

:eof