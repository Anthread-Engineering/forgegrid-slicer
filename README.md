# forgegrid slicer

A 3D printer slicer built on [UltiMaker Cura 5.9](https://github.com/Ultimaker/Cura), customized for ForgeGrid printers.

> **This project is a fork of [UltiMaker Cura](https://github.com/Ultimaker/Cura)**, an open-source 3D printing slicer released under the LGPLv3 license. We gratefully acknowledge the UltiMaker team and all Cura contributors for their work.

## Download

Go to the [Releases](https://github.com/Anthread-Engineering/forgegrid-slicer/releases) page and download:

- **`forgegrid-slicer-setup-x64.exe`** — Windows installer (recommended)
- **`forgegrid-slicer-portable.zip`** — Portable version (extract and run)

## What's Different from Cura

- ForgeGrid branding (splash screen, icons, theme)
- ForgeGrid printer definitions and quality profiles pre-installed
- ForgeGrid printers appear first in the "Add Printer" dialog
- Update checker points to this repository's releases
- Removed UltiMaker cloud/Digital Factory integration from the printer setup flow

## Repository Structure

```
definitions/          ForgeGrid printer definition files (.def.json)
extruders/            ForgeGrid extruder definitions
quality/forgegrid/    Print quality profiles (Draft, Normal, Fine)
plugins/              Modified/stub plugins
qml-patches/          Rebranded QML UI files
theme/                ForgeGrid theme (colors, icons, images)
branding/             Splash screen and brand assets
installer/            Inno Setup script for building the Windows installer
latest.json           Version manifest for the built-in update checker
install.ps1           Script to apply customizations to a Cura 5.9 base
```

## Building from Scratch

### Prerequisites

- [UltiMaker Cura 5.9.0](https://github.com/Ultimaker/Cura/releases/tag/5.9.0) installed or extracted
- [Inno Setup 7](https://jrsoftware.org/isinfo.php) (for building the installer)
- Windows 10/11 x64
- PowerShell 5.1+

### Steps

1. **Get the Cura 5.9 base**: Install Cura 5.9.0 or extract its portable package
2. **Apply customizations**:
   ```powershell
   .\install.ps1 -DistDir "C:\path\to\forgegrid-slicer"
   ```
3. **Build the portable ZIP**:
   ```powershell
   Compress-Archive -Path "C:\path\to\forgegrid-slicer" -DestinationPath "forgegrid-slicer-portable.zip"
   ```
4. **Build the installer**: Open `installer\forgegrid-slicer-setup.iss` in Inno Setup and compile

### Adding a New ForgeGrid Printer

1. Create a definition file in `definitions/` (see `forgegrid_bedslinger.def.json` as template)
2. Create a matching extruder file in `extruders/`
3. Optionally add quality profiles in `quality/forgegrid/`
4. Set `"manufacturer": "ForgeGrid"` in the definition so it appears under the ForgeGrid section

## Releasing a New Version

1. Update `latest.json` with the new version numbers
2. Build the portable ZIP and installer EXE
3. Create a new GitHub Release with a tag like `v1.0.0`
4. Upload both files as release assets
5. The built-in update checker will notify users of the new version

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).

This is a fork of [UltiMaker Cura](https://github.com/Ultimaker/Cura), which is released under the [GNU Lesser General Public License v3.0](https://github.com/Ultimaker/Cura/blob/main/LICENSE). The original Cura engine ([CuraEngine](https://github.com/Ultimaker/CuraEngine)) is licensed under the [GNU Affero General Public License v3.0](https://github.com/Ultimaker/CuraEngine/blob/main/LICENSE).

## Credits

- [UltiMaker Cura](https://github.com/Ultimaker/Cura) — the open-source slicer this project is built on
- [Uranium](https://github.com/Ultimaker/Uranium) — the application framework
- [CuraEngine](https://github.com/Ultimaker/CuraEngine) — the slicing engine
- Built by [Anthread Engineering](https://github.com/Anthread-Engineering)
