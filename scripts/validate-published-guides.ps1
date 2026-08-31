$ErrorActionPreference = 'Stop'
$site = Split-Path -Parent $PSScriptRoot

$labs = @(
    @{Lab=1; MinimumWords=1177; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZURTZYTjZNT0pLTlNDNk81QjFOTTlUOU5EUC4u'},
    @{Lab=2; MinimumWords=1030; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMEk0STYyNzhCMVpEODdMV1E2SDBSSUFHNi4u'},
    @{Lab=3; MinimumWords=572; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMTFBMlVUREtCRFJDWjlWVjdLU1gwMzM3US4u'},
    @{Lab=5; MinimumWords=1787; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUQ0laWERDT1laOEtLSzlOWFZXS1pBMVNJTS4u'},
    @{Lab=6; MinimumWords=1694; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUREw5RUJVWlJCS1VZWTBQWFNMTUVTVUdNVS4u'},
    @{Lab=7; MinimumWords=189; Form=''},
    @{Lab=8; MinimumWords=545; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMlRIVVRVWjlFODVVQ01PWEE3R0dEREpPQS4u'},
    @{Lab=10; MinimumWords=1530; Form='https://forms.microsoft.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUREk0MVJBRlRRTjhBRDRQVzVTRkZETjJOSi4u'},
    @{Lab=13; MinimumWords=578; Form='https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUNjFDODBYU0dMODNIRVBIQU1XR1A1VDNTTC4u'},
    @{Lab=14; MinimumWords=922; Form='https://forms.microsoft.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMUE2S0tZNFhBWFNMWDE4R0VYSEQ5TVdBOS4u'}
)

$requiredHeadings = @{
    5 = @('# Command reference', '# Level guidance', '# Troubleshooting', '## Level 10: capstone pipeline')
    10 = @('## Quick Reference', '## General Investigation Workflow', '## Level 10: Build an Incident Timeline')
    14 = @('## Command reference', '## Level overview', '### Level 10: incident bundle', '## General advice')
}

foreach ($lab in $labs) {
    $guide = Join-Path (Join-Path $site "lab$($lab.Lab)") 'participant-guide.md'
    $text = Get-Content -Raw $guide
    if ($text -notmatch ('(?m)^form_url: "' + [regex]::Escape($lab.Form) + '"$')) {
        throw "Lab $($lab.Lab) form URL changed"
    }
    $words = ([regex]::Matches($text, '\S+')).Count
    if ($words -lt $lab.MinimumWords) {
        throw "Lab $($lab.Lab) guide has $words words; minimum is $($lab.MinimumWords)"
    }
    if ($requiredHeadings.ContainsKey($lab.Lab)) {
        foreach ($heading in $requiredHeadings[$lab.Lab]) {
            if (-not $text.Contains($heading)) { throw "Lab $($lab.Lab) lost heading: $heading" }
        }
    }
}

Write-Host "Published-guide validation passed for $($labs.Count) labs."
