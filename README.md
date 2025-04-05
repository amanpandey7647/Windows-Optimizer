# System Optimization Script (Batch Script)

This batch script provides a menu-driven interface for performing various system optimizations on Windows, including:

**Core Features:**

* **Temporary File Cleanup:**  Clears temporary files and caches from system and user folders, including:
    - `%SystemRoot%\Temp`
    - `%SystemRoot%\Prefetch`
    - `%USERPROFILE%\AppData\Local\Temp`
    - `C:\Windows\Temp`
    - Browser history, cookies, recent files (optional, with caution)
    - Event logs
* **Group Policy and Registry Tweaks:**
    - **Delay Windows Updates:** Allows delaying feature and quality updates for a specified number of days (with a warning about security risks).
    - **Disable UAC Prompts:** Disables User Account Control prompts (with a strong warning about reduced security).
    - **Enable Fast Startup:** Enables Fast Startup and configures Hibernation for faster boot times.
    - **Disable Visual Effects:**  Disables visual effects like animations and shadows for potentially improved performance.
    - **Adjust Processor Scheduling:**  Provides options to prioritize processor resources for either foreground programs or background processes.
    - **Manage Services (Advanced Users):** 
        - List all services.
        - Disable services (with a list of potentially safe services to disable, but with strong warnings to research each service first).
        - Enable services.
        - Set services to Manual startup. 

**Important Notes:**

* **Security Risks:**  This script includes options that can significantly reduce your system's security (e.g., disabling UAC, delaying updates, disabling services). Use these options with EXTREME caution and only if you understand the risks fully.
* **System Stability:** Incorrectly modifying system settings can lead to instability or data loss.  
* **Backup Your System:** Create a System Restore point or a full backup before running any part of this script.
* **Test in a Safe Environment:** It's highly recommended to test this script in a virtual machine or a non-production environment before using it on your main system.
* **User Responsibility:** This script is provided for informational purposes only. You are solely responsible for any consequences that may arise from using it. 

**Disclaimer:**

The author of this script cannot be held responsible for any damage or data loss that may occur as a result of using this script. Use it at your own risk.

**Intended Audience:**

This script is intended for advanced users who understand the risks involved in modifying system settings. If you are not comfortable with these risks, it is recommended that you do not use this script.

**License:**

This script is released under the MIT License. 

**Contributing:**

Contributions are welcome! Please open an issue or submit a pull request if you have any suggestions or improvements. 
