# Backside Station Full Audit - 2026-06-02

Scope: `X:\Backside\stations`

This is a lightweight readiness audit. It does not run heavy jobs, call models, mutate protected roots, or delete anything.

## Status Counts

- `REVIEW_STALE_REFS`: 15
- `SCAFFOLD_OR_CONTEXT`: 8
- `WRAPPER_PRESENT`: 29

## Station Table

| Station | Status | Registry | Run files | Python files | Config | Notes |
|---|---|---:|---|---:|---|---|
| `7q-classifier.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 4 | `` |  |
| `7q-engine.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 10 | `` | refs: README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps |
| `ai-portal-generator.station` | `WRAPPER_PRESENT` | yes | `RUN.bat; RUN_BUILD_AI_PORTAL.bat; TROUBLESHOOT_AI_PORTAL.bat` | 1 | `config.json` |  |
| `ai-research-agents.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 4 | `` | refs: README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps |
| `apologetic-pipeline.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` | no readme |
| `axioms.station` | `REVIEW_STALE_REFS` | yes | `QUEUE_IMPORTED_PAPERS_TO_INBOX.bat; RUN.bat; RUN_AXIOMS_WORKFLOW.bat; RUN_AXIOM_RIGOR_GATE.bat; RUN_FULL_PAPER_INTELLIGENCE.bat; TROUBLESHOOT_AXIOMS_WORKFLOW.bat; UPDATE_AXIOMS_REFERENCE_HTML.bat` | 11 | `` | refs: RUN_FULL_PAPER_INTELLIGENCE.bat -> X:\Backside\workflows |
| `brain-map.station` | `REVIEW_STALE_REFS` | yes | `` | 58 | `` | refs: theophysics-brain-map-main\ARCHITECTURE.md -> D:\brain / theophysics-brain-map-main\BRAIN_README.md -> X:\Backside\workflows / theophysics-brain-map-main\FOLDER_CONVENTIONS.md -> D:\brain / theophysics-brain-map-main\README.md -> X:\brain / theophysics-brain-map-main\ROOT_REORG_TARGET_2026-05-20.md -> X:\Backside\workflows / theophysics-brain-map-main\00_WORKFLOWS\D_DRIVE_PROGRAMS_AND_WORK_AREAS_MAP.md -> D:\brain / theophysics-brain-map-main\00_WORKFLOWS\WORKFLOWS_ROOT_MIGRATION_STATUS.md -> X:\brain / theophysics-brain-map-main\00_WORKFLOWS\prompts\x-drive-reorg\4b_root_simplification.md -> X:\brain no readme |
| `claim-extractor.station` | `REVIEW_STALE_REFS` | yes | `EXTRACT.bat; RUN.bat` | 3 | `config.json` | refs: COWORK_PROMPT.md -> D:\brain no readme |
| `classify-documents.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `config.json` | no readme |
| `deberta-runner.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 1 | `config.json` | no readme |
| `file-intelligence.station` | `REVIEW_STALE_REFS` | yes | `INSTALL.bat; RUN.bat` | 34 | `` | refs: README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps |
| `fruits-spirit-canon.station` | `WRAPPER_PRESENT` | yes | `RUN.bat; RUN_FRUITS_ENGINE.bat` | 3 | `` |  |
| `graph-linker.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `harvest-links.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `config.json` | no readme |
| `hdbscan-cluster.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 1 | `config.json` | no readme |
| `html-article.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 9 | `` | refs: 05_CLAIMS\README.md -> D:\brain / 05_CLAIMS\run_prompt.md -> D:\brain / 08_SECTION_VECTORS\README.md -> X:\Backside\workflows / 09_GRAPH_LINKS\README.md -> X:\Backside\workflows / configs\WORKER_ASSIGNMENTS.md -> X:\Backside\workflows / prompts\COWORK_REVIEW_PROMPT.md -> X:\Backside\workflows / prompts\QUICK_FIX_PASS.md -> X:\Backside\workflows / prompts\WORKER_DISPATCH.md -> X:\Backside\workflows no readme |
| `image-processor.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 2 | `config.json` | no readme |
| `link-pull.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; PASTE_AND_RUN.bat; RUN.bat; TROUBLESHOOT.bat; UPDATE.bat` | 1 | `config.json` | no readme |
| `link-research.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat; run_engine.bat` | 16 | `pyproject.toml` | refs: README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps |
| `lossless_context_pipeline` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 14 | `` |  |
| `master-equation-canon.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` |  |
| `math-layer.station` | `WRAPPER_PRESENT` | yes | `RUN_MATH_TTS_WORKFLOW.bat` | 19 | `package.json` |  |
| `math-translation-layer.station` | `WRAPPER_PRESENT` | yes | `RUN.bat; RUN_FIRST_LAYER_SWEEP.bat; RUN_MATH_TTS_WORKFLOW.bat` | 30 | `package.json` |  |
| `mda-publication.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 3 | `config.json` |  |
| `metadata-extractor.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `obsidian-export.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 2 | `` |  |
| `ollama` | `WRAPPER_PRESENT` | no | `BATCH_REPROCESS_ALL.bat; RUN_OLLAMA_HANDOFF.bat` | 1 | `` | no readme |
| `open-brain-map.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` | no readme |
| `operators-canon.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` |  |
| `paper-grader-nlp.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 3 | `` | refs: README.md -> X:\brain / README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps / paper-proof-grader\README.md -> D:\brain |
| `paper-intelligence-suite.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; LAUNCH.bat; RUN.bat; RUN_7Q_GTQ.bat; RUN_LOCAL_PAPER_INTELLIGENCE.bat` | 80 | `pyproject.toml` |  |
| `paper-proof-grader.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat; RUN_AXIOM_7Q_OPENAI_SAMPLE.bat; RUN_DOCKER_GTQ_ALL25.bat; RUN_FRUITS_OF_SPIRIT.bat; RUN_NOW_NO_PAUSE.bat` | 7 | `config.json` | refs: README.md -> D:\brain / _MIGRATION_NOTES\REMOTE_STUB_README_20260601-180457.md -> \\dlowenas\brain\Backside\apps |
| `paper-recommender.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `paperqa2.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 59 | `pyproject.toml` |  |
| `postgres-sync.station` | `REVIEW_STALE_REFS` | yes | `CONNECT.bat; EXPORT.bat; IMPORT.bat; INSTALL.bat; LOAD_YOUTUBE_JSON.bat; RUN.bat` | 1 | `config.json` | refs: db_utils.py -> D:\brain no readme |
| `preference-engine.station` | `WRAPPER_PRESENT` | yes | `RUN.bat; START_BIL.bat` | 0 | `` |  |
| `readability-rewriter.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `sbert-embedder.station` | `WRAPPER_PRESENT` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 1 | `config.json` | no readme |
| `section-splitter.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `series-flow-auditor.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` |  |
| `session-handoff-combined.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` | no readme |
| `session-handoff-drop.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `config.json` | no readme |
| `summarizer.station` | `SCAFFOLD_OR_CONTEXT` | yes | `` | 0 | `` |  |
| `theophysics-engine.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 0 | `package.json` | refs: README.REMOTE_PLACEHOLDER_20260601.md -> \\dlowenas\brain\Backside\apps |
| `transcribe-and-classify.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `config.json` | no readme |
| `Treaties` | `WRAPPER_PRESENT` | yes | `RUN.bat; RUN_PIPELINE.bat` | 69 | `pyproject.toml` |  |
| `trinity-canon.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` |  |
| `vault-rater-tsr100.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `` | no readme |
| `whisper-transcribe.station` | `REVIEW_STALE_REFS` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 1 | `config.json` | refs: TROUBLESHOOT.md -> D:\brain no readme |
| `youtube-fetch.station` | `REVIEW_STALE_REFS` | yes | `INSTALL.bat; RUN.bat; TEST.bat` | 2 | `config.json` | refs: TROUBLESHOOT.md -> D:\brain no readme |
| `youtube-qa.station` | `REVIEW_STALE_REFS` | yes | `RUN.bat` | 1 | `config.json` | refs: README.md -> X:\Backside\workflows |
| `youtube-scrape.station` | `WRAPPER_PRESENT` | yes | `RUN.bat` | 1 | `config.json` | no readme |

CSV detail: `X:\Backside\_MIGRATION_REPORTS\station_full_audit_20260602.csv`