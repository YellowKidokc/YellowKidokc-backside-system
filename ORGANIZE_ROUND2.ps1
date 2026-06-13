# ORGANIZE_ROUND2.ps1
# Cleans up everything still at X:\ root
# Uses robocopy /MOVE for NAS reliability, falls back to Move-Item
# Run: powershell -ExecutionPolicy Bypass -File "X:\Backside\ORGANIZE_ROUND2.ps1"

$root = "X:\"

function SafeMove($src, $dst) {
    if (-not (Test-Path -LiteralPath $src)) {
        Write-Host "  NOT FOUND: $src" -ForegroundColor Red
        return
    }
    if (Test-Path -LiteralPath $dst) {
        Write-Host "  SKIP (exists): $dst" -ForegroundColor Yellow
        return
    }
    # Use robocopy /MOVE for directories (more reliable on NAS)
    if ((Get-Item -LiteralPath $src).PSIsContainer) {
        $parentDst = Split-Path $dst -Parent
        $leafDst = Split-Path $dst -Leaf
        # Ensure parent exists
        if (-not (Test-Path -LiteralPath $parentDst)) {
            New-Item -ItemType Directory -Path $parentDst -Force | Out-Null
        }
        robocopy "$src" "$dst" /E /MOVE /R:2 /W:1 /NFL /NDL /NJH /NJS /NC /NS /NP | Out-Null
        if (Test-Path -LiteralPath $src) {
            # robocopy sometimes leaves empty source dir
            Remove-Item -LiteralPath $src -Recurse -Force -ErrorAction SilentlyContinue
        }
        Write-Host "  MOVED: $(Split-Path $src -Leaf)" -ForegroundColor Green
    } else {
        Move-Item -LiteralPath $src -Destination $dst -Force
        Write-Host "  MOVED: $(Split-Path $src -Leaf)" -ForegroundColor Green
    }
}

Write-Host "=== ROUND 2: FINISHING ROOT CLEANUP ===" -ForegroundColor Cyan
Write-Host ""

# --- STATIONS ---
Write-Host "Stations -> Backside\stations\" -ForegroundColor Yellow
SafeMove "X:\fruits-spirit-canon.station"       "X:\Backside\stations\fruits-spirit-canon.station"
SafeMove "X:\master-equation-canon.station"      "X:\Backside\stations\master-equation-canon.station"
SafeMove "X:\operators-canon.station"            "X:\Backside\stations\operators-canon.station"
SafeMove "X:\trinity-canon.station"              "X:\Backside\stations\trinity-canon.station"

# --- WORKFLOWS ---
Write-Host ""
Write-Host "Workflows -> Backside\workflows\" -ForegroundColor Yellow
SafeMove "X:\ai-portal-generator.workflow"       "X:\Backside\workflows\ai-portal-generator.workflow"
SafeMove "X:\axioms.workflow"                    "X:\Backside\workflows\axioms.workflow"
SafeMove "X:\chi-tagging.workflow"               "X:\Backside\workflows\chi-tagging.workflow"
SafeMove "X:\first-article.workflow"             "X:\Backside\workflows\first-article.workflow"
SafeMove "X:\knowledge-refinery.workflow"        "X:\Backside\workflows\knowledge-refinery.workflow"
SafeMove "X:\link-pull.workflow"                 "X:\Backside\workflows\link-pull.workflow"
SafeMove "X:\paper-proof-grader.workflow"        "X:\Backside\workflows\paper-proof-grader.workflow"
SafeMove "X:\semantic-snapshot.workflow"          "X:\Backside\workflows\semantic-snapshot.workflow"

# --- BACKSIDE INTERNALS that ended up at root ---
Write-Host ""
Write-Host "Backside internals -> Backside\" -ForegroundColor Yellow
SafeMove "X:\control-plane"                      "X:\Backside\control-plane"
SafeMove "X:\stations"                           "X:\Backside\stations_old"
SafeMove "X:\workflows"                          "X:\Backside\workflows_old"
SafeMove "X:\station_lab"                        "X:\Backside\station_lab"
SafeMove "X:\services"                           "X:\Backside\services"
SafeMove "X:\corpus"                             "X:\Backside\corpus"
SafeMove "X:\apps"                               "X:\Backside\apps"
SafeMove "X:\_state"                             "X:\Backside\_state"
SafeMove "X:\_archive"                           "X:\Backside\_archive_root"
SafeMove "X:\_logs_MERGE_20260520-121539"        "X:\Backside\_logs_MERGE_20260520-121539"

# --- REPORT ---
Write-Host ""
Write-Host "=== FINAL STATE ===" -ForegroundColor Cyan
$remaining = Get-ChildItem -LiteralPath $root -Force | Where-Object { $_.Name -notin @("David","GUI","Backside","#recycle","desktop.ini") }
if ($remaining.Count -eq 0) {
    Write-Host "ROOT IS CLEAN!" -ForegroundColor Green
} else {
    Write-Host "Still at root ($($remaining.Count) items):" -ForegroundColor Yellow
    $remaining | ForEach-Object { Write-Host "  - $($_.Name)" }
}
Write-Host ""
Write-Host "=== DONE ===" -ForegroundColor Cyan
