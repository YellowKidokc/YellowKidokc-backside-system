# Paper Proof Grader Canary Report

Date: 2026-06-01
Station: `X:\Backside\stations\paper-proof-grader.station`

## Verdict

`YELLOW/GREEN`: the station entrypoint runs, produces the expected flat output set, archives the source, and now writes usable provenance. It is ready for a bounded batch run. It is not yet the final run-folder output contract described in `OUTPUT_CONTRACT.md`.

## Changes Made

- Created/confirmed `DROP_PAPERS_HERE` as the live human input folder used by `config.json` and `RUN_NOW_NO_PAUSE.bat`.
- Patched `pipeline.py` to write source provenance:
  - `run_id`
  - `source_manifest`
  - archived source path
  - SHA-256
  - source size
  - detected format
  - grader/rubric version labels
- Patched `pipeline.py` to strip leading YAML/vault preamble before claim extraction, so metadata notes do not become fake claim candidates.

## Canary Run

Input canary copied from:

`X:\Backside\stations\paper-proof-grader.station\INPUT\GTQ_02_The_First_Quantum_State.md`

Live canary output prefix:

`X:\Backside\stations\paper-proof-grader.station\OUTPUT\codex_canary_cleanclaims_gtq02_20260601-190735`

Run manifest:

`X:\Backside\stations\paper-proof-grader.station\OUTPUT\paper-proof-grader-20260601_190743.json`

Archived source:

`X:\Backside\stations\paper-proof-grader.station\ARCHIVE\codex_canary_cleanclaims_gtq02_20260601-190735.md`

## Verified Outputs

- `.paper-grade.json`
- `.paper-grade.md`
- `.paper-grade.html`
- `.claim-audit.csv`
- `.paper-grade.xlsx`
- run manifest JSON

## Validation

- `python -m py_compile X:\Backside\stations\paper-proof-grader.station\pipeline.py` passed.
- `RUN_NOW_NO_PAUSE.bat` returned rc=0.
- JSON output loads.
- CSV output parses with 3 claim rows.
- XLSX zip integrity check returned `None`.
- HTML and Markdown outputs exist.
- Manifest source path points to the archived source and exists.
- SHA-256 length is 64.

## Remaining Gaps

- The grader still writes backward-compatible flat files, not the full `OUTPUT/runs/{run_id}/papers/{paper_id}/` contract.
- PDF/DOCX are listed in config but the live pipeline only processes text extensions.
- Existing `INPUT` folder contains historical/source material. The active run folder is `DROP_PAPERS_HERE`.
- Claim scoring is deterministic and conservative; it is a triage grader, not final theological/scientific adjudication.
