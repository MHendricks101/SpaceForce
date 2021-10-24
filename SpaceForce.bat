:: -----------------------------------------------------------------------------------------------
:: Space Force v1.0 disk cleanup utility
:: Author: Matt Hendricks
:: -----------------------------------------------------------------------------------------------

@echo off
 
:: -----------------------------------------------------------------------------------------------
:: Checks current free space and prints to screen.
:: -----------------------------------------------------------------------------------------------

ECHO Checking Current Free Space.

FOR /F "tokens=2 delims=(s),bytes" %%F IN ('dir c:\') DO (

SET curruser=%%F

)

ECHO Current free space is %curruser% GB.

 
:: -----------------------------------------------------------------------------------------------
:: Querries current user and sets as variable to be used in designating user directories.
:: -----------------------------------------------------------------------------------------------

ECHO Querrying for current user...

FOR /F "tokens=1 delims=>, " %%F IN ('query user') DO (

SET currentuser=%%F

)

ECHO Current user is %currentuser%

ECHO.

:: -----------------------------------------------------------------------------------------------
:: Deletes user temp files, Windows prefetch, and c:\temp.
:: -----------------------------------------------------------------------------------------------

echo Deleting Temp Files...

del %temp%\*.*/s/q

del "C:\Users\%currentuser%\AppData\Local\Temp\*.*"/s/q

del C:\Windows\prefetch\*.*/s/q

del C:\temp\*.*/s/q

 
:: -----------------------------------------------------------------------------------------------
:: Clears caches for IE, Edge, Chrome
:: -----------------------------------------------------------------------------------------------

del "C:\Users\%currentuser%\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*" /s/q

del "C:\Users\%currentuser%\AppData\Local\Microsoft\Edge\User Data\Default\*.*" /s/q

del "C:\Users\v55437\AppData\Local\Microsoft\Windows\INetCache\*.*" /s/q

 
:: -----------------------------------------------------------------------------------------------
:: Cleans up Driver Store File Repository, this folder can contain many unneeded drivers.
:: -----------------------------------------------------------------------------------------------

echo Cleaning Up Driver Store Files...

TAKEOWN /F "C:\Windows\System32\DriverStore\FileRepository" /R

ICACLS "C:\Windows\System32\DriverStore\FileRepository" /T /L /GRANT *S-1-1-0:F

RD /s /Q "C:\Windows\System32\DriverStore\FileRepository\"

 
:: -----------------------------------------------------------------------------------------------
:: Cleans up WinSxS recovery folder, this folder can corrupt and become oversized.
:: -----------------------------------------------------------------------------------------------

echo Cleaning Up Windows Recovery Files...

Dism.exe /online /Cleanup-Image /StartComponentCleanup

Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

 
:: -----------------------------------------------------------------------------------------------
:: Cleans up Windows update download directory.
:: -----------------------------------------------------------------------------------------------

Echo Cleaning Windows Update Files...

del %SystemDrive%\Windows\SoftwareDistribution\Download /s/q

 
:: -----------------------------------------------------------------------------------------------
:: Runs CacheCleaner.exe, deletes nomad cache.
:: -----------------------------------------------------------------------------------------------

Echo Clearing Nomad Cache...

start CacheCleaner.exe –DeleteAll -Force=3

 
:: -----------------------------------------------------------------------------------------------
:: Runs Windows Store Reset, clears out Windows Apps
:: -----------------------------------------------------------------------------------------------

Echo Resetting Windows Store

start wsreset.exe

 
:: -----------------------------------------------------------------------------------------------
:: Checks final free space and prints to screen.
:: -----------------------------------------------------------------------------------------------

ECHO Checking Current Free Space.

FOR /F "tokens=2 delims=(s),bytes" %%F IN ('dir c:\') DO (

SET curruser=%%F

)

ECHO Current free space is %curruser% GB.

 

pause
