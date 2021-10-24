:: ---------------------------------------------------------------------------------------------------
::This is the launch script for the space force disk cleanup script.
:: ---------------------------------------------------------------------------------------------------

:: ---------------------------------------------------------------------------------------------------
::Connects to computers listed in diskcleanuppcs.text which should be located in the space force folder
::Launches DiskCleanup.exe with all options selected, runs without user input.
:: ---------------------------------------------------------------------------------------------------
psexec @%~dp0DiskCleanupPCs.txt -s -i 1 \\[SERVER]\[SHARE]\SpaceForce\diskcleanuputility.bat

:: ---------------------------------------------------------------------------------------------------
::Connects to computers listed in diskcleanuppcs.text which should be located in the space force folder
::Launches the SpaceForce script.
:: ---------------------------------------------------------------------------------------------------
psexec @%~dp0DiskCleanupPCs.txt -s \\[SERVER]\[SHARE]\SpaceForce\SpaceForce.bat
