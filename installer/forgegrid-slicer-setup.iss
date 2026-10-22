[Setup]
AppName=forgegrid slicer
AppVersion=1.0.0
AppPublisher=Anthread Engineering
AppPublisherURL=https://github.com/Anthread-Engineering/forgegrid-slicer
DefaultDirName={autopf}\forgegrid-slicer
DefaultGroupName=forgegrid slicer
OutputDir=C:\forgegrid-slicer-dev\dist
OutputBaseFilename=forgegrid-slicer-setup-x64
Compression=lzma2
SolidCompression=yes
SetupIconFile=C:\forgegrid-slicer-dev\dist\forgegrid-slicer\share\cura\resources\themes\forgegrid\images\cura-icon.ico
UninstallDisplayIcon={app}\forgegrid-slicer.exe
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
LicenseFile=C:\forgegrid-slicer-dev\repo\LICENSE

[Files]
Source: "C:\forgegrid-slicer-dev\dist\forgegrid-slicer\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\forgegrid slicer"; Filename: "{app}\forgegrid-slicer.exe"
Name: "{autodesktop}\forgegrid slicer"; Filename: "{app}\forgegrid-slicer.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create desktop shortcut"; GroupDescription: "Additional icons:"

[Registry]
Root: HKCR; Subkey: ".stl"; ValueType: string; ValueName: ""; ValueData: "forgegrid-slicer.stl"; Flags: uninsdeletevalue; Tasks: associateSTL
Root: HKCR; Subkey: "forgegrid-slicer.stl"; ValueType: string; ValueName: ""; ValueData: "STL Model File"; Flags: uninsdeletekey; Tasks: associateSTL
Root: HKCR; Subkey: "forgegrid-slicer.stl\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\forgegrid-slicer.exe"" ""%1"""; Tasks: associateSTL
Root: HKCR; Subkey: ".3mf"; ValueType: string; ValueName: ""; ValueData: "forgegrid-slicer.3mf"; Flags: uninsdeletevalue; Tasks: associate3MF
Root: HKCR; Subkey: "forgegrid-slicer.3mf"; ValueType: string; ValueName: ""; ValueData: "3MF Model File"; Flags: uninsdeletekey; Tasks: associate3MF
Root: HKCR; Subkey: "forgegrid-slicer.3mf\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\forgegrid-slicer.exe"" ""%1"""; Tasks: associate3MF

[Tasks]
Name: "associateSTL"; Description: "Associate .stl files with forgegrid slicer"; GroupDescription: "File associations:"; Flags: unchecked
Name: "associate3MF"; Description: "Associate .3mf files with forgegrid slicer"; GroupDescription: "File associations:"; Flags: unchecked

[Run]
Filename: "{app}\forgegrid-slicer.exe"; Description: "Launch forgegrid slicer"; Flags: nowait postinstall skipifsilent
