@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script must be run as an administrator.
    echo Please right-click the script and select "Run as administrator".
    pause
    exit /b
)

echo v1.0.2
echo Checking System Eligibility for Valorant (TPM 2.0, Secure Boot, Windows Version, CPU Performance, RAM, GPU)...
echo.

:: Download lookup_gpu.txt from GitHub
set "lookupUrl=https://raw.githubusercontent.com/Mightyiest/Valorant-system-check-script/main/lookup_gpu.txt"
set "lookupFile=%TEMP%\lookup_gpu.txt"

if exist "%lookupFile%" del "%lookupFile%"

echo Downloading GPU lookup table...
curl -s -o "%lookupFile%" "%lookupUrl%"
if not exist "%lookupFile%" (
    echo Failed to download GPU lookup table.
    goto :end
)

echo Motherboard:
wmic baseboard get product,Manufacturer,version,serialnumber
echo.

:: Check TPM 2.0
echo TPM 2.0:
powershell -Command "(Get-Tpm).TpmPresent" > "%TEMP%\temp_tpm_present.txt"
findstr /i "True" "%TEMP%\temp_tpm_present.txt" > nul

if %errorlevel% equ 0 (
    powershell -Command "(Get-Tpm).TpmReady" > "%TEMP%\temp_tpm_ready.txt"
    findstr /i "True" "%TEMP%\temp_tpm_ready.txt" > nul

    if %errorlevel% equ 0 (
        powershell -Command "(Get-Tpm).ManufacturerVersion -like '2.0*'" > "%TEMP%\temp_tpm_version.txt"
        findstr /i "True" "%TEMP%\temp_tpm_version.txt" > nul

        if %errorlevel% equ 0 (
            set tpmStatus=Enabled
            call :ColorEcho 92 Enabled
        ) else (
            set tpmStatus=Disabled
            call :ColorEcho 91 "Disabled or Not Found (not version 2.0)"
        )
        del "%TEMP%\temp_tpm_version.txt"
    ) else (
        set tpmStatus=Disabled
        call :ColorEcho 91 "Disabled or Not Ready"
    )
    del "%TEMP%\temp_tpm_ready.txt"
) else (
    set tpmStatus=NotFound
    call :ColorEcho 91 "Not Found"
)
del "%TEMP%\temp_tpm_present.txt"

goto :secureboot

:secureboot
echo.
echo Secure Boot:
powershell -Command "Confirm-SecureBootUEFI" > "%TEMP%\temp_sb.txt"
findstr /i "True" "%TEMP%\temp_sb.txt" > nul

if %errorlevel% equ 0 (
    set secureBootStatus=Enabled
    call :ColorEcho 92 Enabled
) else (
    set secureBootStatus=Disabled
    call :ColorEcho 91 Disabled
)
echo.

del "%TEMP%\temp_sb.txt"

echo Checking Windows version:

wmic os get Caption, BuildNumber, OSArchitecture /value > "%TEMP%\temp_winver.txt"

for /f "tokens=2 delims==" %%I in ('type "%TEMP%\temp_winver.txt" ^| findstr /i "Caption"') do (
    set "winVersion=%%I"
)

for /f "tokens=2 delims==" %%I in ('type "%TEMP%\temp_winver.txt" ^| findstr /i "BuildNumber"') do (
    set "buildNumber=%%I"
)

for /f "tokens=2 delims==" %%I in ('type "%TEMP%\temp_winver.txt" ^| findstr /i "OSArchitecture"') do (
    set "osArch=%%I"
)

echo Detected OS: %winVersion% (Build %buildNumber%) %osArch%

if "%osArch%"=="64-bit" (
    echo %winVersion% | findstr /i "10" > nul
    if %errorlevel% equ 0 (
        if %buildNumber% GEQ 19045 (
            call :ColorEcho 92 "OK! (Windows 10 64-bit, Build 19045 or later)"
        ) else (
            call :ColorEcho 91 "Not OK! (Windows 10 64-bit, Build is older than 19045)"
        )
        goto :ramcheck
    )

    echo %winVersion% | findstr /i "11" > nul
    if %errorlevel% equ 0 (
        call :ColorEcho 92 "OK! (Windows 11 64-bit)"
        goto :ramcheck
    )

    call :ColorEcho 91 "Not OK! (Unsupported Windows version)"
    goto :end
) else (
    call :ColorEcho 91 "Not OK! (Requires 64-bit Windows)"
    goto :end
)

:ramcheck
echo.
echo RAM Check:

:: Get total physical memory in GB directly with PowerShell
powershell -Command "$RAM = (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory; [math]::Round($RAM / 1GB)" > "%TEMP%\temp_ram.txt"

for /f "tokens=*" %%a in ('type "%TEMP%\temp_ram.txt"') do (
    set "ramTotalGB=%%a"
)

echo Detected RAM: %ramTotalGB%GB

if %ramTotalGB% LSS 8 (
    set ramCategory=Low
    call :ColorEcho 91 "Too Low: %ramTotalGB% GB"
) else if %ramTotalGB% GEQ 8 if %ramTotalGB% LSS 16 (
    set ramCategory=Medium
    call :ColorEcho 93 "Medium: %ramTotalGB% GB"
) else (
    set ramCategory=High
    call :ColorEcho 92 "Good: %ramTotalGB% GB"
)

goto :cpucheck

:cpucheck
echo.
echo CPU Performance:
wmic cpu get name /value > "%TEMP%\temp_cpu.txt"

for /f "usebackq tokens=2 delims==" %%I in (`type "%TEMP%\temp_cpu.txt" ^| findstr /i "name"`) do (
    set "cpuName=%%I"
)

echo Detected CPU: %cpuName%

:: Determine CPU Performance Category
set cpuCategory=Unknown

:: Check for Ryzen 5, 7 1000 series or Intel 7th Gen (Poor-Medium)
echo %cpuName% | findstr /i "Ryzen [57] 1[0-9][0-9][0-9]" > nul
if %errorlevel% equ 0 set cpuCategory=Poor-Medium

echo %cpuName% | findstr /i "i[357]-7" > nul
if %errorlevel% equ 0 set cpuCategory=Poor-Medium

:: Check for Ryzen 3, 5, 7 2000 series or Intel 8th Gen (Medium)
echo %cpuName% | findstr /i "Ryzen [357] 2[0-9][0-9][0-9]" > nul
if %errorlevel% equ 0 set cpuCategory=Medium

echo %cpuName% | findstr /i "i[357]-8" > nul
if %errorlevel% equ 0 set cpuCategory=Medium

:: Check for Ryzen 3, 5, 7, 9 3000 series or later or Intel 9th Gen or later (High)
echo %cpuName% | findstr /i "Ryzen [3579] [3-9][0-9][0-9][0-9]" > nul
if %errorlevel% equ 0 set cpuCategory=High

echo %cpuName% | findstr /i "i[3579]-[9]" > nul
if %errorlevel% equ 0 set cpuCategory=High

echo %cpuName% | findstr /i "i[3579]-1[0-9]" > nul
if %errorlevel% equ 0 set cpuCategory=High

:: Display CPU Performance Category
if defined cpuCategory (
    if %cpuCategory%==Poor-Medium (
        call :ColorEcho 93 "Poor-Medium Performance (Ryzen 5/7 1000 series or Intel 7th Gen)"
    ) else if %cpuCategory%==Medium (
        call :ColorEcho 93 "Medium Performance (Ryzen 3/5/7 2000 series or Intel 8th Gen)"
    ) else if %cpuCategory%==High (
        call :ColorEcho 92 "High Performance (Ryzen 3/5/7/9 3000 series or later, or Intel 9th Gen or later)"
    )
) else (
    call :ColorEcho 91 "CPU performance categorization not available."
)

goto :gpucheck

:gpucheck
echo.
echo GPU Check:

wmic path win32_VideoController get name /value > "%TEMP%\temp_gpu.txt"

for /f "usebackq tokens=2 delims==" %%I in (`type "%TEMP%\temp_gpu.txt" ^| findstr /i "name"`) do (
    set "gpuName=%%I"
)

:: Trim whitespace from gpuName
for /f "tokens=* delims= " %%a in ("%gpuName%") do set "gpuName=%%a"

echo Detected GPU: %gpuName%

:: Lookup GPU Performance Category
set gpuCategory=Unknown
for /f "tokens=1,2 delims=," %%a in (%lookupFile%) do (
    if /i "%%a"=="%gpuName%" set gpuCategory=%%b
)

:: Display GPU Performance Category
if defined gpuCategory (
    if %gpuCategory%==Poor-Medium (
        call :ColorEcho 93 "Poor-Medium Performance (%gpuName%)"
    ) else if %gpuCategory%==Medium (
        call :ColorEcho 93 "Medium Performance (%gpuName%)"
    ) else if %gpuCategory%==High (
        call :ColorEcho 92 "High Performance (%gpuName%)"
    )
) else (
    call :ColorEcho 91 "GPU performance categorization not available."
)
goto :evaluate

:: Evaluate System Performance and Display Message
:evaluate
echo.
if defined ramCategory if defined cpuCategory if defined gpuCategory (
    if %ramCategory%==Low (
        call :ColorEcho 91 "Your PC is eligible to play but expect Low FPS (30-40)."
    ) else if %ramCategory%==Medium (
        if %cpuCategory%==Poor-Medium (
            call :ColorEcho 91 "Your PC is eligible to play but expect Low FPS (30-40)."
        ) else if %cpuCategory%==Medium (
            call :ColorEcho 93 "Your PC is eligible to play at Medium FPS (60-100)."
        ) else if %cpuCategory%==High (
            call :ColorEcho 93 "Your PC is eligible to play at Medium FPS (60-100)."
        ) else (
            call :ColorEcho 91 "Performance evaluation not available due to uncategorized CPU."
        )
    ) else if %ramCategory%==High (
        if %cpuCategory%==Poor-Medium (
            call :ColorEcho 92 "Your PC is eligible to play at High FPS (144-300+)."
        ) else if %cpuCategory%==Medium (
            call :ColorEcho 92 "Your PC is eligible to play at High FPS (144-300+)."
        ) else if %cpuCategory%==High (
            call :ColorEcho 92 "Your PC is eligible to play at High FPS (144-300+)."
        ) else (
            call :ColorEcho 91 "Performance evaluation not available due to uncategorized CPU."
        )
    ) else (
        call :ColorEcho 91 "Performance evaluation not available due to insufficient RAM."
    )
) else (
    call :ColorEcho 91 "Performance evaluation not available due to missing RAM, CPU, or GPU information."
)

:: Display warning for TPM 2.0 and Secure Boot if necessary
if "%tpmStatus%" neq "Enabled" (
    call :ColorEcho 91 "Warning: In order to play Valorant, you must enable TPM 2.0."
)
if "%secureBootStatus%" neq "Enabled" (
    call :ColorEcho 91 "Warning: In order to play Valorant, you must enable Secure Boot."
)

:end
del "%TEMP%\temp_cpu.txt"
del "%TEMP%\temp_ram.txt"
del "%TEMP%\temp_winver.txt"
del "%TEMP%\temp_gpu.txt"
del "%lookupFile%"

echo.
(pause)
goto :eof

:ColorEcho
echo [%1m%~2[0m
exit /b