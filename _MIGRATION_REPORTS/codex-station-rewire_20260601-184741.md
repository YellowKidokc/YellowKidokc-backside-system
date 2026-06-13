# Migration Report

AI: Codex / codex-station-rewire
Date/time: 2026-06-01 18:47:46 -05:00
Scope claimed: Backside apps station reconciliation set

## Classified
- 7q-main -> STATION -> app runtime payload for 7q-engine
- ai-research-agents -> STATION -> app runtime payload for ai-research-agents
- file-intelligence-system-master -> STATION -> app runtime payload for file-intelligence
- link-research-engine-main -> STATION -> app runtime payload for link-research
- Paper-Grader-NLP-API-03-Axiom-main -> STATION -> app runtime payload for paper-grader-nlp
- theophysics-engine-main -> STATION -> app runtime payload for theophysics-engine

## Moved
- apps\7q-main\7q-main\* -> stations\7q-engine.station\*
- apps\ai-research-agents\* -> stations\ai-research-agents.station\*
- apps\file-intelligence-system-master\file-intelligence-system-master\* -> stations\file-intelligence.station\*
- apps\link-research-engine-main\link-research-engine-main\* -> stations\link-research.station\*
- apps\Paper-Grader-NLP-API-03-Axiom-main\Paper-Grader-NLP-API-03-Axiom-main\* -> stations\paper-grader-nlp.station\*
- apps\theophysics-engine-main\theophysics-engine-main\* -> stations\theophysics-engine.station\*
- Each migrated app source folder now contains only MIGRATED_TO_STATION.md.

## Rewired
- registry: 7q-engine -> X:\Backside\stations\7q-engine.station, has_run_bat=True, type=local
- registry: ai-research-agents -> X:\Backside\stations\ai-research-agents.station, has_run_bat=True, type=local
- registry: file-intelligence -> X:\Backside\stations\file-intelligence.station, has_run_bat=True, type=local
- registry: link-research -> X:\Backside\stations\link-research.station, has_run_bat=True, type=local
- registry: paper-grader-nlp -> X:\Backside\stations\paper-grader-nlp.station, has_run_bat=True, type=local
- registry: theophysics-engine -> X:\Backside\stations\theophysics-engine.station, has_run_bat=True, type=local

## Tested
- python -m json.tool stations\STATION_REGISTRY.json -> OK
- RUN exists 7q-engine: True
- RUN exists ai-research-agents: True
- RUN exists file-intelligence: True
- RUN exists link-research: True
- RUN exists paper-grader-nlp: True
- RUN exists theophysics-engine: True

## Blocked / Review Needed
- None in claimed app-station reconciliation scope.

## Do Not Touch Notes
- Protected workflow folders were not moved: first-article.workflow, semantic-snapshot.workflow, chi-tagging.workflow, knowledge-refinery.workflow.
- pipelines was not moved; it remains infrastructure/framework material.
- graphify was not moved wholesale.
- apps folders now contain MIGRATED_TO_STATION.md redirect notes; do not put new runtime code there.
- paper-proof-grader-main (1) was not touched in this pass; compare/archive only remains pending.

## Post-Report Correction
- Corrected generated RUN.bat wrappers for file-intelligence, link-research, paper-grader-nlp, and theophysics-engine after entrypoint inspection. link-research now delegates to existing run_engine.bat; paper-grader-nlp now uses python -m paper_grader.


## Smoke-Test Correction
- 7q-engine.station reached CLI usage but failed under Windows cp1252 on box-drawing Unicode. RUN.bat now sets chcp 65001, PYTHONIOENCODING=utf-8, and PYTHONUTF8=1 before invoking main.py.

## Moved Payload Summary
- apps\7q-main\7q-main\* -> stations\7q-engine.station\*
- apps\ai-research-agents\* -> stations\ai-research-agents.station\*
- apps\file-intelligence-system-master\file-intelligence-system-master\* -> stations\file-intelligence.station\*
- apps\link-research-engine-main\link-research-engine-main\* -> stations\link-research.station\*
- apps\Paper-Grader-NLP-API-03-Axiom-main\Paper-Grader-NLP-API-03-Axiom-main\* -> stations\paper-grader-nlp.station\*
- apps\theophysics-engine-main\theophysics-engine-main\* -> stations\theophysics-engine.station\*
- Each source app folder now contains MIGRATED_TO_STATION.md only.

## Additional Tested Outcomes
- ai-research-agents.station: check-env.ps1 ran and reported key presence without printing secrets.
- file-intelligence.station: python import of fis succeeded.
- link-research.station: scripts\run_engine.py reached expected prompt text; dependency warning only.
- paper-grader-nlp.station: python -m paper_grader ran with station-local INPUT/OUTPUT/ARCHIVE env paths.
- theophysics-engine.station: npm is available and package.json parses.
- Registry claimed app-station entries now all point to X:\Backside\stations\*.station with type=local and has_run_bat=true.
