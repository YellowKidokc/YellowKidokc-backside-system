# Backside Root Map

Backside is the system root.

- `_Stations/` - canonical station brains, source repos, and station-grade modules.
- `workflows/` - top-level runnable workflows that should not require diving into stations.
- `knowledge-graphs/` - graph systems, graph outputs, and graph source projects.
- `_Shared/` - shared inputs used to build larger artifacts:
  - `excel/`
  - `html/`
  - `templates/`
  - `assets/`
  - `schemas/`
- `corpus/`, `knowledge-refinery/`, `MDA/` - active source domains/pipelines.
- `_state/`, `_LOGS/`, `_archive/`, `_MIGRATION_*`, `_STATION_EXPORTS/`, `EXPORTS/` - support, history, and staging.

Doctrine: dependency installs and runtime caches are disposable; source, station definitions, graph outputs, workflows, and shared templates are canonical.
