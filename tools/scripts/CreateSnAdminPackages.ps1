$srcPath = [System.IO.Path]::GetFullPath(($PSScriptRoot + '\..\..\src'))
$packageSourcePath = "$srcPath\snadmin\install-demo"
$packagePath = "$srcPath\snadmin\install-demo.zip"

if (!(Test-Path "$packageSourcePath\bin"))
{
	New-Item "$packageSourcePath\bin" -Force -ItemType Directory
}

Copy-Item $srcPath\SenseNet.Demo\bin\Release\SenseNet.Demo.* "$packageSourcePath\bin" -Force

Compress-Archive -Path "$packageSourcePath\*" -Force -CompressionLevel Optimal -DestinationPath $packagePath