# Backside Upload Gaps

Last updated: 2026-06-13

## Uploaded in this staging checkout

- Seeded Backside spine documentation and migration notes, including `BACKSIDE_ROOT_MAP.md` and `_MIGRATION_CLAIMS/`.
- Existing tracked source domains include `MDA/`, `_Shared/`, `workflows/`, root docs/scripts/html, and migration reports/claims.
- Pipeline path rewiring currently points runtime defaults at the canonical Backside spine (`X:\Backside`) while keeping generated runtime state out of source control.

## High-value chunks still requiring controlled upload

These canonical folders were requested for chunked upload, but they are not present in this Linux staging checkout at `/workspace/YellowKidokc-backside-system` and are not available under `/workspace` for staging in this run:

- `X:\Backside\_Stations`
- `X:\Backside\knowledge-graphs`
- `X:\Backside\corpus`
- `X:\Backside\knowledge-refinery`

Expected staging locations to inspect on the Windows host before the next upload pass:

- `X:\Backside\github\YellowKidokc-backside-system\_Stations`
- `X:\Backside\github\YellowKidokc-backside-system\knowledge-graphs`
- `X:\Backside\github\YellowKidokc-backside-system\corpus`
- `X:\Backside\github\YellowKidokc-backside-system\knowledge-refinery`

## Intentionally excluded from Git upload

Do not upload these unless a future PR explicitly justifies a small source artifact:

- Secrets and credentials: `.env`, `.env.*`, `*.key`, `*.pem`.
- Dependency installs and rebuildable packaging: `node_modules/`, `.pnpm-store/`, `venv/`, `.venv/`, `env/`, `target/`, `dist/`, `build/`, `coverage/`.
- Caches and generated state: `__pycache__/`, `.pytest_cache/`, `.cache/`, `cache/`, `_LOGS/`, `_state/`, runtime queues, temporary outputs, and generated exports.
- Model/cache artifacts: `models/`, `Models/`, `MODELS/`, `_Models/`, `_MODELS/`, `huggingface/`, `.huggingface/`, `ollama/`, `*.gguf`, `*.safetensors`, `*.pt`, `*.pth`, `*.onnx`, `*.bin`, `*.pkl`.
- Support/history/staging folders that should not be bulk-uploaded: `_archive/`, `EXPORTS/`, `_STATION_EXPORTS/`, `github/`, `#recycle/`, `JUNKET/`, nested `BACKSIDE/` copies.
- Known long/generated claim outputs: `03_FINAL_READY/Unsorted/`, `**/03_FINAL_READY/Unsorted/`, `*.claim-audit.csv`.

## Material that needs Git LFS or external storage

- Model weights, Ollama/Hugging Face caches, GGUF/safetensors/PT/PTH/ONNX/BIN/PKL binaries.
- Giant database dumps, large generated graph exports, or any single file over GitHub's hard limit.
- Any source-adjacent binary over 95 MB should be reviewed before staging and either split, compressed outside Git history, or moved to Git LFS/external storage.

## Path rewiring still needed after chunk upload

After `_Stations/`, `knowledge-graphs/`, `corpus/`, and `knowledge-refinery/` are present in the staging checkout, inspect and rewire hardcoded paths to:

- `X:\Backside\_Stations`
- `X:\Backside\workflows`
- `X:\Backside\knowledge-graphs`
- `X:\Backside\_Shared`
- `X:\Backside\corpus`
- `X:\Backside\knowledge-refinery`

Preserve station doctrine during rewiring: vectorize before classify, and keep station identity intact rather than flattening station folders into generic workflow code.

## Known blockers from this run

- The requested high-value source folders are absent from the available staging checkout, so no station/graph/corpus/refinery chunk could be staged safely in this environment.
- The current local branch is `work` and has no configured upstream; pushing to `YellowKidokc/YellowKidokc-backside-system` needs a remote/upstream and credentials in the host environment.
- Full pipeline tests currently include a known missing fixture/path issue: `workflows/BrainHandoff/PREFS/preferences.json` is not present at the path expected by `workflows/pipelines/tests/test_workflow_packets.py`.

## Next safe upload prompt

On the Windows staging checkout (`X:\Backside\github\YellowKidokc-backside-system`), run the chunk upload plan one folder at a time:

1. Inventory `_Stations/`, search for secrets, files over 95 MB, dependency folders, model/cache binaries, and path-length hazards.
2. Stage only station registry, station README/RUN files, manifests/configs, and small station source files.
3. Commit as `add station registry spine`.
4. Repeat with core station source chunks, knowledge graph sources, curated corpus/refinery structure, and shared substrate templates in separate commits/PRs.
