# Valorant System Check script

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
![image](https://github.com/user-attachments/assets/f6ee75df-6842-4107-b43f-a28ee203bda4)

## GPU Lookup Table

This table provides a general performance categorization of various GPUs in relation to Valorant. This is not an exhaustive list, but it covers a wide range of common graphics cards. The "Performance Category" is a general estimate of how well the GPU will run Valorant at common settings.

**Important Notes:**

*    **Valorant is CPU-Intensive:** **Valorant is a CPU-bound game, meaning your CPU performance will often be the primary factor determining your frame rate.** A powerful GPU is still helpful, but a strong CPU is more critical for achieving high and stable FPS in Valorant. Prioritize your CPU first, then RAM, and then your GPU.
*   **Resolution:** These categories are based on a 1080p resolution. Higher resolutions will generally result in lower frame rates.
*   **Settings:** The "Poor-Medium," "Medium," and "High" categories refer to general performance at corresponding in-game settings.
*   **Laptop GPUs:** Laptop versions of these GPUs (e.g., RTX 3060 Laptop GPU) might perform slightly differently than their desktop counterparts due to power and thermal constraints.
*   **Future Updates:** This table will be updated periodically, but new GPUs are constantly being released.
*   **Other Factors:** Factors such as your monitor's refresh rate and whether you are streaming or recording can also affect performance.

**Format:**

`GPU Model`, `Performance Category`

**Categories:**

*   **Poor-Medium:** Generally 40 - 100+ FPS at low settings, may struggle at higher settings or resolutions.
*   **Medium:** Generally 120 - 200+ FPS at medium settings, good for 1080p gaming.
*   **High:** Generally 144 - 300+ FPS at high settings, capable of 1440p and some 4K gaming (depending on the specific card).

---

### Poor-Medium

| GPU Model                | Performance Category |
| :----------------------- | :------------------- |
| NVIDIA GeForce GTX 1050   | Poor-Medium          |
| NVIDIA GeForce GTX 950    | Poor-Medium          |
| NVIDIA GeForce GTX 960    | Poor-Medium          |
| NVIDIA GeForce GT 1030    | Poor-Medium          |
| Radeon RX 550            | Poor-Medium          |
| Radeon RX 560            | Poor-Medium          |
| Radeon R7 360            | Poor-Medium          |
| Radeon R7 370            | Poor-Medium          |
| Intel UHD Graphics 620   | Poor-Medium          |
| Intel UHD Graphics 630   | Poor-Medium          |
| Intel UHD Graphics 750   | Poor-Medium          |
| Intel Iris Xe Graphics   | Poor-Medium          |

### Medium

| GPU Model                    | Performance Category |
| :--------------------------- | :------------------- |
| NVIDIA GeForce GTX 1050 Ti    | Medium               |
| NVIDIA GeForce GTX 1650      | Medium               |
| NVIDIA GeForce GTX 1650 Super | Medium               |
| NVIDIA GeForce GTX 1660      | Medium               |
| NVIDIA GeForce GTX 1660 Super | Medium               |
| NVIDIA GeForce GTX 1660 Ti    | Medium               |
| NVIDIA GeForce GTX 1060      | Medium               |
| NVIDIA GeForce GTX 1060 3GB  | Medium               |
| NVIDIA GeForce GTX 1060 6GB  | Medium               |
| NVIDIA GeForce GTX 970       | Medium               |
| NVIDIA GeForce GTX 980       | Medium               |
| NVIDIA Radeon RX 570         | Medium               |
| NVIDIA Radeon RX 580         | Medium               |
| NVIDIA Radeon RX 590         | Medium               |
| NVIDIA Radeon RX 5500 XT      | Medium               |
| NVIDIA Radeon RX 5600 XT      | Medium               |
| Radeon RX 470                | Medium               |
| Radeon RX 480                | Medium               |
| Intel Arc A380              | Medium               |

### High

| GPU Model                    | Performance Category |
| :--------------------------- | :------------------- |
| NVIDIA GeForce RTX 2060      | High                 |
| NVIDIA GeForce RTX 2060 Super | High                 |
| NVIDIA GeForce RTX 2070      | High                 |
| NVIDIA GeForce RTX 2070 Super | High                 |
| NVIDIA GeForce RTX 2080      | High                 |
| NVIDIA GeForce RTX 2080 Super | High                 |
| NVIDIA GeForce RTX 2080 Ti    | High                 |
| NVIDIA GeForce RTX 3050      | High                 |
| NVIDIA GeForce RTX 3060      | High                 |
| NVIDIA GeForce RTX 3060 Ti    | High                 |
| NVIDIA GeForce RTX 3070      | High                 |
| NVIDIA GeForce RTX 3070 Ti    | High                 |
| NVIDIA GeForce RTX 3080      | High                 |
| NVIDIA GeForce RTX 3080 Ti    | High                 |
| NVIDIA GeForce RTX 3090      | High                 |
| NVIDIA GeForce RTX 3090 Ti    | High                 |
| NVIDIA GeForce RTX 4060      | High                 |
| NVIDIA GeForce RTX 4060 Ti    | High                 |
| NVIDIA GeForce RTX 4070      | High                 |
| NVIDIA GeForce RTX 4070 Super | High                 |
| NVIDIA GeForce RTX 4070 Ti    | High                 |
| NVIDIA GeForce RTX 4070 Ti Super | High                 |
| NVIDIA GeForce RTX 4080      | High                 |
| NVIDIA GeForce RTX 4080 Super | High                 |
| NVIDIA GeForce RTX 4090      | High                 |
| Radeon RX 5700 XT            | High                 |
| Radeon RX 5700               | High                 |
| Radeon RX 6600 XT            | High                 |
| Radeon RX 6600               | High                 |
| Radeon RX 6650 XT            | High                 |
| Radeon RX 6700 XT            | High                 |
| Radeon RX 6750 XT            | High                 |
| Radeon RX 6800               | High                 |
| Radeon RX 6800 XT            | High                 |
| Radeon RX 6900 XT            | High                 |
| Radeon RX 6950 XT            | High                 |
| Radeon RX 7600               | High                 |
| Radeon RX 7700 XT            | High                 |
| Radeon RX 7800 XT            | High                 |
| Radeon RX 7900 XT            | High                 |
| Radeon RX 7900 XTX            | High                 |
| Intel Arc A580              | High                 |
| Intel Arc A750              | High                 |
| Intel Arc A770              | High                 |

---

This table is intended to be a helpful resource, but please do your own research to determine the best GPU for your specific needs and budget. You can find more detailed performance benchmarks and comparisons online.

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
