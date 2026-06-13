# AI3 Station Canary Triage - 2026-06-01

Scope: station lane only. BIL not touched. Station folders not moved. Heavy stations not run.

Inputs inspected:
- `X:\Backside\stations\STATION_REGISTRY.json`
- `X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels`
- Station root wrappers, README/config/station manifests, and shallow entrypoint files

## Executive Result

Registry is readable and currently lists 52 stations.

Already canaried/exported stations with current 20260601 Excel manifests:

- `paper-proof-grader`
- `html-article`
- `classify-documents`
- `series-flow-auditor`
- `session-handoff-drop`
- `youtube-qa`
- `link-pull`
- `claim-extractor`

Main break point: presence of a station folder is not enough. Some entries with `has_run_bat=true` are heavy runtime wrappers, and some entries with `has_run_bat=false` are prompt/spec folders only. Canary safety should be based on dependency boundary, not registry flag alone.

## Classification Table

| Station | Class | Evidence / entrypoint | Canary plan or blocker |
|---|---|---|---|
| `7q-classifier` | HEAVY_CANARY | `RUN.bat`, `seven_q_runner_refined.py`, OpenAI wrapper in `seven_q_core.py` | Needs `OPENAI_API_KEY`. Safest mode: add/take a non-OpenAI dry parse mode before running, or use one tiny claim with a throwaway output folder and explicit API budget. |
| `7q-engine` | EASY_CANARY | `RUN.bat -> python main.py`; README has `python main.py test`; LLM mode is separate | Run `RUN.bat test` from station root. Output: test note/report files only; do not run `llm-full`. |
| `ai-portal-generator` | HEAVY_CANARY | `RUN.bat -> RUN_BUILD_AI_PORTAL.bat`; config points to many NAS/OneDrive/proof-explorer roots | Safe mode: run only after source path existence check and with output redirected to a temporary portal folder. Current canary risk is broad file traversal. |
| `ai-research-agents` | HEAVY_CANARY | `RUN.bat check|gpt|local`; scripts require `TAVILY_API_KEY`, `OPENAI_API_KEY`, optional Ollama/LM Studio | Safest test mode is `RUN.bat check` only. Do not start `gpt` or `local` until API/model readiness is confirmed. |
| `apologetic-pipeline` | HEAVY_CANARY | `RUN.bat -> apologetics_pipeline.py`; YouTube/Whisper paths and CLI modes | Safest mode: `RUN.bat --help` only, then a tiny local transcript fixture mode if added. Do not run URL or Whisper modes in this pass. |
| `axioms` | HEAVY_CANARY | Multiple workflow wrappers; Python path hard-coded; routes to axiom workflow outputs | Safe mode: run a read-only script/config validation if available. Do not run full paper intelligence or queue/import wrappers until output target is isolated. |
| `brain-map` | DRAFT_NOT_RUNNABLE | Large embedded repo tree, no station-level `RUN.bat`, registry says no run bat | Missing station wrapper and bounded station contract. Needs a thin `RUN.bat` or station script that exposes exactly one safe command. |
| `deberta-runner` | HEAVY_CANARY | `RUN.bat -> deberta_runner.py`; config uses Postgres and DeBERTa model | Needs transformer model/cache and Postgres/file-source readiness. Safest mode: create/use file-source fixture with one text row, no Postgres writes. |
| `file-intelligence` | HEAVY_CANARY | `RUN.bat watch|init-db|seed|backfill`; README says Postgres + Whisper/KeyBERT/spaCy | Safest mode: do not `watch`, `init-db`, or rename. Use a temp `backfill` directory only after DB settings are isolated. |
| `fruits-spirit-canon` | EASY_CANARY | `RUN.bat -> station.py`; deterministic, no Postgres; canon source paths under Cannon | Run `RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\fruits-spirit-canon`. Verify `canon-index.json` and `.md`. |
| `graph-linker` | DRAFT_NOT_RUNNABLE | README/station.json only; no executable wrapper | Missing implementation wrapper. Depends conceptually on SBERT output and optional Postgres graph state. |
| `harvest-links` | HEAVY_CANARY | `RUN.bat -> pipeline.py`; config says URL fetch, SBERT, DeBERTa, HDBSCAN, Postgres | Needs external web fetch, Infinity/Qdrant, models, and Postgres. Safest mode: one local HTML/CSV fixture with network off if code supports it. |
| `hdbscan-cluster` | HEAVY_CANARY | `RUN.bat -> cluster_runner.py`; default source is Postgres embeddings | Safest mode: files-source `embeddings.npz` with 3-5 fake/minimal vectors and temp output. Do not run default Postgres mode. |
| `hybrid-7q-rigor` | EASY_CANARY | Remote path `\\dlowenas\HPWorkstation\Desktop\7q_rigor_engine\7q_rigor_engine`; supports `--llm-mode off` | Run deterministic fixture: `python hybrid_7q_rigor_runner.py --source <tiny_axiom_fixture> --output <tmp> --llm-mode off`. |
| `image-processor` | HEAVY_CANARY | `RUN.bat -> image_classifier.py`; config enables OCR and CLIP model | Needs OCR/CLIP dependencies and possible model download. Safest mode: one tiny PNG in temp input with OCR-only/classify-off if code supports it. |
| `link-research` | EASY_CANARY | `RUN.bat -> run_engine.bat`; README says first-phase modular link ingestion, later Postgres/embeddings | Safe canary: run against one local HTML file or one internal URL fixture and export workbook/JSON to temp. Confirm no crawler fan-out. |
| `lossless-context` | EASY_CANARY | Python CLI, deterministic option `--embeddings none`; README has exact run/batch commands | Run `python -m lossless_context_pipeline.cli run --input samples\sample_article.md --out <tmp> --vault-id canary --embeddings none` from parent/module context. |
| `master-equation-canon` | EASY_CANARY | `RUN.bat -> station.py`; deterministic, no Postgres | Run `RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\master-equation-canon`. Verify index files and skipped sources. |
| `math-layer` | DRAFT_NOT_RUNNABLE | Real TypeScript/Python project, but registry has no station `RUN.bat`; duplicate of math translation lane | Missing station-level wrapper or registry should point to `math-translation-layer`. Can run project tests, but not a clean station canary as registered. |
| `math-translation-layer` | EASY_CANARY | `RUN.bat -> RUN_MATH_TTS_WORKFLOW.bat`; package has `npm test`, prior handoff says 22 tests passed | Safe canary: `npm test` or translate one inline chi equation to temp output. Avoid OpenAI/TTS path unless explicitly enabled. |
| `mda-publication` | HEAVY_CANARY | `RUN.bat -> RUN.ps1`; consumes upstream station outputs and routes publication artifacts | Safest mode: `scripts\check_scanner.py` or `scripts\test_gen.py` only. Do not route outputs until upstream fragments are present. |
| `metadata-extractor` | DRAFT_NOT_RUNNABLE | README/station.json only; status draft/skeleton | Missing implementation wrapper/script. Needs deterministic metadata extractor before optional model assists. |
| `obsidian-export` | EASY_CANARY | `RUN.bat -> scripts\export_obsidian_notes.py`; manifest is explicitly test-only/narrow | Safe canary: run against current manifest only into temp/handoff target if script supports target override; otherwise inspect dry run first. Do not bulk-route. |
| `open-brain-map` | DRAFT_NOT_RUNNABLE | Only README found under embedded repo | Missing station wrapper and station contract. |
| `operators-canon` | EASY_CANARY | `RUN.bat -> station.py`; deterministic, no Postgres | Run `RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\operators-canon`. Verify index files. |
| `paper-grader-nlp` | EASY_CANARY | `RUN.bat schema|module|docker`; schema validation is deterministic | Run `RUN.bat schema`. Output: JSON parse pass/fail only. Do not run Docker or module until deterministic MVP is confirmed. |
| `paper-intelligence-suite` | HEAVY_CANARY | `RUN.bat -> RUN_LOCAL_PAPER_INTELLIGENCE.bat`; requirements include OpenAI, embeddings, NLP, Semantic Scholar | Safest mode: one local sample paper with OpenAI disabled if supported. Otherwise wait for API/model readiness. |
| `paper-recommender` | DRAFT_NOT_RUNNABLE | README/station.json only; status skeleton/draft | Missing implementation. Future dependencies: Semantic Scholar API, optional embedder. |
| `paperqa2` | HEAVY_CANARY | `RUN.bat` calls `pqa` if installed; otherwise exits not installed | Needs PaperQA2 CLI/env/model setup. Safest mode: verify `pqa --help` only after install; no document QA run yet. |
| `postgres-sync` | HEAVY_CANARY | `RUN.bat connect|export|import|load-youtube`; config points to `192.168.1.177:2665` | Safest mode: `connect` with read-only `SELECT COUNT(*)` only after `BRAIN_PG_PASSWORD` is set. Do not import/load. |
| `preference-engine` | DRAFT_NOT_RUNNABLE | `RUN.bat` intentionally exits code 2; README says scaffold only | Needs logger/API/runtime implementation before any canary. |
| `readability-rewriter` | DRAFT_NOT_RUNNABLE | README/station.json only; status skeleton | Missing implementation. Future dependency: Ollama/external LLM plus semantic similarity check. |
| `sbert-embedder` | HEAVY_CANARY | `RUN.bat -> sbert_runner.py`; Infinity and Qdrant URLs, Postgres default | Safest mode: file-source temp folder with one `.txt` and temp output if supported. Do not run default Postgres/Qdrant mode. |
| `section-splitter` | DRAFT_NOT_RUNNABLE | README/station.json only; status draft | Missing deterministic parser wrapper/script. |
| `session-handoff-combined` | DRAFT_NOT_RUNNABLE | Only `test.txt`; no wrapper | Missing implementation and station contract. |
| `summarizer` | DRAFT_NOT_RUNNABLE | README/station.json only; status skeleton | Missing wrapper around BART/Ollama summarizer. |
| `theophysics-engine` | HEAVY_CANARY | `RUN.bat check|dev|build`; Express/Postgres app with Drizzle | Safest mode: `RUN.bat check` only. Do not `dev`, `build`, or `db:push` without `DATABASE_URL`/DB readiness. |
| `transcribe-and-classify` | HEAVY_CANARY | `RUN.bat -> pipeline.py`; Whisper + SBERT + DeBERTa | Needs media fixture and model stack. Safest mode: tiny local WAV/transcript fixture if available; otherwise wait. |
| `treaties` | HEAVY_CANARY | App/API repo; `.env`, Docker/Postgres/Ollama/OpenAI | Do not run until secrets are rotated/isolated and DB target is confirmed. Safest mode after cleanup: dependency check only. |
| `trinity-canon` | EASY_CANARY | `RUN.bat -> station.py`; deterministic; source map includes Cannon paths | Run `RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\trinity-canon`. Expect possible `skipped_sources` if Cannon source paths are missing/offline. |
| `vault-rater` | HEAVY_CANARY | `lowe_scorer.py`; config contains Cloudflare AI Gateway/OpenAI-style API settings | Do not run until secret handling is fixed. Safest future mode: one tiny text fixture, explicit API budget, redacted config loaded from env. |
| `whisper-transcribe` | HEAVY_CANARY | `RUN.bat -> whisper_runner.py`; `TEST.bat --self-test`; default model `large-v3` | Safest mode: `TEST.bat` only if tiny/self-test model path is confirmed. Avoid full `large-v3` canary. |
| `youtube-fetch` | HEAVY_CANARY | `RUN.bat -> youtube_scraper.py`; needs YouTube API key and Postgres | `TEST.bat` consumes quota. Safest mode: transcript-only fixture or API-key presence check; do not use quota in station triage. |
| `youtube-scrape` | HEAVY_CANARY | Pipeline calls YouTube, SBERT, DeBERTa, HDBSCAN, Postgres | Must wait for YouTube API, model stack, and Postgres readiness. |

## Next 5 Safest Stations To Canary

1. `master-equation-canon` - deterministic, writes only to `--out`.
2. `operators-canon` - deterministic, writes only to `--out`.
3. `fruits-spirit-canon` - deterministic, writes only to `--out`.
4. `hybrid-7q-rigor` - deterministic with `--llm-mode off`; use a tiny axiom fixture.
5. `7q-engine` - run `test` mode only; do not invoke LLM mode.

Backup candidate: `paper-grader-nlp` with `RUN.bat schema`, because it only validates `snapshot_schema.json`.

## Must Wait For Model/API/Postgres Readiness

- API / external search: `7q-classifier`, `ai-research-agents`, `paper-recommender`, `paper-intelligence-suite`, `paperqa2`, `vault-rater`
- Postgres / database: `postgres-sync`, `deberta-runner`, `hdbscan-cluster`, `sbert-embedder`, `harvest-links`, `youtube-fetch`, `youtube-scrape`, `file-intelligence`, `theophysics-engine`, `treaties`
- Model stack: `sbert-embedder`, `deberta-runner`, `hdbscan-cluster`, `image-processor`, `whisper-transcribe`, `transcribe-and-classify`, `summarizer`, `readability-rewriter`
- Whisper / media: `whisper-transcribe`, `transcribe-and-classify`, `apologetic-pipeline`, `file-intelligence`
- YouTube / quota: `youtube-fetch`, `youtube-scrape`, `apologetic-pipeline`

## Needs Implementation Before Canary

- `graph-linker`
- `brain-map`
- `open-brain-map`
- `math-layer` as registered, unless registry is intentionally replaced by `math-translation-layer`
- `metadata-extractor`
- `paper-recommender`
- `readability-rewriter`
- `section-splitter`
- `summarizer`
- `session-handoff-combined`
- `preference-engine`

## Stale Path / Safety Patterns Found

- Several wrappers hard-code `C:\Users\lowes\AppData\Local\Programs\Python\Python312\python.exe` or Python 3.13/3.12 fallbacks. This is workable locally but brittle for portable station execution.
- Several configs still point logs/cache to `D:\brain\_LOGS` and `D:\brain\_MODELS\hub`, while the active station root is `X:\Backside\stations`.
- `sbert-embedder` and related workflows point to `192.168.1.177` services (`Infinity`, `Qdrant`, Postgres). These should be checked as readiness gates, not assumed live.
- `file-intelligence` install text references Postgres at `192.168.1.97`, while other station configs use `192.168.1.177`. That is a real stale-host risk.
- `lossless-context` README still references `D:\GitHub\theophysics-brain-map` and `Backside/...` module paths; registry currently points to `X:\Backside\stations\lossless_context_pipeline`.
- `ai-research-agents` README command examples still reference `D:\AI-RESEARCH-AGENTS`, while station root is now `X:\Backside\stations\ai-research-agents.station`.
- `ai-portal-generator` config references `C:\Users\lowes\OneDrive\Desktop\genesis-to-quantum`, `O:\_Theophysics_v5\00_Canonical`, and multiple `\\dlowenas\brain` proof-explorer paths. Treat these as existence gates before any write.
- `mda-publication` still has one PowerShell fallback to Python 3.12 under `C:\Users\lowes\AppData...`; acceptable locally but should become env-driven.
- `Treaties` and `vault-rater` contain checked-in secret-looking config values. I did not reproduce secrets here. These should be rotated or moved to environment variables before canary execution.

## Recommended Canary Order

Use one temp output root:

`X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp`

Run in this order:

1. Canon deterministic stations: `master-equation-canon`, `operators-canon`, `fruits-spirit-canon`, `trinity-canon`.
2. Deterministic 7Q: `hybrid-7q-rigor --llm-mode off`, then `7q-engine test`.
3. Schema-only station: `paper-grader-nlp RUN.bat schema`.
4. Only after the above: `lossless-context --embeddings none`.
5. Then choose one heavy dependency family at a time: Postgres family, model family, Whisper/media family, API/search family.

Do not mix Postgres, model-download, and API quota canaries in the same pass. That would hide the actual failure boundary.
