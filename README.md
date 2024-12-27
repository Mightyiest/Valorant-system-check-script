# Valorant System Check Batch

[![Status](https://img.shields.io/badge/Status-Working-green)](https://shields.io/)

A Windows Batch script to check if your system meets the minimum and recommended requirements to run Valorant.

## Description

This script analyzes your system's specifications and provides feedback on whether your PC can run Valorant. It checks for the following:

-   **Motherboard Information:** Displays basic details about your motherboard.
-   **TPM 2.0 Status:** Checks for the presence, readiness, and version of the Trusted Platform Module (TPM), which is a requirement for Valorant.
-   **Secure Boot Status:** Determines if Secure Boot is enabled in your system's BIOS/UEFI settings.
-   **Windows Version and Build Number:** Verifies that you are running a compatible 64-bit version of Windows (Windows 10 build 19045 or later, or Windows 11).
-   **RAM:** Checks your system's RAM capacity and categorizes it as:
    -   **Low:** Less than 8GB (expect low FPS)
    -   **Medium:** Between 8GB and 16GB
    -   **High:** 16GB or more
-   **CPU Performance:** Analyzes your CPU model and categorizes its performance as:
    -   **Poor-Medium:** Ryzen 5/7 1000 series, Intel 7th Gen or older
    -   **Medium:** Ryzen 3/5/7 2000 series, Intel 8th Gen
    -   **High:** Ryzen 3/5/7/9 3000 series or later, Intel 9th Gen or later
-   **GPU Name:** Identifies your graphics card model.
-   **Overall System Evaluation:** Provides a general assessment of your system's ability to run Valorant and predicts expected FPS categories (Low, Medium, High) based on your RAM and CPU.

**Color-Coded Output:**

The script uses color-coded output to make it easy to understand the results:

-   **Green:** OK/Pass/Enabled
-   **Yellow:** Medium/Warning/Potential Issues
-   **Red:** Not OK/Fail/Disabled/Error

## How it Works

The script leverages `wmic` (Windows Management Instrumentation Command-line) and PowerShell commands to gather system information. It parses this data and compares it against Valorant's requirements.

## Usage

1.  **Download:** Download the `valorant_check.bat` file from this repository.
2.  **Run as Administrator:** Right-click on the `valorant_check.bat` file and select "Run as administrator". This is necessary to allow the script to access certain system information.
3.  **View Results:** The script will display the results in the command prompt window.

## Example Output
![image](https://github.com/user-attachments/assets/07c1b46e-7ec4-4fa7-b49e-16f6fa6014a9)

## Requirements

-   Windows 10 (64-bit, Build 19045 or later) or Windows 11 (64-bit).
-   Administrator privileges to run the script.

## Notes

-   This script is intended for Windows systems only.
-   The CPU performance categorization is based on general guidelines and might not be 100% accurate for all CPU models. The script provides a general idea of your CPU's capabilities.
-   The accuracy of the FPS prediction depends on various factors, including in-game settings, background processes, and driver optimization.

## Contributing

Contributions are welcome! If you'd like to improve this script, feel free to:

1.  Fork the repository.
2.  Create a new branch for your changes.
3.  Make your changes and test them thoroughly.
4.  Submit a pull request.

You can also open an issue to report bugs or suggest new features.

## Disclaimer

This script is provided "as is" without any warranty. Use it at your own risk. The author is not responsible for any issues that may arise from using this script.
