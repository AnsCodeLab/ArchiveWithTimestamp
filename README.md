# Timestamp RAR Archiver Tool

## Overview
A Windows utility that adds a context menu option to create timestamped ZIP archives of folders directly from Windows Explorer. This tool integrates with WinRAR to provide a convenient way to backup or archive directories with automatic timestamp generation.

## Purpose
- **Quick Backup:** Create instant backups of important folders with timestamps
- **Version Control:** Maintain multiple versions of directories with clear date/time stamps
- **Organization:** Automatically organize archives with consistent naming conventions
- **Convenience:** Right-click integration eliminates the need for manual archive creation

## Components

### Files Included
1. **`timestamp_rar.bat`** - Main batch script that handles the archiving process
2. **`timestamp_rar.reg`** - Registry file that adds the context menu integration
3. **`README.md`** - This documentation file

### System Requirements
- **Operating System:** Windows 7 or later
- **WinRAR:** Must be installed at `C:\Program Files\WinRAR\WinRAR.exe`
- **Permissions:** Administrator access required for registry modification

## Installation

### Step 1: Verify Prerequisites
1. Ensure WinRAR is installed on your system
2. Verify WinRAR location: `C:\Program Files\WinRAR\WinRAR.exe`
3. If WinRAR is installed elsewhere, note the path for customization

### Step 2: Install Context Menu Integration
1. **Edit the registry file:** Open `timestamp_rar.reg` in a text editor and replace `D:\\YourPath\\` with the actual path where you placed the batch file
2. **Right-click** on `timestamp_rar.reg`
3. Select **"Merge"** or **"Open"**
4. Click **"Yes"** when prompted to add to registry
5. Click **"OK"** to confirm successful addition

### Step 3: Verify Installation
1. Navigate to any folder in Windows Explorer
2. **Right-click** on the folder
3. Look for **"Archive with Timestamp (ZIP)"** in the context menu

## Usage

### Basic Operation
1. **Navigate** to the folder you want to archive in Windows Explorer
2. **Right-click** on the folder
3. Select **"Archive with Timestamp (ZIP)"** from the context menu
4. **Wait** for the archiving process to complete
5. **Locate** the created ZIP file in the same directory as the original folder

### Archive Naming Convention
Archives are automatically named using the following pattern:
```
{FolderName}_{YYYYMMDD_HHMM}.zip
```

**Examples:**
- Folder: `MyDocuments` → Archive: `MyDocuments_20250912_1430.zip`
- Folder: `Project Files` → Archive: `Project Files_20250912_1430.zip`
- Folder: `Photos_2024` → Archive: `Photos_2024_20250912_1430.zip`

### Command Line Usage (Advanced)
You can also run the script directly from Command Prompt or PowerShell:
```batch
"D:\YourPath\timestamp_rar.bat" "C:\Path\To\Your\Folder"
```

### Batch Processing
To archive multiple folders at once, create a batch file:
```batch
@echo off
call "D:\YourPath\timestamp_rar.bat" "C:\Folder1"
call "D:\YourPath\timestamp_rar.bat" "C:\Folder2"
call "D:\YourPath\timestamp_rar.bat" "C:\Folder3"
pause
```

## Technical Details

### Script Functionality
The `timestamp_rar.bat` script performs the following operations:

1. **Input Processing:** Accepts folder path as command-line argument
2. **Path Parsing:** Extracts folder name and parent directory
3. **Timestamp Generation:** Creates timestamp in `YYYYMMDD_HHMM` format
4. **Archive Creation:** Uses WinRAR to create ZIP archive with relative paths
5. **Output Placement:** Places archive in the same directory as source folder

### WinRAR Command Parameters
The script uses the following WinRAR switches:
- `a` - Add files to archive
- `afzip` - Force ZIP format (not RAR)
- `r` - Recurse through subdirectories
- `ep1` - Exclude base folder path from archive

### Registry Integration
The `.reg` file adds the following registry entries:
```
[HKEY_CLASSES_ROOT\Directory\shell\ArchiveWithTimestamp]
@="Archive with Timestamp (ZIP)"

[HKEY_CLASSES_ROOT\Directory\shell\ArchiveWithTimestamp\command]
@="\"D:\\YourPath\\timestamp_rar.bat\" \"%1\""
```

## Customization

### Changing WinRAR Path
If WinRAR is installed in a different location, edit `timestamp_rar.bat`:
```batch
:: Change this line:
"C:\Program Files\WinRAR\WinRAR.exe" a -afzip -r -ep1 "!archive!" "!name!"

:: To your WinRAR location:
"C:\Your\Custom\Path\WinRAR.exe" a -afzip -r -ep1 "!archive!" "!name!"
```

### Modifying Timestamp Format
To change the timestamp format, edit the timestamp generation section:
```batch
:: Current format: YYYYMMDD_HHMM
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%"

:: Example: YYYY-MM-DD format
set "timestamp=%date:~10,4%-%date:~4,2%-%date:~7,2%"
```

### Changing Archive Format
To create RAR files instead of ZIP:
```batch
:: Change from:
"C:\Program Files\WinRAR\WinRAR.exe" a -afzip -r -ep1 "!archive!" "!name!"

:: To:
"C:\Program Files\WinRAR\WinRAR.exe" a -afrar -r -ep1 "!archive!" "!name!"
```

### Modifying Output Location
To save archives to a specific directory:
```batch
:: Add after timestamp generation:
set "output_dir=C:\YourBackupPath\"
set "archive=!output_dir!!name!_!timestamp!.zip"
```

## Troubleshooting

### Common Issues

#### Context Menu Not Appearing
**Cause:** Registry entries not properly installed
**Solution:**
1. Run Command Prompt as Administrator
2. Navigate to the script directory
3. Run: `regedit /s timestamp_rar.reg`
4. Restart Windows Explorer

#### WinRAR Not Found Error
**Cause:** WinRAR not installed or in different location
**Solution:**
1. Install WinRAR from [rarlab.com](https://www.rarlab.com)
2. Or edit the script with correct WinRAR path

#### Archive Creation Fails
**Possible Causes & Solutions:**
- **Insufficient disk space:** Free up space on target drive
- **Folder in use:** Close programs using files in the folder
- **Permission issues:** Run as Administrator
- **Special characters in path:** Rename folders to remove special characters

#### Timestamp Format Issues
**Cause:** Regional date/time format differences
**Solution:** Modify timestamp parsing based on your system's date format

### Error Codes
- **Exit Code 0:** Success
- **Exit Code 1:** Warning (partial success)
- **Exit Code 2:** Fatal error
- **Exit Code 3:** CRC error
- **Exit Code 4:** Locked archive
- **Exit Code 5:** Write error

## Security Considerations

### Registry Modifications
- The registry file requires administrator privileges
- Creates system-wide context menu entries
- Modifies `HKEY_CLASSES_ROOT` which affects all users

### Script Execution
- The batch script runs with user privileges
- Accesses file system and executes WinRAR
- No network connectivity or external downloads

### Best Practices
1. Review script contents before installation
2. Install only from trusted sources
3. Keep WinRAR updated for security patches
4. Regularly backup your registry before modifications

## Uninstallation

### Remove Context Menu
Create a removal registry file (`remove_timestamp_rar.reg`):
```
Windows Registry Editor Version 5.00

[-HKEY_CLASSES_ROOT\Directory\shell\ArchiveWithTimestamp]
```

### Complete Removal Steps
1. Run the removal registry file as Administrator
2. Delete the script directory: `D:\YourPath\`
3. Restart Windows Explorer

## Support and Maintenance

### Updating the Tool
1. Backup your current installation
2. Replace files with newer versions
3. Re-run the registry file if needed
4. Test functionality with a sample folder

### Log Files
For debugging, you can add logging to the batch script:
```batch
:: Add at the beginning of the script
echo %date% %time% - Processing folder: %1 >> "D:\YourPath\log.txt"
```

## Version History
- **v1.0** - Initial release with basic timestamp archiving functionality
- Current version creates ZIP archives with YYYYMMDD_HHMM timestamp format

## License
This tool is provided as-is for personal and educational use. Modify and distribute freely while maintaining attribution.

---

*Last updated: September 12, 2025*
