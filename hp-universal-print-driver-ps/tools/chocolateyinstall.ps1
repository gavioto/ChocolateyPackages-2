﻿$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-ps' 
$url            = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99375-14/upd-ps-x32-6.4.1.22169.exe'
$checksum       = 'EE3585716C5883FCB17241C49311F5232C85072D72448A4FA4F11B54892D237E'
$url64          = 'http://ftp.hp.com/pub/softlib/software13/COL40842/ds-99376-14/upd-ps-x64-6.4.1.22169.exe'
$checksum64     = '4B3278D77335E5B76339AE775CE1324274796945DEDC3A4424D31057279D0C68'
$installerType  = 'ZIP'
$silentArgs     = '/dm /nd /npf /q /h'
$validExitCodes = @(0, 3010, 1641)
$softwareName   = ''
$fileLocation   = "$toolsDir\unzippedfiles\install.exe"

New-Item $fileLocation -type directory | out-null

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\unzippedfiles"
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -recurse | out-null
