@echo off

echo `===================== PATH is now: %PATH% ======================`

setlocal

:: Create the output directory if it doesn't exist
set "output_dir=C:\temp\test"
if not exist "%output_dir%" (
    mkdir "%output_dir%"
)

:: Get the current date and time in a consistent format
set "timestamp="
echo %date%
for /f "tokens=1-3 delims=/- " %%a in ("%date%") do (
    set "yyyy=%%a"
    set "Month=%%b"
    set "dd=%%c"
	echo `1............... %yyyy%%Month%%dd%`
)

echo %time%
for /f "tokens=1-3 delims=:." %%a in ("%time%") do (
    set "HH=%%a"
    set "mm=%%b"
    set "ss=%%c"
)

:: Ensure single-digit components are zero-padded
if %Month% LSS 10 set "Month=0%Month%"
if %dd% LSS 10 set "dd=0%dd%"
if %HH% LSS 10 set "HH=0%HH%"
if %mm% LSS 10 set "mm=0%mm%"
if %ss% LSS 10 set "ss=0%ss%"

:: Construct the timestamp and set output file path
set "timestamp=%yyyy%%Month%%dd%%HH%%mm%%ss%"
set "output_file=%output_dir%\testbat-%timestamp%.txt"


echo `........................... %output_file%`

:: Define the URL and output file with timestamp
set "url=https://www.google.ca"
set "output_file=%output_dir%\testbat-%timestamp%.txt"

:: Run the curl command and save the result
:: curl -s -k --head --request GET --connect-timeout 5 -o "%output_file%" "%url%"

curl -s -k --head --request GET --connect-timeout 5 "%url%"

:: Check if curl was successful
if %errorlevel% equ 0 (
    echo Curl command completed successfully. Output saved to %output_file%
) else (
    echo Curl command failed.
)

endlocal
