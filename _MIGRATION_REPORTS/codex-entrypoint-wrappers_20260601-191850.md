# Migration Report

AI: Codex / codex-entrypoint
Date/time: 2026-06-01 19:18 America/Chicago
Scope claimed: Backside station clear RUN.bat wrapper repair; no moves, no deletes

## Classified
- `stations\7q-classifier.station` -> `STATION` -> README declares `seven_q_runner_refined.py` as the primary runner.
- `stations\claim-extractor.station` -> `STATION` -> existing `EXTRACT.bat` is the station entrypoint.
- `stations\fruits-spirit-canon.station` -> `STATION` -> `station.py` plus `station.json` verification command define a canon index worker.
- `stations\master-equation-canon.station` -> `STATION` -> `station.py` plus `station.json` verification command define a canon index worker.
- `stations\operators-canon.station` -> `STATION` -> `station.py` plus `station.json` verification command define a canon index worker.
- `stations\postgres-sync.station` -> `STATION` -> existing connect/export/import/load/install batch files are operational subcommands.
- `stations\trinity-canon.station` -> `STATION` -> `station.py` plus `station.json` verification command define a canon index worker.
- `stations\ai-portal-generator.station` -> `STATION` -> README declares `RUN_BUILD_AI_PORTAL.bat` as the build entrypoint.
- `stations\apologetic-pipeline.station` -> `STATION` -> `apologetics_pipeline.py` declares CLI usage for YouTube/caption/Whisper processing.
- `stations\axioms.station` -> `STATION` -> README declares `RUN_AXIOMS_WORKFLOW.bat` as the full workflow button.
- `stations\obsidian-export.station` -> `STATION` -> `scripts\export_obsidian_notes.py` is the manifest-driven export runner.

## Moved
- None.

## Rewired
- Added minimal `RUN.bat` delegates for:
  - `7q-classifier`
  - `claim-extractor`
  - `fruits-spirit-canon`
  - `master-equation-canon`
  - `operators-canon`
  - `postgres-sync`
  - `trinity-canon`
  - `ai-portal-generator`
  - `apologetic-pipeline`
  - `axioms`
  - `obsidian-export`
- Updated `stations\STATION_REGISTRY.json` so those 11 entries now have `has_run_bat: true`.
- Corrected temporary registry drift back to `has_run_bat: false` for prompt-only or still-ambiguous stations:
  - `graph-linker`
  - `brain-map`
  - `open-brain-map`
  - `math-layer`
  - `metadata-extractor`
  - `paper-recommender`
- Patched `apologetic-pipeline.station\apologetics_pipeline.py` default output from old workflow path to station-local `OUTPUT`.
- Patched `obsidian-export.station\scripts\export_obsidian_notes.py` default manifest from old workflow path to station-local `routing_manifest.json`.
- Patched `obsidian-export.station\scripts\route_obsidian_notes_to_canon.py` defaults from old workflow paths to station-local staging/report paths.
- Patched `obsidian-export.station\README.md` and `prompts\obsidian_export_router_prompt.md` away from old workflow runtime paths.

## Tested
- `python -m json.tool X:\Backside\stations\STATION_REGISTRY.json` -> PASS.
- Coverage check for all 11 repaired registry entries -> PASS; each has `has_run_bat=True` and a real `RUN.bat`.
- Negative check for still-ambiguous prompt-only stations -> PASS; no false runnable claims.
- Stale runtime-path scan across patched scripts/README/prompts for `Backside\workflows\obsidian-export.workflow` and `Backside\workflows\apologetics.pipeline` -> PASS; no hits.
- `7q-classifier.station\RUN.bat` -> PASS; printed runner help.
- `apologetic-pipeline.station\RUN.bat` -> PASS after UTF-8 wrapper fix; printed CLI help and station-local default output.
- `trinity-canon.station\RUN.bat --help` -> PASS; printed canon-index CLI help.
- `postgres-sync.station\RUN.bat` -> PASS; printed subcommand usage.
- `obsidian-export.station\RUN.bat --help` -> PASS; printed exporter CLI help.

## Blocked / Review Needed
- `ai-portal-generator`, `axioms`, and `claim-extractor` wrappers were not executed because their delegates are real build/extract workflow buttons, not no-op tests. They were verified by file presence and README-declared entrypoints.
- `session-handoff-combined.station` still has only `test.txt`; leave as `has_run_bat=false` until the real runtime is found.
- `html-article.station` and several prompt-only stations still need deeper command-contract review before wrappers should be added.

## Do Not Touch Notes
- Do not move the four protected workflow folders.
- Do not move `pipelines`; it remains infrastructure/framework material.
- Do not delete old generated notes or reports containing historical source paths; those are evidence, not runtime config.
