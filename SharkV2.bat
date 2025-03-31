@echo off
color 0b
chcp 65001 >nul
title Rohan's Multitool

:home
cls
echo.
echo  ╔═════════════════════════════════════════════════════════╗
echo  ║                                                         ║
echo  ║  ███████╗██╗  ██╗ █████╗ ██████╗ ██╗  ██╗██╗   ██╗██████╗  ║
echo  ║  ██╔════╝██║  ██║██╔══██╗██╔══██╗██║ ██╔╝██║   ██║╚════██╗ ║
echo  ║  ███████╗███████║███████║██████╔╝█████╔╝ ██║   ██║ █████╔╝ ║
echo  ║  ╚════██║██╔══██║██╔══██║██╔══██╗██╔═██╗ ╚██╗ ██╔╝██╔═══╝  ║
echo  ║  ███████║██║  ██║██║  ██║██║  ██║██║ ██╗  ╚████╔╝ ███████╗ ║
echo  ║ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═╝   ╚═══╝  ╚══════╝ ║
echo  ║                                                         ║
echo  ╚═════════════════════════════════════════════════════════╝
echo.
echo  ╔═════════════════════════════════════════════════════════╗
echo  ║                                                         ║
echo  ║  ► 1 - List all PCs on the network (IP & Hostname)       ║
echo  ║                                                         ║
echo  ║  ► 2 - Remotely shutdown a Windows PC                    ║
echo  ║                                                         ║
echo  ║  ► 3 - Remotely shutdown a Mac                           ║
echo  ║                                                         ║
echo  ║  ► 4 - Get system info of a network computer             ║
echo  ║                                                         ║
echo  ║  ► 5 - How to Use                                        ║
echo  ║                                                         ║
echo  ║  ► 6 - Exit                                              ║
echo  ║                                                         ║
echo  ╚═════════════════════════════════════════════════════════╝
echo.
set /p option= Choose an option: 
if %option%==1 goto list_pcs
if %option%==2 goto shutdown_win
if %option%==3 goto shutdown_mac
if %option%==4 goto system_info
if %option%==5 goto how_to_use
if %option%==6 goto exit
goto home

:list_pcs
cls
echo Listing all PCs on the network (IP & Hostname)... 
echo.
echo Scanning network for devices using nmap...

:: Scan the network with nmap (scan the 192.168.4.x range)
nmap -sn 192.168.4.0/24 > nmap_scan_results.txt

:: Display the results
echo Scanned Devices:
for /f "tokens=1,2 delims=: " %%a in ('findstr /i "Nmap scan" nmap_scan_results.txt') do (
    set ip_address=%%b
    echo Found device at IP: %%b
    :: Attempt to resolve the hostname using nbtstat
    for /f "tokens=2" %%j in ('nbtstat -A %%b ^| findstr /i "Name"') do echo Host name: %%j
)

pause
goto menu_back


:shutdown_win
cls
title Rohan's Multitool - Shutting down Windows PC
echo This option will allow you to remotely shut down a Windows PC on the same network.
echo.
echo WARNING: This feature requires administrator privileges.
echo.
set /p ip_address= Enter the IP address of the Windows PC to shut down: 
echo Finding computer name for IP: %ip_address%...

:: Use nbtstat to find the NetBIOS name associated with the IP
for /f "tokens=2 delims=: " %%a in ('nbtstat -A %ip_address% ^| findstr /i "Name"') do set pc_name=%%a

:: Check if the computer name was found
if "%pc_name%"=="" (
    echo Error: Could not find the computer name for IP %ip_address%.
    pause
    goto menu_back
)

echo Computer name: %pc_name%
set /p confirm= Are you sure you want to shut down %pc_name%? (Y/N): 
if /i "%confirm%"=="Y" (
    shutdown /s /f /m \\%pc_name%
    echo %pc_name% has been shut down.
) else (
    echo Shutdown cancelled.
)
pause
goto menu_back

:shutdown_mac
cls
title Rohan's Multitool - Shutting down Mac
echo This option will allow you to remotely shut down a Mac on the same network.
echo.
set /p ip_address= Enter the IP address of the Mac to shut down: 
set /p username= Enter the username for the Mac: 

:: Use SSH to get the hostname of the Mac
for /f "delims=" %%i in ('ssh %username%@%ip_address% hostname') do set mac_name=%%i

:: Check if the Mac name was found
if "%mac_name%"=="" (
    echo Error: Could not retrieve the Mac name for IP %ip_address%.
    pause
    goto menu_back
)

echo Mac computer name: %mac_name%
set /p confirm= Are you sure you want to shut down %mac_name%? (Y/N): 
if /i "%confirm%"=="Y" (
    ssh %username%@%ip_address% sudo shutdown -h now
    echo %mac_name% has been shut down.
) else (
    echo Shutdown cancelled.
)
pause
goto menu_back

:system_info
cls
set /p pc_name= Enter the computer name or IP address to get system info: 
systeminfo /s %pc_name%
pause
goto menu_back

:how_to_use
cls
echo How to Use Rohan's Multitool:
echo.
echo 1 - List all PCs on the network (IP & Hostname): This will scan the network and display all active PCs along with their IP addresses and hostnames.
echo.
echo 2 - Remotely shutdown a Windows PC: This allows you to shut down a Windows PC on your network by specifying the computer name or IP address.
echo.
echo 3 - Remotely shutdown a Mac: This option lets you shut down a Mac by entering its IP address and username.
echo.
echo 4 - Get system info of a network computer: You can retrieve system information of any computer on the same network by specifying the computer name or IP address.
echo.
echo 5 - How to Use: Displays this help message explaining each option.
echo.
echo 6 - Exit: Exits the tool and closes the command prompt window.
echo.
pause
goto menu_back

:menu_back
echo.
set /p back_option= Press Enter to go back to the menu...
goto home

:exit
cls
echo Exiting...
timeout 2 >nul
exit
