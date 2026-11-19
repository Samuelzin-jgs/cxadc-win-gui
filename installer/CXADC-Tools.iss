#define SourceRoot ".."
#define AppVersion "1.0.0"

[Setup]
AppId={{E916D992-28A9-4FF9-A10B-8E589BCFAD95}
AppName=CXADC Tools
AppVersion={#AppVersion}
AppPublisher=Samuelzin-jgs
DefaultDirName={autopf}\CXADC Tools
DefaultGroupName=CXADC Tools
OutputDir={#SourceRoot}\release
OutputBaseFilename=CXADC-Tools-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64
SetupLogging=yes
UninstallDisplayIcon={app}\Panel\Cxadc.ControlPanel.exe
LicenseFile={#SourceRoot}\LICENSE

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[CustomMessages]
english.DriverWarningTitle=Unsigned experimental driver
english.DriverWarning=The cxadc-win driver is experimental and unsigned. This setup will not change Secure Boot or Windows driver-signing settings. If Windows rejects the driver, the control panel and tools will still be installed.
english.DriverInstallFailed=The control panel and tools were installed, but Windows did not install the cxadc driver (pnputil exit code %1). Review the driver requirements in the installed README.
english.DriverLaunchFailed=The control panel and tools were installed, but Windows could not start pnputil to install the cxadc driver. Install it later from the Driver folder or Device Manager.
english.DriverTasksGroup=Driver:
english.CleanDriverTask=Clean driver install (remove existing cxadc-win driver packages first)
english.DriverInfMissing=The panel and tools were installed, but the cxadc-win driver INF was not found under %1, so the driver was not installed.
english.DriverEnumFailed=The panel and tools were installed, but the existing cxadc-win driver packages could not be listed. The clean install was aborted and the driver was not changed.
english.DriverCleanupFailed=Clean install aborted: Windows could not remove the existing driver package %1 (pnputil exit code %2). The driver was not reinstalled.
english.DriverVerifyFailed=pnputil reported success, but the cxadc-win driver package is not present in the Windows driver store. The driver is not installed.
english.DriverInstalled=The cxadc-win driver package was installed and is bound to a CXADC card.
english.DriverStagedOnly=The cxadc-win driver package was added to the Windows driver store, but no CXADC card (PCI\VEN_14F1&DEV_8800) is present. Connect the card and check Device Manager.
english.DriverDeviceNotStarted=The cxadc-win driver package was installed and the CXADC card is present, but the device is not started (code %1). Check the device status in Device Manager.
english.DriverStateUnknown=The cxadc-win driver package was installed, but the device status could not be checked. Open Device Manager to confirm the card is using the driver.
brazilianportuguese.DriverWarningTitle=Driver experimental sem assinatura
brazilianportuguese.DriverWarning=O driver cxadc-win é experimental e não tem assinatura. Este instalador não altera o Secure Boot nem as configurações de assinatura de drivers do Windows. Se o Windows rejeitar o driver, o painel e as ferramentas ainda serão instalados.
brazilianportuguese.DriverInstallFailed=O painel e as ferramentas foram instalados, mas o Windows não instalou o driver cxadc (código de saída do pnputil: %1). Consulte os requisitos do driver no README instalado.
brazilianportuguese.DriverLaunchFailed=O painel e as ferramentas foram instalados, mas o Windows não conseguiu iniciar o pnputil para instalar o driver cxadc. Instale-o depois pela pasta Driver ou pelo Gerenciador de Dispositivos.
brazilianportuguese.DriverTasksGroup=Driver:
brazilianportuguese.CleanDriverTask=Instalação limpa do driver (remove antes os pacotes cxadc-win existentes)
brazilianportuguese.DriverInfMissing=O painel e as ferramentas foram instalados, mas o INF do driver cxadc-win não foi encontrado em %1, portanto o driver não foi instalado.
brazilianportuguese.DriverEnumFailed=O painel e as ferramentas foram instalados, mas não foi possível listar os pacotes cxadc-win existentes. A instalação limpa foi interrompida e o driver não foi alterado.
brazilianportuguese.DriverCleanupFailed=Instalação limpa interrompida: o Windows não conseguiu remover o pacote de driver existente %1 (código de saída do pnputil: %2). O driver não foi reinstalado.
brazilianportuguese.DriverVerifyFailed=O pnputil informou sucesso, mas o pacote cxadc-win não está presente no repositório de drivers do Windows. O driver não está instalado.
brazilianportuguese.DriverInstalled=O pacote cxadc-win foi instalado e está associado a uma placa CXADC.
brazilianportuguese.DriverStagedOnly=O pacote cxadc-win foi adicionado ao repositório de drivers do Windows, mas nenhuma placa CXADC (PCI\VEN_14F1&DEV_8800) está presente. Conecte a placa e verifique o Gerenciador de Dispositivos.
brazilianportuguese.DriverDeviceNotStarted=O pacote cxadc-win foi instalado e a placa CXADC está presente, mas o dispositivo não está iniciado (código %1). Verifique o status do dispositivo no Gerenciador de Dispositivos.
brazilianportuguese.DriverStateUnknown=O pacote cxadc-win foi instalado, mas não foi possível verificar o status do dispositivo. Abra o Gerenciador de Dispositivos para confirmar que a placa usa o driver.

[Tasks]
Name: "cleandriver"; Description: "{cm:CleanDriverTask}"; GroupDescription: "{cm:DriverTasksGroup}"; Flags: unchecked
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Files]
Source: "{#SourceRoot}\release\driver\*"; DestDir: "{app}\Driver"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceRoot}\release\app\*"; DestDir: "{app}\Panel"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceRoot}\release\bin\*"; DestDir: "{app}\Tools"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceRoot}\release\clockgen_firmware\*"; DestDir: "{app}\ClockgenFirmware"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceRoot}\release\license\*"; DestDir: "{app}\Licenses"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceRoot}\README.md"; DestDir: "{app}"; DestName: "README.md"; Flags: ignoreversion

[Icons]
Name: "{group}\CXADC Control Panel"; Filename: "{app}\Panel\Cxadc.ControlPanel.exe"; WorkingDir: "{app}\Panel"
Name: "{autodesktop}\CXADC Control Panel"; Filename: "{app}\Panel\Cxadc.ControlPanel.exe"; WorkingDir: "{app}\Panel"; Tasks: desktopicon

[Code]
procedure InitializeWizard;
var
  WarningPage: TOutputMsgWizardPage;
begin
  WarningPage := CreateOutputMsgPage(wpWelcome,
    CustomMessage('DriverWarningTitle'),
    CustomMessage('DriverWarningTitle'),
    CustomMessage('DriverWarning'));
end;

var
  DriverStatusText: String;

function TrimValue(const Line: String): String;
var
  P: Integer;
begin
  P := Pos(':', Line);
  if P = 0 then
    Result := Trim(Line)
  else
    Result := Trim(Copy(Line, P + 1, Length(Line) - P));
end;

function IsPubNameDriverName(const Value: String): Boolean;
var
  V: String;
  I: Integer;
begin
  Result := False;
  V := Lowercase(Trim(Value));
  if (Length(V) < 8) or (Copy(V, 1, 3) <> 'oem') or (Copy(V, Length(V) - 3, 4) <> '.inf') then
    Exit;
  for I := 4 to Length(V) - 4 do
    if (V[I] < '0') or (V[I] > '9') then
      Exit;
  Result := True;
end;

function IsCxadcInfName(const Value: String): Boolean;
begin
  Result := SameText(ExtractFileName(Trim(Value)), 'cxadc-win.inf');
end;

function FindDriverInfIn(const Dir: String): String;
var
  FindRec: TFindRec;
  Sub: String;
begin
  Result := '';
  if not FindFirst(Dir + '\*', FindRec) then
    Exit;
  try
    repeat
      if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
      begin
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          Sub := FindDriverInfIn(Dir + '\' + FindRec.Name);
          if Sub <> '' then
          begin
            Result := Sub;
            Exit;
          end;
        end;
      end
      else if SameText(FindRec.Name, 'cxadc-win.inf') then
      begin
        Result := Dir + '\' + FindRec.Name;
        Exit;
      end;
    until not FindNext(FindRec);
  finally
    FindClose(FindRec);
  end;
end;

function FindDriverInf(const BaseDir: String): String;
begin
  Result := '';
  if DirExists(BaseDir) then
    Result := FindDriverInfIn(BaseDir);
end;

function SystemDir: String;
begin
  if IsWin64 then
    Result := ExpandConstant('{sysnative}')
  else
    Result := ExpandConstant('{sys}');
end;

function RunAndCapture(const FileName, Params, OutFile: String; var ResultCode: Integer): Boolean;
var
  Cmd: String;
begin
  DeleteFile(OutFile);
  Cmd := '/c ' + FileName + ' ' + Params + ' > "' + OutFile + '" 2>&1';
  Result := Exec(ExpandConstant('{cmd}'), Cmd, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

function CollectCxadcDriverPackages(Packages: TStringList): Boolean;
var
  EnumFile: String;
  Lines: TArrayOfString;
  I, ResultCode: Integer;
  Line, Value, PubName, Original: String;
begin
  Result := False;
  Packages.Clear;
  EnumFile := ExpandConstant('{tmp}\cxadc-driver-enum.txt');
  if not RunAndCapture(SystemDir + '\pnputil.exe', '/enum-drivers', EnumFile, ResultCode) then
    Exit;
  if ResultCode <> 0 then
    Exit;
  if not LoadStringsFromFile(EnumFile, Lines) then
    Exit;
  PubName := '';
  Original := '';
  for I := 0 to GetArrayLength(Lines) - 1 do
  begin
    Line := Trim(Lines[I]);
    if Line = '' then
    begin
      if (PubName <> '') and IsCxadcInfName(Original) then
        Packages.Add(PubName);
      PubName := '';
      Original := '';
    end
    else
    begin
      Value := TrimValue(Line);
      if IsPubNameDriverName(Value) then
        PubName := Value
      else if IsCxadcInfName(Value) then
        Original := Value;
    end;
  end;
  if (PubName <> '') and IsCxadcInfName(Original) then
    Packages.Add(PubName);
  Result := True;
end;

function QueryCxadcDeviceState: Integer;
var
  ScriptFile, Script: String;
  ResultCode: Integer;
begin
  Result := -1;
  ScriptFile := ExpandConstant('{tmp}\cxadc-device-state.ps1');
  Script :=
    '$ErrorActionPreference = ''SilentlyContinue''' + #13#10 +
    '$devices = @(Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -like ''PCI\VEN_14F1&DEV_8800*'' })' + #13#10 +
    'if ($devices.Count -eq 0) { exit 2 }' + #13#10 +
    'if (@($devices | Where-Object { $_.Status -eq ''OK'' }).Count -gt 0) { exit 0 }' + #13#10 +
    'exit 3' + #13#10;
  if not SaveStringToFile(ScriptFile, Script, False) then
    Exit;
  try
    if not Exec(SystemDir + '\WindowsPowerShell\v1.0\powershell.exe',
      '-NoProfile -NonInteractive -ExecutionPolicy Bypass -File "' + ScriptFile + '"',
      '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
      Exit;
    Result := ResultCode;
  finally
    DeleteFile(ScriptFile);
  end;
end;

procedure ReportDriverStatus(const MessageText: String; const IsError: Boolean);
begin
  DriverStatusText := MessageText;
  Log(MessageText);
  if not WizardSilent then
  begin
    if IsError then
      MsgBox(MessageText, mbError, MB_OK)
    else
      MsgBox(MessageText, mbInformation, MB_OK);
  end;
end;

function InstallCxadcDriver: Boolean;
var
  DriverInf, PnPUtil, Params: String;
  Packages: TStringList;
  I, ResultCode, DeviceState: Integer;
  CleanInstall: Boolean;
begin
  Result := False;
  DriverInf := FindDriverInf(ExpandConstant('{app}\Driver'));
  if DriverInf = '' then
  begin
    ReportDriverStatus(
      FmtMessage(CustomMessage('DriverInfMissing'), [ExpandConstant('{app}\Driver')]),
      True);
    Exit;
  end;
  Log('Using driver INF: ' + DriverInf);

  PnPUtil := SystemDir + '\pnputil.exe';
  CleanInstall := WizardIsTaskSelected('cleandriver');

  if CleanInstall then
  begin
    Packages := TStringList.Create;
    try
      if not CollectCxadcDriverPackages(Packages) then
      begin
        ReportDriverStatus(CustomMessage('DriverEnumFailed'), True);
        Exit;
      end;
      Log(Format('Existing cxadc-win driver packages found: %d', [Packages.Count]));
      for I := 0 to Packages.Count - 1 do
      begin
        Params := '/delete-driver ' + Packages[I] + ' /uninstall /force';
        if not Exec(PnPUtil, Params, '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
        begin
          ReportDriverStatus(
            FmtMessage(CustomMessage('DriverCleanupFailed'), [Packages[I], 'launch failed']),
            True);
          Exit;
        end;
        if (ResultCode <> 0) and (ResultCode <> 3010) then
        begin
          ReportDriverStatus(
            FmtMessage(CustomMessage('DriverCleanupFailed'), [Packages[I], IntToStr(ResultCode)]),
            True);
          Exit;
        end;
        Log(Format('Removed driver package %s (exit code %d)', [Packages[I], ResultCode]));
      end;
    finally
      Packages.Free;
    end;
  end;

  Params := '/add-driver "' + DriverInf + '" /install';
  if not Exec(PnPUtil, Params, '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
  begin
    ReportDriverStatus(CustomMessage('DriverLaunchFailed'), True);
    Exit;
  end;
  if (ResultCode <> 0) and (ResultCode <> 3010) then
  begin
    ReportDriverStatus(
      FmtMessage(CustomMessage('DriverInstallFailed'), [IntToStr(ResultCode)]), True);
    Exit;
  end;
  Log(Format('pnputil /add-driver finished with exit code %d', [ResultCode]));

  Packages := TStringList.Create;
  try
    if not CollectCxadcDriverPackages(Packages) or (Packages.Count = 0) then
    begin
      ReportDriverStatus(CustomMessage('DriverVerifyFailed'), True);
      Exit;
    end;
    Log(Format('Driver package staged in the driver store: %s', [Packages[0]]));
  finally
    Packages.Free;
  end;

  DeviceState := QueryCxadcDeviceState;
  case DeviceState of
    0: ReportDriverStatus(CustomMessage('DriverInstalled'), False);
    2: ReportDriverStatus(CustomMessage('DriverStagedOnly'), False);
    3: ReportDriverStatus(
         FmtMessage(CustomMessage('DriverDeviceNotStarted'), [IntToStr(DeviceState)]), True);
  else
    ReportDriverStatus(CustomMessage('DriverStateUnknown'), False);
  end;
  Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
    InstallCxadcDriver;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if (CurPageID = wpFinished) and (DriverStatusText <> '') then
    WizardForm.FinishedLabel.Caption :=
      WizardForm.FinishedLabel.Caption + #13#10#13#10 + DriverStatusText;
end;
