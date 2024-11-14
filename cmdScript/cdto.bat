@echo off

echo %1

IF "%1" == "kafka" (
   cd /D C:\Software\kafka_2.11-2.1.0\bin\windows
) ELSE IF "%1" == "sw" (
   cd C:\Software
) ELSE (
    echo "Path not found!"
)



