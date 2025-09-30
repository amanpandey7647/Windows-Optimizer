# Windows Optimizer v7.0

A comprehensive batch script for Windows system optimization, debloating, and performance enhancement. This tool provides advanced users with a menu-driven interface to optimize Windows 11 systems for maximum performance.

## 🚀 Features

### Core Optimization Modules

#### **System Maintenance**
- **Clear Temporary Files**: Comprehensive cleanup of temp files, caches, and system clutter
- **Restart Tasks**: Restart essential Windows services and processes
- **Defragment Disk**: Optimize HDD storage (SSD optimization included)
- **Clear Event Logs**: Clean Windows event logs for better performance
- **Disk Cleanup**: Advanced disk space optimization

#### **Performance Tweaks**
- **Ultimate Performance Mode**: Enable Windows Ultimate Performance power plan
- **Maximum Responsiveness Mode**: Optimize system for responsiveness
- **Gaming Tweaks**: Performance optimizations for gaming
- **Network Settings Optimization**: TCP/IP and network stack improvements
- **Registry Optimizations**: Advanced registry tweaks for performance
- **Group Policy Optimizations**: System policy enhancements

#### **Windows Debloat System**
Choose from three debloat categories:

1. **Keep Essentials Only**: Remove ALL bloatware while preserving core system apps
2. **Custom Selection**: Choose from 37+ apps to remove individually:
   - Microsoft 3D Builder, Bing Weather, Get Help, Get Started
   - Microsoft Office Hub, Solitaire Collection, Sticky Notes, OneNote
   - People, Skype, Windows Alarms, Camera, Feedback Hub, Maps
   - Sound Recorder, Xbox App, Your Phone, Zune apps
   - Adobe Photoshop Express, gaming apps (Candy Crush, Disney, etc.)
   - Social media apps (Facebook, Instagram, LinkedIn, Twitter, WhatsApp)
   - Minecraft, Netflix, Plex, and more
3. **Remove ALL Apps**: Complete system cleanup (removes everything)

#### **Advanced Features**
- **Disable Windows Search Indexing**: Improve system responsiveness
- **Optimize Startup Programs**: Manage boot-time applications
- **Clean Windows.old Folder**: Remove previous Windows installation files
- **Disable Hibernation**: Free up disk space and improve performance
- **Automated System Optimizations**: 50+ hidden performance tweaks

#### **Advanced Performance Tweaks (2025)** ⭐ NEW
Cutting-edge Windows 11 optimizations including:
- Advanced CPU/memory management and core parking
- Windows 11 UI optimizations (Context Menu, File Explorer, Animations)
- Network, storage, and GPU performance enhancements
- Security, privacy, and service optimizations
- Battery management and power settings
- Registry cleanup and system maintenance

## 📋 Requirements

- **Operating System**: Windows 11 (optimized for latest builds)
- **Permissions**: Administrator privileges required
- **User Level**: Advanced users only (see warnings below)

## 🛠️ Installation & Usage

### Method 1: Direct Download
1. **Download**: Save the script as `optimze.bat`
2. **Run as Administrator**: Right-click → Run as administrator
3. **Navigate Menu**: Use number keys to select options
4. **Follow Prompts**: Each option provides clear instructions

### Method 2: Git Clone (Recommended)
```bash
# Clone the repository
git clone https://github.com/amanpandey7647/Windows-Optimizer.git

# Navigate to the directory
cd Windows-Optimizer

# Run the script as administrator
# On Windows: Right-click Windows Optimizer.bat → Run as administrator
# On PowerShell/Command Prompt: Run as administrator, then execute the .bat file
```

### Method 3: Direct Download via curl
```bash
# Download the script directly
curl -o "Windows Optimizer.bat" "https://raw.githubusercontent.com/amanpandey7647/Windows-Optimizer/refs/heads/main/Windows%20Optimizer.bat"

# Run as administrator (see Method 1)
```

### Method 4: PowerShell Download
```powershell
# Download using PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/amanpandey7647/Windows-Optimizer/refs/heads/main/Windows%20Optimizer.bat" -OutFile "Windows Optimizer.bat"
```

**Repository**: [https://github.com/amanpandey7647/Windows-Optimizer](https://github.com/amanpandey7647/Windows-Optimizer)

### Menu Navigation
```
Choose an optimization option:
Note - Choose Any One 123456789ABCDEFGHI (A=10, B=11, C=12, D=13, E=14, F=15, G=16, H=17, I=18)

1.  Clear Temporary Files          11. Disk Cleanup
2.  Restart Tasks                  12. Disable Windows Search Indexing
3.  Defragment Disk (HDD Only)      13. Optimize Startup Programs
4.  Clear Event Logs               14. Clean Windows.old Folder
5.  Optimize Network Settings      15. Disable Hibernation
6.  Registry Optimizations         16. Automated System Optimizations
7.  Group Policy Optimizations     17. Debloat Windows (Remove Bloatware)
8.  Ultimate Performance Mode      18. Advanced Performance Tweaks (2025)
9.  Maximum Responsiveness Mode    19. Exit
10. Gaming Tweaks
```

## ⚠️ Important Warnings

### Security Risks
This script includes options that can significantly reduce system security:
- Disabling Windows Defender real-time protection
- Delaying Windows Updates
- Disabling User Account Control (UAC)
- Modifying critical system services

### System Stability
- Incorrect modifications can cause system instability
- Some optimizations may break certain applications
- Registry changes are permanent until reversed

### Data Loss Risk
- Debloat operations remove applications and data
- Some optimizations clear caches and temporary files
- Always backup important data before use

## 🛡️ Safety Recommendations

1. **Create Restore Point**: `System Properties → System Protection → Create`
2. **Backup Data**: Important files, documents, and configurations
3. **Test First**: Use in a virtual machine or test environment
4. **Research Options**: Understand what each tweak does before applying
5. **Monitor System**: Watch for stability issues after changes

## 🔧 Advanced Usage

### Custom Debloat Selection
The custom debloat menu allows granular control:
```
Enter numbers separated by spaces (e.g., "1 5 10 15"):
38. All of the above (Complete removal)
39. Back to Debloat Menu
```

### Service Management
Advanced users can manage Windows services through the script's service optimization features.

## 📊 Performance Impact

### Expected Improvements
- **Boot Time**: 20-40% faster with startup optimizations
- **System Responsiveness**: Improved with memory and CPU tweaks
- **Gaming Performance**: Enhanced with gaming-specific optimizations
- **Storage Performance**: Better with defragmentation and cleanup
- **Network Speed**: Improved with TCP optimizations

### System Resources
- **Disk Space**: 5-15GB freed with comprehensive cleanup
- **RAM Usage**: Optimized memory management
- **CPU Usage**: Reduced background processes

## 🐛 Troubleshooting

### Common Issues
- **Script Won't Run**: Ensure administrator privileges
- **Options Not Working**: Check Windows version compatibility
- **System Instability**: Create restore point and revert changes
- **Missing Features**: Update to latest script version

### Recovery Options
1. **System Restore**: Revert to previous restore point
2. **Safe Mode**: Boot into safe mode for troubleshooting
3. **Reset Options**: Use Windows Reset to restore defaults

## 📝 Changelog

### v7.0 (2025)
- ✨ Added Advanced Performance Tweaks (2025) - 50+ new optimizations
- 🔧 Enhanced Windows 11 compatibility
- 🎯 Improved debloat system with 37+ app selections
- ⚡ Added cutting-edge CPU, memory, and GPU optimizations
- 🛡️ Enhanced security and privacy controls
-  ⚙️ Added automated system optimizations
-  🎮 Added comprehensive gaming optimizations
- 🔍 Improved Windows Search optimizations


### v6.3 (2024)
- 📱 Added Windows 11 specific optimizations
- 🗂️ Enhanced file explorer and UI tweaks
- 🔧 Added Copilot and Recall disabling
- 📊 Improved taskbar and start menu optimizations

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test thoroughly on multiple systems
4. Submit a pull request with detailed description

### Contribution Guidelines
- Test on Windows 11 latest builds
- Include proper error handling
- Document new features clearly
- Follow existing code style

## 📄 License

This project is licensed under the MIT License.

## ⚖️ Disclaimer

**USE AT YOUR OWN RISK**

This script is provided for educational and informational purposes only. The author cannot be held responsible for any damage, data loss, security issues, or system instability that may occur from using this script.

### Legal Notice
- Test in virtual environments first
- Backup all important data
- Understand each option before selecting
- Advanced users only - not recommended for beginners

## 🆘 Support

- **Issues**: Report bugs via GitHub Issues
- **Discussions**: Join community discussions
- **Documentation**: Check this README for usage instructions

---

**Remember**: With great power comes great responsibility. Use this tool wisely and always prioritize system stability and security.
