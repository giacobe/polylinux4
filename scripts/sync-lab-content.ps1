$ErrorActionPreference = 'Stop'
$site = Split-Path -Parent $PSScriptRoot
$sync = Split-Path -Parent $site
$map = @{
    1  = 'polylinux-basic'
    2  = 'polylinux-text-manipulation'
    3  = 'filesystem-navigation'
    5  = 'polylinux-grep-awk-sed'
    6  = 'polylinux-fm'
    7  = 'polylinux-processes'
    8  = 'polylinux-redirection'
    10 = 'polylinux-logs'
    13 = 'polybandit3.1'
    14 = 'polylinux-compression'
}
foreach ($number in $map.Keys) {
    $source = Join-Path (Join-Path $sync $map[$number]) 'participant-guide.md'
    $destination = Join-Path (Join-Path $site "lab$number") 'participant-guide.md'
    Copy-Item -LiteralPath $source -Destination $destination -Force
}
