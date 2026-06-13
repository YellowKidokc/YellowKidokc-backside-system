# Backside Root Map

Backside is the system root. The canonical mounted spine is `X:\Backside`.

- `X:\Backside\_Stations` - canonical station brains, source repos, and station-grade modules.
- `X:\Backside\workflows` - top-level runnable workflows that should not require diving into stations.
- `X:\Backside\knowledge-graphs` - graph systems, graph outputs, and graph source projects.
- `X:\Backside\_Shared` - shared inputs used to build larger artifacts:
  - `excel/`
  - `html/`
  - `templates/`
  - `assets/`
  - `schemas/`
  - `prompts/`
  - `wiki/`
- `corpus/`, `knowledge-refinery/`, `MDA/` - active source domains/pipelines.
- `_state/`, `_LOGS/`, `_archive/`, `_MIGRATION_*`, `_STATION_EXPORTS/`, `EXPORTS/` - support, history, and staging.

Doctrine: dependency installs and runtime caches are disposable; source, station definitions, graph outputs, workflows, and shared templates are canonical. Dependency installs, caches, exports, logs, virtualenvs, `node_modules`, model binaries, and generated runtime state must not be migrated as source chunks.

Station doctrine: vectorize before classify. Classification gates should consume vector/lossless evidence rather than raw intake whenever the pipeline has both lanes available.

## Missing chunks to document before migration

The canonical spine is now wired in code, but these chunks are still references or operator-owned assets and should be inventoried before any bulk move:

- Local/private model folders and binaries referenced by operators are intentionally excluded from this repo and must be mounted or installed out-of-band.
- Runtime `_queue`, `_state`, `_LOGS`, `logs`, `EXPORTS`, and generated packet `OUTPUT` folders are excluded from source migration.
- Imported historical docs under workflow archives may still mention older `D:\FAP`, `D:\BIL`, or network-share paths as provenance, not runtime configuration.
- Dashboard/static screenshots may still display sample legacy paths until the web surface is regenerated.
