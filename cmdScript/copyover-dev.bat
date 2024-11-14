rmdir "C:\Temp\mars-dev\" /S /Q
mkdir "C:\Temp\mars-dev\"
xcopy "C:\projects\mars-svnws3" "C:\Temp\mars-dev" /s /EXCLUDE:Exclude-mars.txt

PAUSE
