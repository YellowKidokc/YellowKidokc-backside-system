# Codex Top-Level Folder Audit - 2026-06-02

Scope: report-only classification of selected top-level folders in `X:\Backside`.

Rules observed: no deletes, no moves, no station code edits, no heavy station jobs.

## Classifications

### knowledge
- Bucket: JUNK_REVIEW
- Confidence: HIGH
- Evidence: folder exists but has 0 child directories and 0 files.
- Keep / Consolidate / Archive / Review: Review. Empty placeholder; safe candidate for later removal only after David confirms no hidden dependency.

### services
- Bucket: JUNK_REVIEW
- Confidence: HIGH
- Evidence: folder exists but has 0 child directories and 0 files. Historical root log says `X:\ollama` was moved to `X:\Backside\services\ollama`, but current folder is empty while a separate top-level `ollama` folder exists.
- Keep / Consolidate / Archive / Review: Review. It is an empty service placeholder, not a live service.

### _MIGRATION_REPORTS
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: contains 18 dated `.md` reports including `ai2-html-production-inventory_20260601.md`, `ai3-station-canary-triage_20260601.md`, and canary/readiness reports.
- Keep / Consolidate / Archive / Review: Keep. Durable audit/report ledger.

### _STATION_EXPORTS
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: README calls it the "Canonical Backside export staging area"; contains `20260601_station_canary_excels`, `20260601_first_layer_canary`, `.xlsx`, `.json`, `.md`, `.html`, `.log` artifacts.
- Keep / Consolidate / Archive / Review: Keep. Do not blindly copy into root `EXPORTS`; this is a station-specific durable export pack.

### _LOGS
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: contains workflow logs such as `workflow_paper-proof-grader_20260601.log`, `workflow_link-pull-drop_20260601.log`, and write-test logs.
- Keep / Consolidate / Archive / Review: Keep. Active root log shelf.

### workflows
- Bucket: WORKFLOW
- Confidence: HIGH
- Evidence: `BACKSIDE_WORKFLOW_SPINE_DRAFT_2026-05-22.md` defines workflow routes; folders include `.workflow` lanes with `pipeline.py`, `RUN.bat`, `dependencies.json`, configs, run reports.
- Keep / Consolidate / Archive / Review: Keep / Consolidate. `knowledge-refinery.workflow` has 4,916 files and includes old/generated material; inspect before dedupe. 7Q/7QS material found in workflow outputs and root samples.

### _models
- Bucket: MODEL
- Confidence: HIGH
- Evidence: `MODEL_INVENTORY_20260601.md` documents `X:\Backside\_models\_Models` as the model rack with BART, SBERT/MiniLM, DeBERTa, CLIP, Whisper, Mistral, HF cache mirrors, and several DO_NOT_MOVE entries.
- Keep / Consolidate / Archive / Review: Keep. Contains weight-bearing model assets. Stale path flags already documented for `D:\brain\_MODELS\hub`, `D:\brain\03_DEBERTA`, `D:\brain\08_CLAIMS`, and `D:\brain\_LOGS`.

### _MIGRATION_CLAIMS
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: contains three concise migration claim files for station/app reconciliation and registry entrypoints.
- Keep / Consolidate / Archive / Review: Keep. Claim ledger; useful for proving what changed.

### control-plane
- Bucket: SERVICE
- Confidence: MEDIUM
- Evidence: contains `theophysics-comms-hub` quick-start docs and `brain-healthcheck.ps1`. `brain-healthcheck.ps1` writes to `EXPORTS\brain-healthcheck` and checks workflow/service routes.
- Keep / Consolidate / Archive / Review: Keep / Consolidate. Comms quick-start uses old base `https://comms.faiththruphysics.com`; live comms used this session were `https://comms.dlowehomelab.com`, so flag docs stale.

### MDA
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: structured MDA output shelves: `01_OUTBOX_REPORTS`, `02_HTML_OUTPUTS`, `03_FINAL_READY`, `04_ARCHIVE_ORIGINALS`, manifests, rigor gates, scorecards/workbooks/snapshots; extension profile includes 246 `.html`, 246 `.md`, 249 `.json`, 124 `.xlsx`, 123 `.csv`.
- Keep / Consolidate / Archive / Review: Consolidate. These are generated MDA artifacts and should be considered for copy/index into root `EXPORTS` if root `EXPORTS` is the canonical human export shelf, preserving originals.

### station_outputs
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: contains station canon outputs only: `fruits-spirit-canon`, `master-equation-canon`, `operators-canon`, `trinity-canon`, each with `canon-index.json` and `canon-index.md`.
- Keep / Consolidate / Archive / Review: Consolidate. Copy/index into `_STATION_EXPORTS` or root `EXPORTS` may be warranted; do not delete because canon station outputs are weight-bearing.

### apps
- Bucket: SERVICE
- Confidence: MEDIUM
- Evidence: six app folders contain only `MIGRATED_TO_STATION.md`, pointing to station replacements; `paper-proof-grader-main (1)` still has app/runtime files (`README.md`, `RUN.bat`, `pipeline.py`, config, Docker package).
- Keep / Consolidate / Archive / Review: Review / Archive. Most entries are migrated stubs. `paper-proof-grader-main (1)` is a live duplicate/remainder and should be compared to station/workflow versions before archive. 7Q/7QS material present in paper proof grader.

### _archive
- Bucket: ARCHIVE
- Confidence: HIGH
- Evidence: contains dated archive shelves: `models_cleanup_20260522`, `root`, `root_cleanup_20260521`; root archive includes `ROOT_REORG_LOG_2026-05-20.md` and prior conversion/deprecated material.
- Keep / Consolidate / Archive / Review: Keep. Archive is intentional; do not delete non-empty archived material.

### corpus
- Bucket: STATION
- Confidence: MEDIUM
- Evidence: corpus sources include `BIL` placeholder README and `C4C` Obsidian/smart-env content with 1,197 `.ajson`, 293 `.md`, 7 `.xlsx`, and canonical apologetics/physics files.
- Keep / Consolidate / Archive / Review: Keep / Review. It is not executable station code, but it is a working corpus/data source for stations and workflows. `BIL` is explicitly decision-pending, not junk.

### _state
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: state/cache folders for `chi-tagging`, `conversion-layer`, `digests`, `embeddings`, `ratings`, and workflow smoke states; extension profile includes 281 `.json`, 69 `.md`, `.dat`, `.csv`, `.mmap`, mapping/version files.
- Keep / Consolidate / Archive / Review: Keep / Archive old smoke runs. This is internal state, not root `EXPORTS`; do not copy wholesale into export shelf.

### ollama
- Bucket: JUNK_REVIEW
- Confidence: MEDIUM
- Evidence: current top-level folder contains only `__pycache__`. Historical root reorg says `X:\ollama` was moved to `X:\Backside\services\ollama`, but `services` is currently empty.
- Keep / Consolidate / Archive / Review: Review. Likely abandoned/cache remnant unless another hidden dependency imports from it.

### github
- Bucket: SERVICE
- Confidence: MEDIUM
- Evidence: contains repo-like folders `genesis-quantum-verification`, `pipeline-workflows`, `Treaties`; README in `genesis-quantum-verification` describes public verification package, Docker pipeline, Lean checks, dashboard; `Treaties` includes a `.venv`, which is cleanup smell.
- Keep / Consolidate / Archive / Review: Keep / Review. Repo mirror shelf, but virtualenv material should be reviewed before preserving as durable source.

### knowledge-refinery
- Bucket: WORKFLOW
- Confidence: HIGH
- Evidence: README says "conductor workflow for intake, conversion, model checking, HTML output, Obsidian export, memory, and archive"; contains `01_INTAKE`, `13_SOURCE_SYSTEMS`, `98_BACKSIDE`, `BACKSIDE`.
- Keep / Consolidate / Archive / Review: Consolidate. It overlaps conceptually with `workflows\knowledge-refinery.workflow`; compare before moving.

### brain
- Bucket: WORKFLOW
- Confidence: MEDIUM
- Evidence: contains `00_WORKFLOWS` with `paper-proof-grader` and `session-handoff-drop`; includes `pipeline.py`, `RUN.bat`, old `.git` lock files, output folders, drop folders, archives.
- Keep / Consolidate / Archive / Review: Review / Consolidate. Duplicate/legacy workflow copy likely overlaps `workflows` and station exports; lock/tmp files make it a cleanup candidate after evidence mapping.

### EXPORTS
- Bucket: EXPORTS_LOGS
- Confidence: HIGH
- Evidence: root export sink with 25 child folders; samples include 7Q hybrid results, conversion-layer outputs, proof architecture HTML, paper grader reports, first-article workflow artifacts.
- Keep / Consolidate / Archive / Review: Keep. This is the broad human-readable/generated export shelf. 7Q/7QS material is present and should stay clearly labeled.

### conversion_lib
- Bucket: SHARED_LIB
- Confidence: HIGH
- Evidence: `pyproject.toml`, `src`, `tests`, `bin`, `config`; README defines shared conversion contract: source file/URL to canonical markdown plus metadata/warnings.
- Keep / Consolidate / Archive / Review: Keep. Shared helper library; stale README example points at `X:\Conversions\conversion-layer\src`, so path docs should be checked before use.

### station_lab
- Bucket: STATION
- Confidence: HIGH
- Evidence: README calls it a safe tuning bench for individual paper-grader stations; files include `paper_grader_station_lab.py`, `accessible_layer_audit.py`, examples and prompts; outputs go to `X:\EXPORTS\paper-grader-station-lab`.
- Keep / Consolidate / Archive / Review: Keep. Station test bench, not a generic archive.

### _shared
- Bucket: SHARED_LIB
- Confidence: HIGH
- Evidence: contains `canon_index.py` and cache; prior station repair notes say station imports need `_shared.canon_index`.
- Keep / Consolidate / Archive / Review: Keep. Shared canon helper; do not remove because station imports may depend on it.

### _logs_MERGE_20260520-121539
- Bucket: ARCHIVE
- Confidence: HIGH
- Evidence: dated merge folder with 17 old workflow/session logs from May 4-12; root reorg log explicitly says `X:\_LOGS` was moved here as root logs.
- Keep / Consolidate / Archive / Review: Archive. Duplicate/older log shelf relative to active `_LOGS`; preserve unless David approves log consolidation.

## Cross-Cutting Flags

- Stale path/documentation flags:
  - `_models` inventory documents old `D:\brain\...` runtime/cache references.
  - `control-plane\theophysics-comms-hub\README_COMMS_HUB_QUICK_START.md` uses old comms base `https://comms.faiththruphysics.com`.
  - `conversion_lib\README.md` example uses `X:\Conversions\conversion-layer\src` while this library is under `X:\Backside\conversion_lib`.
  - `apps\paper-proof-grader-main (1)\paper-proof-grader-main\README.md` points to `X:\brain\00_WORKFLOWS\paper-proof-grader\...`, while this audit root is `X:\Backside`.
- 7Q/7QS flags:
  - `apps\paper-proof-grader-main (1)` has 7QS analysis and Docker/Ollama 7Q code.
  - `EXPORTS` has `7Q_HYBRID_TEST_5`, `7q_rigor_engine_v02_smoke`, and classification-redo 7Q outputs.
  - `workflows\knowledge-refinery.workflow` includes 7QS/Seven Questions HTML material.
  - root-level proof-explorer HTML files also contain 7Q UI sections, but root files were outside this folder-only audit.
- Export-copy flags:
  - `MDA` contains many Excel/CSV/JSON/HTML/MD artifacts and is a strong candidate for indexed copy into root `EXPORTS`, not destructive move.
  - `station_outputs` should be copied/indexed into `_STATION_EXPORTS` or root `EXPORTS` if David wants one export surface.
  - `_STATION_EXPORTS` should remain its own station export ledger, not be flattened blindly.
- Duplicate/merge leftovers:
  - `apps` mostly duplicates station folders via `MIGRATED_TO_STATION.md`; only `paper-proof-grader-main (1)` still has payload.
  - `brain\00_WORKFLOWS` appears to duplicate older workflow surfaces and includes lock/tmp/output files.
  - `_logs_MERGE_20260520-121539` is proven merge leftover by name and `ROOT_REORG_LOG_2026-05-20.md`.
  - `knowledge-refinery` and `workflows\knowledge-refinery.workflow` overlap by declared conductor/refinery role and need side-by-side comparison before consolidation.
