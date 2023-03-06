write-host "There are a total of $($args.count) arguments"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
} 

If ($args.count -ne 4) {
    echo "4 Arguments are needed <project.json file> <swf folder> <d2o folder> <d2i folder>"
	exit
}

$CALL_PATH = $pwd
$UIPATH = "$env:LOCALAPPDATA\Programs\UiPath\Studio"
$PROJECT_FILE = Resolve-Path -Path $args[0]
$PROJECT_PATH = Split-Path $PROJECT_FILE -Parent
$VERSION = (Get-Content -Path "$PROJECT_FILE" -Raw | ConvertFrom-Json).projectVersion
$NUPKG_FILE = "$PROJECT_PATH\U1.$VERSION.nupkg"

Write-Host $UIPATH
Write-Host $PROJECT_FILE
Write-Host $PROJECT_PATH
Write-Host $VERSION
Write-Host $NUPKG_FILE

$SWF_FOLDER = Resolve-Path $args[1]
$D2O_FOLDER = Resolve-Path $args[2]
$D2I_FOLDER = Resolve-Path $args[3]
$INPUT = "{""swf_folder"": '$SWF_FOLDER', ""d2o_folder"": '$D2O_FOLDER', ""d2i_folder"": '$D2I_FOLDER'}"
$INPUT = $INPUT.replace("\", "//")

Write-Host $SWF_FOLDER
Write-Host $D2O_FOLDER
Write-Host $D2I_FOLDER
Write-Host $INPUT

Set-Location $UIPATH
.\UiRobot.exe pack "$PROJECT_FILE" -o "$PROJECT_PATH" -v "$VERSION"
.\UiRobot.exe execute --file "$NUPKG_FILE" --input "$INPUT"
Set-Location $CALL_PATH
