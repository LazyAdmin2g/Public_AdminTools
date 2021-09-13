:: Hide Commands
rem @echo off
setlocal EnableExtensions

:: Parse the Local AppData sub path
call :Expand xAppData "%%LocalAppData:%UserProfile%=%%"

set "xFirefox=\mozilla\firefox\profiles"

:: Start at the User directory
pushd "%UserProfile%\.."

:: Loop through the Users
for /D %%D in (*) do if exist "%%~fD%xAppData%" (
    rem Check for Firefox
    rem if exist "%%~fD%xAppData%%xFirefox%" (
    if exist  "%%~fD%xAppData%%xLocal%%xMozilla%%xFirefox%" (
        rem pushd "%%~fD%xAppData%%xFirefox%"
        pushd "%%~fD%xAppData%%xLocal%%xMozilla%%xFirefox%"

        rem Loop through the Profiles
        for /D %%P in (*) do (
            if exist "%%~fP\cache2" del /F /Q /S "%%~fP\cache2"
        )
        popd
    )
)
popd
goto End


::::::::::::::::::::::::::::::
:Expand <Variable> <Value>
if not "%~1"=="" set "%~1=%~2"
goto :eof


:End
endlocal
pause