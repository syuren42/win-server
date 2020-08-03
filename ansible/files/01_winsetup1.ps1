# Filename: helloworld.ps1
Write-Host
Write-Host 'Hello World!'
Write-Host "Good-bye World! `n"
# end of script


#「C:\lang.iso」をマウントします。
$mountResult = Mount-DiskImage C:\Windows\TEMP\windowsserver2019-jplangpack.iso -PassThru

#マウントしたISOのドライブレターを取得します。
$driveLetter = ($mountResult | Get-Volume).DriveLetter

#パスを格納
$lppath = $driveLetter + ":\x64\langpacks\Microsoft-Windows-Server-Language-Pack_x64_ja-jp.cab"

#「Lpksetup.exe」コマンドを使って日本語languagePackをインストールします。インストール後再起動します。
C:\windows\system32\Lpksetup.exe /i ja-JP /f /s /p $lppath


#ユーザーが使用する言語を日本語にします。
Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force

#入力する言語を日本語で上書きします。
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

#MS-IMEの入力方式を設定します。
Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar
