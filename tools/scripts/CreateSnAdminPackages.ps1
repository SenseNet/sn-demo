$srcPath = [System.IO.Path]::GetFullPath(($PSScriptRoot + '\..\..\src'))
$packageSourcePath = "$srcPath\snadmin\install-demo"

if (!(Test-Path "$packageSourcePath\bin"))
{
	New-Item "$packageSourcePath\bin" -Force -ItemType Directory
}

Copy-Item $srcPath\SenseNet.Demo\bin\Release\SenseNet.Demo.* "$packageSourcePath\bin" -Force

$packageContainerPath = "$srcPath\snadmin"

$PackageFolders = (Get-ChildItem $packageContainerPath -Directory)
foreach ($folder in $PackageFolders) {
	$FolderPath = $Folder.FullName
	$PackagePath = "$($FolderPath).zip" 
	Compress-Archive -Path "$FolderPath\*" -Force -CompressionLevel Optimal -DestinationPath $PackagePath
}