# Migration Report

AI: Codex / codex-station
Date/time: 2026-06-01 18:52:30 -05:00
Scope claimed: Backside\stations registry and entrypoint completion pass

## Classified
- Existing workflow root -> TRUE_WORKFLOW / INFRASTRUCTURE split -> first-article.workflow, semantic-snapshot.workflow, chi-tagging.workflow, and knowledge-refinery.workflow remain workflows; pipelines remains infrastructure.
- Existing station folders under Backside\stations -> STATION -> physical station homes were already present and needed registry discoverability rather than wholesale movement.
- lossless_context_pipeline -> STATION -> kept under canonical registry id lossless-context because the path was already registered.
- vault-rater-tsr100.station -> STATION -> kept under canonical registry id vault-rater because the path was already registered.

## Moved
- None. No folders were moved in this pass.

## Rewired
- Updated \\dlowenas\brain\Backside\stations\STATION_REGISTRY.json from live station folders.
- Added missing registry entries for:
  - ai-portal-generator
  - apologetic-pipeline
  - axioms
  - classify-documents
  - harvest-links
  - html-article
  - link-pull
  - mda-publication
  - obsidian-export
  - series-flow-auditor
  - session-handoff-combined
  - session-handoff-drop
  - transcribe-and-classify
  - youtube-qa
  - youtube-scrape
- Synced has_run_bat flags from disk for local station entries.
- Removed duplicate alias entries created during the sync check: lossless_context_pipeline and vault-rater-tsr100; canonical entries lossless-context and vault-rater still cover those folders.
- No RUN.bat files were added in this pass; ambiguous entrypoints remain review items rather than forced wrappers.

## Tested
- python -m json.tool \\dlowenas\brain\Backside\stations\STATION_REGISTRY.json -> OK.
- Registry path coverage check against live Backside\stations folders -> OK; no uncovered station folder paths.
- Duplicate registry path check -> OK; no duplicate path aliases.
- Stale path scan for Backside\workflows and Backside\apps inside STATION_REGISTRY.json -> OK; no hits.
- Workflow root check -> only protected workflows plus pipelines remain.

## Blocked / Review Needed
- Several stations still have has_run_bat=false; do not force wrappers until their real command contract is known. Highest-priority review set: ai-portal-generator, apologetic-pipeline, axioms, html-article, obsidian-export, session-handoff-combined, plus canon stations with station.py but no RUN.bat.
- Registry description text still contains mojibake from an older encoding pass; it does not break JSON parsing, but it should be cleaned in a metadata-only pass.

## Do Not Touch Notes
- Do not move first-article.workflow, semantic-snapshot.workflow, chi-tagging.workflow, or knowledge-refinery.workflow.
- Do not move pipelines into stations; it is infrastructure/framework material.
- Do not move graphify wholesale.
- Do not collapse output/archive folders into station homes.
