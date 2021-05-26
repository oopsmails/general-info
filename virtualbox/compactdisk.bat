@echo off
for /d %%d in (*.*) do (
    cd "%%d"
    for %%f in (*.vdi) do (
        echo Compacting %%f . . .
        echo Initial size:      %%~zf
        "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifymedium --compact disk "%%f"
        echo Post compact size: %%~zf
        echo.
    )
    cd ..
)
