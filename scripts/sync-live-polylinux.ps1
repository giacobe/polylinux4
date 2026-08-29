param(
    [string]$SourceBase = "https://polylab.ist.psu.edu/polylinux",
    [string]$Destination = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

$labs = @(
    @{ Number = 1; Markdown = "fs-navigation.md" },
    @{ Number = 2; Markdown = "robber.md" },
    @{ Number = 3; Markdown = "participant-guide.md" },
    @{ Number = 5; Markdown = "grepawksed.md" },
    @{ Number = 6; Markdown = "fs-manipulation.md" },
    @{ Number = 7; Markdown = "processes.md" },
    @{ Number = 8; Markdown = "participant-guide.md" },
    @{ Number = 10; Markdown = "logs.md" },
    @{ Number = 13; Markdown = "participant-guide.md" },
    @{ Number = 14; Markdown = "compression.md" }
)

$textAssets = @(
    @{ Url = "$SourceBase/"; Path = "index.html" },
    @{ Url = "$SourceBase/polylinux.css"; Path = "polylinux.css" },
    @{ Url = "$SourceBase/lab-template.html"; Path = "lab-template.html" },
    @{ Url = "$SourceBase/libv86.js"; Path = "libv86.js" },
    @{ Url = "$SourceBase/css/polylinux-vm.css"; Path = "css/polylinux-vm.css" },
    @{ Url = "$SourceBase/lib/libv86.js"; Path = "lib/libv86.js" },
    @{ Url = "$SourceBase/js/lab-loader.js"; Path = "js/lab-loader.js" },
    @{ Url = "$SourceBase/js/instructions.js"; Path = "js/instructions.js" },
    @{ Url = "$SourceBase/js/terminal.js"; Path = "js/terminal.js" },
    @{ Url = "$SourceBase/js/ui.js"; Path = "js/ui.js" },
    @{ Url = "$SourceBase/js/vm-init.js"; Path = "js/vm-init.js" },
    @{ Url = "https://polylab.ist.psu.edu/common.css"; Path = "common.css" }
)

$binaryAssets = @(
    @{ Url = "$SourceBase/lib/v86.wasm"; Path = "lib/v86.wasm" },
    @{ Url = "$SourceBase/bios/seabios.bin"; Path = "bios/seabios.bin" },
    @{ Url = "$SourceBase/bios/vgabios.bin"; Path = "bios/vgabios.bin" }
)

foreach ($lab in $labs) {
    $number = $lab.Number
    $markdown = $lab.Markdown
    $textAssets += @{ Url = "$SourceBase/lab$number/index.html"; Path = "lab$number/index.html" }
    $textAssets += @{ Url = "$SourceBase/lab$number/$markdown"; Path = "lab$number/$markdown" }
}

# Preserve the still-published Lab 1 compatibility alias.
$textAssets += @{ Url = "$SourceBase/lab1/lab1.html"; Path = "lab1/lab1.html" }

foreach ($asset in $textAssets) {
    if ($asset.Path -match "(?i)(\.cpio\.gz$|bzImage$)") {
        throw "Refusing to download excluded VM image: $($asset.Path)"
    }

    $target = Join-Path $Destination $asset.Path
    $parent = Split-Path -Parent $target
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    Write-Host "Downloading $($asset.Url)"
    Invoke-WebRequest -UseBasicParsing -Uri $asset.Url -OutFile $target

    # Normalize inconsequential live-server whitespace so repeated captures have
    # clean, reviewable Git diffs on Windows.
    $downloadedText = Get-Content -LiteralPath $target -Raw
    $downloadedText = $downloadedText -replace "[ `t]+(?=`r?`n)", ""
    $downloadedText = $downloadedText.TrimEnd()
    Set-Content -LiteralPath $target -Value $downloadedText -Encoding utf8NoBOM
}

foreach ($asset in $binaryAssets) {
    $target = Join-Path $Destination $asset.Path
    $parent = Split-Path -Parent $target
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    Write-Host "Downloading runtime dependency $($asset.Url)"
    Invoke-WebRequest -UseBasicParsing -Uri $asset.Url -OutFile $target
}

# Make the captured catalog self-contained inside this repository. The live page
# currently reaches one directory upward for this shared stylesheet.
$catalog = Join-Path $Destination "index.html"
$catalogText = Get-Content -LiteralPath $catalog -Raw
$catalogText = $catalogText.Replace('href="../common.css"', 'href="./common.css"')
$catalogText = $catalogText.TrimEnd()
Set-Content -LiteralPath $catalog -Value $catalogText -Encoding utf8NoBOM

$timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$manifest = @"
# Live-site snapshot

- Source: $SourceBase/
- Captured (UTC): $timestamp
- Included: catalog, shared HTML/CSS/JavaScript, v86/BIOS runtime dependencies, and every published lab launcher and Markdown instruction file.
- Explicitly excluded: all `bzImage` kernels and `*.cpio.gz` initrds.
- Not published as individual pages: catalog Labs 4, 9, 11, and 12.

The catalog's `common.css` reference is localized from `../common.css` to
`./common.css` so the repository contains all CSS required by the captured page.
VM filenames remain in each launcher as deployment placeholders and must be
uploaded manually under institutional policy.
"@
Set-Content -LiteralPath (Join-Path $Destination "LIVE-SNAPSHOT.md") -Value $manifest -Encoding utf8NoBOM

Write-Host "Snapshot completed. VM images were not downloaded."
