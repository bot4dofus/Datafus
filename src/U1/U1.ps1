write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
} 

If ($args.count -ne 5) {
    echo "5 Arguments are needed <project.json file> <swf folder> <d2o folder> <d2i folder>"
	exit
}

$CALL_PATH = $pwd
$UIPATH = "$env:LOCALAPPDATA\Programs\UiPath\Studio"
$PROJECT_FILE = Resolve-Path -Path $args[0]
$PROJECT_PATH = Split-Path $PROJECT_FILE -Parent
$VERSION = (Get-Content -Path "$PROJECT_FILE" -Raw | ConvertFrom-Json).projectVersion
$NUPKG_FILE = "$PROJECT_PATH\U1.$VERSION.nupkg"

Write-Host Uipath: $UIPATH
Write-Host Project file: $PROJECT_FILE
Write-Host Project path: $PROJECT_PATH
Write-Host Version: $VERSION
Write-Host Nupkg file: $NUPKG_FILE

Write-Host "Creating folder $args[1]"
md $args[1] -ea 0

Write-Host "Creating folder $args[2]"
md $args[2] -ea 0

Write-Host "Creating folder $args[3]"
md $args[3] -ea 0

Write-Host "Creating folder $args[4]"
md $args[4] -ea 0

$SWF_FOLDER = Resolve-Path $args[1]
$D2O_FOLDER = Resolve-Path $args[2]
$D2I_FOLDER = Resolve-Path $args[3]
$VERSION_FOLDER = Resolve-Path $args[4]
$INPUT = "{""swf_folder"": '$SWF_FOLDER', ""d2o_folder"": '$D2O_FOLDER', ""d2i_folder"": '$D2I_FOLDER', ""version_folder"": '$VERSION_FOLDER'}"
$INPUT = $INPUT.replace("\", "//")

Write-Host Swf folder: $SWF_FOLDER
Write-Host D2o folder: $D2O_FOLDER
Write-Host D2i folder: $D2I_FOLDER
Write-Host Version folder: $VERSION_FOLDER
Write-Host Input: $INPUT

Set-Location $UIPATH
.\UiRobot.exe pack "$PROJECT_FILE" -o "$PROJECT_PATH" -v "$VERSION"
.\UiRobot.exe execute --file "$NUPKG_FILE" --input "$INPUT"
Set-Location $CALL_PATH
