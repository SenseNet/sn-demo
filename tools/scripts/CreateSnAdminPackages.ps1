$srcPath = [System.IO.Path]::GetFullPath(($PSScriptRoot + '\..\..\src'))
$packageSourcePath = "$srcPath\snadmin\install-demo"
$demoPackageSourcePath = "$srcPath\snadmin\install-demo-dev"

if (!(Test-Path "$packageSourcePath\bin"))
{
	New-Item "$packageSourcePath\bin" -Force -ItemType Directory
}

Copy-Item $srcPath\SenseNet.Demo\bin\Release\SenseNet.Demo.* "$packageSourcePath\bin" -Force

if (!(Test-Path "$demoPackageSourcePath\bin"))
{
	New-Item "$demoPackageSourcePath\bin" -Force -ItemType Directory
}

Copy-Item $srcPath\SenseNet.Demo\bin\Release\SenseNet.Demo.* "$demoPackageSourcePath\bin" -Force

$packageContainerPath = "$srcPath\snadmin"

$PackageFolders = (Get-ChildItem $packageContainerPath -Directory)
foreach ($folder in $PackageFolders) {
	$FolderPath = $Folder.FullName
	$PackagePath = "$($FolderPath).zip" 
	Compress-Archive -Path "$FolderPath\*" -Force -CompressionLevel Optimal -DestinationPath $PackagePath
}