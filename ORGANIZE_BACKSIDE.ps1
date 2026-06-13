# ORGANIZE_BACKSIDE.ps1
# Moves stations, workflows, and backend folders from X:\ root into X:\Backside\
# Run: powershell -ExecutionPolicy Bypass -File "X:\Backside\ORGANIZE_BACKSIDE.ps1"

$root = "X:\"
$backside = "X:\Backside"

Write-Host "=== ORGANIZING X:\ INTO BACKSIDE ===" -ForegroundColor Cyan
Write-Host ""

# --- STATIONS ---
Write-Host "STEP 1: Moving stations..." -ForegroundColor Yellow
$stations = @(
    "fruits-spirit-canon.station",
    "master-equation-canon.station",
    "operators-canon.station",
    "trinity-canon.station"
)
foreach ($s in $stations) {
    $src = Join-Path $root $s
    $dst = Join-Path "$backside\stations" $s
    if (Test-Path -LiteralPath $src) {
        if (Test-Path -LiteralPath $dst) {
            Write-Host "  SKIP (exists): $s" -ForegroundColor Yellow
        } else {
            Move-Item -LiteralPath $src -Destination $dst
            Write-Host "  MOVED: $s" -ForegroundColor Green
        }
    } else {
        Write-Host "  NOT FOUND: $s" -ForegroundColor Red
    }
}

# --- WORKFLOWS ---
Write-Host ""
Write-Host "STEP 2: Moving workflows..." -ForegroundColor Yellow
$workflows = @(
    "ai-portal-generator.workflow",
    "axioms.workflow",
    "chi-tagging.workflow",
    "first-article.workflow",
    "knowledge-refinery.workflow",
    "link-pull.workflow",
    "paper-proof-grader.workflow",
    "semantic-snapshot.workflow"
)
foreach ($w in $workflows) {
    $src = Join-Path $root $w
    $dst = Join-Path "$backside\workflows" $w
    if (Test-Path -LiteralPath $src) {
        if (Test-Path -LiteralPath $dst) {
            Write-Host "  SKIP (exists): $w" -ForegroundColor Yellow
        } else {
            Move-Item -LiteralPath $src -Destination $dst
            Write-Host "  MOVED: $w" -ForegroundColor Green
        }
    } else {
        Write-Host "  NOT FOUND: $w" -ForegroundColor Red
    }
}

# --- BACKEND FOLDERS ---
Write-Host ""
Write-Host "STEP 3: Moving backend folders..." -ForegroundColor Yellow
$backend = @{
    "axioms"                  = "axioms"
    "conversion_lib"          = "conversion_lib"
    "Conversions"             = "Conversions"
    "deploy"                  = "deploy"
    "knowledge"               = "knowledge"
    "knowledge-refinery"      = "knowledge-refinery"
    "lossless_context_pipeline" = "lossless_context_pipeline"
    "ollama"                  = "ollama"
    "overview_generator"      = "overview_generator"
    "_shared"                 = "_shared"
    "_LOGS"                   = "_LOGS"
    "brain"                   = "brain"
    "Preference Engine Build" = "Preference Engine Build"
    "EXPORTS"                 = "EXPORTS"
    "github"                  = "github"
}
foreach ($key in $backend.Keys) {
    $src = Join-Path $root $key
    $dst = Join-Path $backside $backend[$key]
    if (Test-Path -LiteralPath $src) {
        if (Test-Path -LiteralPath $dst) {
            Write-Host "  SKIP (exists): $key" -ForegroundColor Yellow
        } else {
            Move-Item -LiteralPath $src -Destination $dst
            Write-Host "  MOVED: $key" -ForegroundColor Green
        }
    } else {
        Write-Host "  NOT FOUND: $key" -ForegroundColor Red
    }
}

# --- LOOSE FILES ---
Write-Host ""
Write-Host "STEP 4: Moving loose files to Backside\_archive..." -ForegroundColor Yellow
$archivePath = "$backside\_archive\root_cleanup_$(Get-Date -Format 'yyyyMMdd')"
if (-not (Test-Path -LiteralPath $archivePath)) {
    New-Item -ItemType Directory -Path $archivePath -Force | Out-Null
}
$looseFiles = @(
    "ARCHITECTURE.md",
    "Axiom Workflow.txt",
    "CODEX_HANDOFF_CLASSIFICATION_REDO_2026-05-20_212749.md",
    "NOTES_paper_psychometrics_station_registry_2026-05-20_21-48-53.md",
    "README.md",
    "README_121756.md",
    "THEOPHYSICS_PRIMER.md",
    "RUN_BRAIN_HEALTHCHECK.bat",
    "RUN_CHI_TAGGING_WORKFLOW.bat",
    "RUN_FAP_ARTICLE_PIPELINE.bat",
    "RUN_FIRST_ARTICLE_WORKFLOW.bat",
    "RUN_PUBLIC_ARTICLE_REFINERY.bat",
    "RUN_SEMANTIC_SNAPSHOT_WORKFLOW.bat",
    "files.zip",
    "ollmafiles.zip",
    "theophysics_folder_builder_v0_3.zip",
    "theophysics_integrated_builder_v0_4.zip",
    "theophysics_open_brain_map_v0_1.zip"
)
foreach ($f in $looseFiles) {
    $src = Join-Path $root $f
    if (Test-Path -LiteralPath $src) {
        Move-Item -LiteralPath $src -Destination "$archivePath\$f"
        Write-Host "  ARCHIVED: $f" -ForegroundColor Green
    }
}

# --- LEFTOVER DIRS ---
Write-Host ""
Write-Host "STEP 5: Archiving leftover dirs..." -ForegroundColor Yellow
$leftoverDirs = @(
    "theophysics_folder_builder_v0_3"
)
foreach ($d in $leftoverDirs) {
    $src = Join-Path $root $d
    if (Test-Path -LiteralPath $src) {
        Move-Item -LiteralPath $src -Destination "$archivePath\$d"
        Write-Host "  ARCHIVED: $d" -ForegroundColor Green
    }
}

# --- REPORT ---
Write-Host ""
Write-Host "=== FINAL STATE ===" -ForegroundColor Cyan
Write-Host "Root should now only have:" -ForegroundColor White
Write-Host "  David/" -ForegroundColor Green
Write-Host "  GUI/" -ForegroundColor Green
Write-Host "  Backside/" -ForegroundColor Green
Write-Host "  #recycle/ (system)" -ForegroundColor Gray
Write-Host "  desktop.ini (system)" -ForegroundColor Gray
Write-Host ""
$remaining = Get-ChildItem -LiteralPath $root -Force | Where-Object { $_.Name -notin @("David","GUI","Backside","#recycle","desktop.ini") }
if ($remaining.Count -eq 0) {
    Write-Host "ROOT IS CLEAN!" -ForegroundColor Green
} else {
    Write-Host "Still at root ($($remaining.Count) items):" -ForegroundColor Yellow
    $remaining | ForEach-Object { Write-Host "  - $($_.Name)" }
}

Write-Host ""
Write-Host "=== DONE ===" -ForegroundColor Cyan
