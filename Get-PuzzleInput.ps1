# Browse to adventofcode.com, log in using your preferred auth method.
# Open your browsers development tools, and find the Cookie named 'session'.
# For Chrome / Edge that is: F12 > Application > Storage > Cookies > https://adventofcode.com > session
# Store its value in a file named Cookie in the same folder as this script.
$sessionCookie = Get-Content .\Cookie

$ErrorActionPreference = 'stop'

if ([string]::IsNullOrEmpty($sessionCookie)) {
    Write-Error "Please save the value of the 'session' cookie from your browser and store it in a file named 'Cookie' in this directory. More info in the comments of this script."
}

$date = Get-Date
$year = $date.Year
$day = $date.Day
$month = $date.Month

$languages = @{
    TypeScript = @{
        SetupCommand = @'
            npm init -y
            npm install -g ts-node typescript '@types/node'
            npm install typescript --save-dev

            npx tsc --init --rootDir '' --outDir lib --esModuleInterop --resolveJsonModule --lib es6,dom  --module commonjs
            if (-not (get-content ..\.gitignore | where {$_ -eq 'node_modules'})) {
                'node_modules' >> ..\.gitignore
            }
'@
        FileExtension = 'ts'
        CommentChars = '//'
        FileTemplate = @'
import * as fs from 'fs';

let fileContent = fs.readFileSync('input.txt', 'utf8');
console.log(fileContent);
'@
    } 
    Python = @{
        FileExtension = 'py'
        CommentChars = '#'
        FileTemplate = @'
import os

currentWorkingDir = os.path.realpath(
    os.path.join(os.getcwd(), os.path.dirname(__file__)))

with open(currentWorkingDir + '\input.txt') as f:
    lines = f.readlines()
'@
    }
    PowerShell = @{
        FileExtension = 'ps1'
        CommentChars = '#'
        FileTemplate = @'
# example input
$in = Get-Content -Path .\exampleinput.txt

# puzzle input
# $in = Get-Content -Path .\input.txt

'@
    }
}

if (-not (Test-Path .\.gitignore)) {
@'
.vscode
Cookie
*/input.txt
'@ > .\.gitignore
}


""
Write-Host "Choose a language template to set up." -ForegroundColor Green
"Available language templates:"
" - $($languages.Keys -join "`n - ")"
""
$Language = Read-Host "What language would you like to use primarily? "
if ($Language -notin $languages.Keys) {
    throw "Type a valid language name (options: $($languages.Keys -join ', '))"
}


$fileTemplate = $languages.$Language.FileTemplate
$fileExtension = $languages.$Language.FileExtension
$commentChars = $languages.$Language.CommentChars

#region functions
function TryGrabAndSaveInput {
    param(
        $Year,
        $Day
    )

    $fileName = GetDayPath -Day $Day -FileName "input.txt"

    if (Test-Path $fileName) {
        if (-not [string]::IsNullOrEmpty((Get-Content $fileName))) {
            Write-Host "Found puzzle input in file for day '$day', no need to grab from url."
            return
        }
    }

    $uri = "$baseUrl/$year/day/$day/input"
    try {
        $in = Invoke-RestMethod -Uri $uri -Headers @{cookie = "session=$sessionCookie"} -ErrorAction stop
        $null = Set-Content -Path $fileName -value $in -ErrorAction stop
        Write-Host "Grabbed puzzle input for day '$day' from url."
    }
    catch {
        Write-Error "Unable to grab and save puzzle input for day '$day' of '$Year'. Error message: `n$($_.Exception.Message)"
    }
}

function GetDayPath {
    param(
        $Day,
        $FileName
    )

    $path = Join-Path -Path $pwd -ChildPath "day$day"
    if ($FileName) {
        Join-Path -Path $path -ChildPath $FileName
    }
    else {
        $path
    }
}

function Setup {
    param([string] $SetupCommand)

    Write-Host "Setting up default folders and files for each puzzle."
    for ($i = 1; $i -le 25; $i++) {
        $day = "day$i"

        $folderToCreate = GetDayPath -Day $i
        $null = New-Item -Path $folderToCreate -ItemType Directory -ErrorAction SilentlyContinue

        "$day-1.$fileExtension", "$day-2.$fileExtension", "input.txt", "exampleinput.txt" | 
            ForEach-Object { 
                $filePath = GetDayPath -Day $i -FileName $_
                $null = New-Item -Path $filePath -ItemType File -ErrorAction SilentlyContinue
            }

        $puzzle1script = GetDayPath -Day $i -FileName "$day-1.$fileExtension"
        $fileContent = Get-Content $puzzle1script

        if ([string]::IsNullOrEmpty($fileContent)) {
            $null = Set-Content -Path $puzzle1script -Value ("$commentChars $baseUrl/$year/day/$i `n`n" + $fileTemplate)
        }
    }

    if ($SetupCommand  -notlike '') {
        [scriptblock]::Create($SetupCommand).Invoke()
    }
}

#endregion functions

if ($month -lt 12) {
    $year = $year -1
    $days = 1..25
    Write-Warning "Fetching puzzle input for last year: $year, days 1-25."
}
else {
    $days = 1..$day
    Write-Host "Fetching puzzle input for $year, days 1-$day."
}

$parentDirectoryName = (Split-Path $pwd -Leaf)
if ($parentDirectoryName -notmatch "^AdventOfCode$") {
    Write-Error "Parent dir must be named 'AdventOfCode'."
}

$yearFolder = Get-ChildItem -Directory -Filter $year
if (-not ($yearFolder)) {
    New-Item -ItemType Directory -Name $year
} 
Set-Location .\$year

$baseUrl = "https://adventofcode.com"

if (-not (Test-Path (GetDayPath -Day 25))) {
    Setup -SetupCommand $languages.$Language.SetupCommand
}

foreach ($d in $days) {
    TryGrabAndSaveInput -year $year -Day $d
}

code "$(GetDayPath -day $day)\day$day-1.$fileExtension"
Set-Location  "$(GetDayPath -day $day)\"
start-process -path "$baseUrl/$year/day/$day"