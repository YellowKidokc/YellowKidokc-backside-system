# Pipeline Workflows Download Reconcile - 2026-06-13

Input path:

`C:\Users\lowes\Downloads\Compressed\pipeline-workflows-main`

Finding:

- The download is double nested: `pipeline-workflows-main\pipeline-workflows-main`.
- Download payload has 395 files.
- Canonical X copy has 530 files at `X:\pipeline-workflows-main\pipeline-workflows-main`.
- X copy is a clean git repo on branch `codex/improve-model-discoverability-in-repo-tig3ws`.
- X copy includes local/codex improvements: `MANIFEST.json`, `pipeline.config.json`, git history, logs, and model-root migration metadata.
- Download has 0 files not already represented by path in X.
- 45 shared files differ; sampled diffs show X contains later fixes such as removing invalid `$schema` from `contracts\schema-map.json` and model-root migration fields in `models\MODEL_REGISTRY.json`.

Decision:

- Keep `X:\pipeline-workflows-main\pipeline-workflows-main` as canonical.
- Do not overwrite X from the downloaded snapshot.
- Archive the extracted download copy only; no delete.

