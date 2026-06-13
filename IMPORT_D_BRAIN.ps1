# IMPORT_D_BRAIN.ps1
# Brings D:\brain pipeline components into X:\Backside
# Models go to _models, stations go to stations, workflows go to workflows
# Run: powershell -ExecutionPolicy Bypass -File "X:\Backside\IMPORT_D_BRAIN.ps1"

$backside = "X:\Backside"

Write-Host "=== IMPORTING D:\brain INTO X:\Backside ===" -ForegroundColor Cyan
Write-Host ""

function RoboCopy-Move($src, $dst) {
    if (-not (Test-Path -LiteralPath $src)) {
        Write-Host "  NOT FOUND: $src" -ForegroundColor Red
        return
    }
    if (Test-Path -LiteralPath $dst) {
        Write-Host "  SKIP (exists): $dst" -ForegroundColor Yellow
        return
    }
    $parent = Split-Path $dst -Parent
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    robocopy "$src" "$dst" /E /COPY:DAT /R:2 /W:1 /NFL /NDL /NJH /NJS /NC /NS /NP | Out-Null
    Write-Host "  COPIED: $(Split-Path $src -Leaf) -> $(Split-Path $dst -Leaf)" -ForegroundColor Green
}

# --- MODELS ---
Write-Host "STEP 1: Models -> _models\" -ForegroundColor Yellow

# D:\brain\_MODELS has sentence-transformers (MiniLM) - different from sbert_minilm
RoboCopy-Move "D:\brain\_MODELS" "$backside\_models\d_brain_huggingface_hub"

# --- STATIONS (single-function pipeline components) ---
Write-Host ""
Write-Host "STEP 2: Stations -> stations\" -ForegroundColor Yellow

RoboCopy-Move "D:\brain\03_DEBERTA"   "$backside\stations\deberta-runner.station"
RoboCopy-Move "D:\brain\08_CLAIMS"    "$backside\stations\claim-extractor.station"
RoboCopy-Move "D:\brain\01_WHISPER"   "$backside\stations\whisper-transcribe.station"
RoboCopy-Move "D:\brain\02_SBERT"     "$backside\stations\sbert-embedder.station"
RoboCopy-Move "D:\brain\04_HDBSCAN"   "$backside\stations\hdbscan-cluster.station"
RoboCopy-Move "D:\brain\05_YOUTUBE"   "$backside\stations\youtube-fetch.station"
RoboCopy-Move "D:\brain\06_IMAGES"    "$backside\stations\image-processor.station"
RoboCopy-Move "D:\brain\07_POSTGRES"  "$backside\stations\postgres-sync.station"

# --- 7Q TOOLKIT (station) ---
RoboCopy-Move "D:\brain\7q-toolkit"   "$backside\stations\7q-classifier.station"

# --- MATH LAYER (station) ---
RoboCopy-Move "D:\brain\math-layer"   "$backside\stations\math-layer.station"

# --- VAULT RATER (station) ---
RoboCopy-Move "D:\Vault-Rater-TSR100" "$backside\stations\vault-rater-tsr100.station"

# --- WORKFLOWS ---
Write-Host ""
Write-Host "STEP 3: Workflows -> workflows\" -ForegroundColor Yellow

RoboCopy-Move "D:\brain\00_WORKFLOWS\classify-documents"      "$backside\workflows\classify-documents.workflow"
RoboCopy-Move "D:\brain\00_WORKFLOWS\harvest-links"            "$backside\workflows\harvest-links.workflow"
RoboCopy-Move "D:\brain\00_WORKFLOWS\session-handoff-drop"     "$backside\workflows\session-handoff-drop.workflow"
RoboCopy-Move "D:\brain\00_WORKFLOWS\transcribe-and-classify"  "$backside\workflows\transcribe-and-classify.workflow"
RoboCopy-Move "D:\brain\00_WORKFLOWS\youtube-scrape"           "$backside\workflows\youtube-scrape.workflow"

# --- PIPELINES ---
Write-Host ""
Write-Host "STEP 4: Pipelines and tools" -ForegroundColor Yellow

RoboCopy-Move "D:\brain\pipelines"               "$backside\workflows\pipelines"
RoboCopy-Move "D:\brain\session-handoff-combined" "$backside\workflows\session-handoff-combined"
RoboCopy-Move "D:\brain\open-brain-map"           "$backside\stations\open-brain-map.station"
RoboCopy-Move "D:\brain\map"                      "$backside\stations\brain-map.station"

# --- AI RESEARCH AGENTS ---
Write-Host ""
Write-Host "STEP 5: Research agents" -ForegroundColor Yellow

RoboCopy-Move "D:\AI-RESEARCH-AGENTS"  "$backside\apps\ai-research-agents"

# --- CONFIG FILES from D:\brain root ---
Write-Host ""
Write-Host "STEP 6: Config and docs" -ForegroundColor Yellow

$configDst = "$backside\_archive\d_brain_config"
if (-not (Test-Path -LiteralPath $configDst)) {
    New-Item -ItemType Directory -Path $configDst -Force | Out-Null
}
$brainFiles = @(".env", ".env.example", ".gitignore", "ARCHITECTURE_V2.md", "BRAIN_V2_ARCHITECTURE.md", "INSTALL_ALL.bat", "README.md")
foreach ($f in $brainFiles) {
    $src = "D:\brain\$f"
    if (Test-Path -LiteralPath $src) {
        Copy-Item -LiteralPath $src -Destination "$configDst\$f" -Force
        Write-Host "  COPIED: $f" -ForegroundColor Green
    }
}

# --- REPORT ---
Write-Host ""
Write-Host "=== IMPORT COMPLETE ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "New stations:" -ForegroundColor White
Get-ChildItem -LiteralPath "$backside\stations" -Directory | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Green }
Write-Host ""
Write-Host "New workflows:" -ForegroundColor White
Get-ChildItem -LiteralPath "$backside\workflows" -Directory | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor Green }
Write-Host ""
Write-Host "NOTE: This script COPIES, not moves. D:\brain is untouched." -ForegroundColor Yellow
Write-Host "Delete D:\brain manually once you've verified everything works from X:\Backside." -ForegroundColor Yellow
Write-Host ""
Write-Host "=== DONE ===" -ForegroundColor Cyan
