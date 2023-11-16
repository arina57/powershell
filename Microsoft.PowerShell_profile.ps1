winget install JanDeDobbeleer.OhMyPosh -s winget
#oh-my-posh init pwsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/powerlevel10k_rainbow.omp.json' | Invoke-Expression

oh-my-posh init pwsh --config "powerlevel10k_rainbow.omp.json" | Invoke-Expression
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
$PSReadLineOptions = @{
    EditMode = "Vi"
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        "Command" = "#8181f7"
    }
    PredictionSource = "HistoryAndPlugin"
    PredictionViewStyle = "List"
    ViModeIndicator = "Script"
    ViModeChangeHandler  = $Function:OnViModeChange
}

function IsAdmin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Import-Module -Name Terminal-Icons


function vim ($File){
    $File = $File -replace “\\”, “/” -replace “ “, “\ “
    bash -c “vim $File”
    }

Set-Alias vim "C:\Program Files\Neovim\bin\nvim.exe"


if(IsAdmin) {
    Write-Host "Running with " -NoNewLine -ForegroundColor blue
    Write-Host " ELEVATED " -ForegroundColor DarkRed -BackgroundColor white -NoNewline
    Write-Host " privileges" -ForegroundColor blue
} else {
    Write-Host "Running with Standard privileges" -ForegroundColor blue
}