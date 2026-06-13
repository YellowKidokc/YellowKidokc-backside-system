# Migration Report: math-translation-layer.station Readiness

## Station
- station_id: math-translation-layer
- station_root: `X:\Backside\stations\math-translation-layer.station`
- readiness_date: 2026-06-01

## What Changed
- Installed Node dependencies from the existing package lock.
- Updated `vitest` to `^4.1.8` to remove the critical dev-dependency advisory.
- Ran `npm audit fix` to remove the remaining moderate `ws` advisory.
- Added non-interactive first-layer runner:
  - `X:\Backside\stations\math-translation-layer.station\RUN_FIRST_LAYER_SWEEP.bat`

## New First-Layer Runner
This runner avoids the menu and does math translation only, no TTS.

Single file or folder:

```bat
RUN_FIRST_LAYER_SWEEP.bat "<file-or-folder>" "<run-id>" "<out-dir>"
```

List file:

```bat
RUN_FIRST_LAYER_SWEEP.bat --list "<list-file>" "<run-id>" "<out-dir>"
```

The runner writes:
- `prepared\<run-id>\*.tts.txt`
- `markdown\<run-id>\*.md`
- `source\<run-id>\*`
- `logs\<run-id>\*.log`
- `logs\<run-id>\*.translation-events.json`
- `logs\<run-id>\summary.json`

## Verification Passed
- `npm run typecheck` passed.
- `npm run build` passed.
- `npm test` passed: 7 test files, 24 tests.
- Python helper tests passed: 9 tests.
- `npm audit --json` reports 0 vulnerabilities.
- First-layer smoke run passed against bundled sample HTML.

## Smoke Run
Command:

```bat
RUN_FIRST_LAYER_SWEEP.bat "X:\Backside\stations\math-translation-layer.station\tests\fixtures\sample-article.html" "codex-first-layer-smoke-20260601" "X:\Backside\_STATION_EXPORTS\20260601_first_layer_canary\first-layer-sweep-smoke"
```

Result:
- Success: 1
- Failed: 0
- Output root: `X:\Backside\_STATION_EXPORTS\20260601_first_layer_canary\first-layer-sweep-smoke`

## Remaining Need
David is preparing the real math/proof insertion template and one practice HTML file. Once provided, run the first-layer sweep against that practice HTML, then inspect:
- prepared TTS text
- markdown extraction
- translation events
- summary manifest
- whether the template insertion point is sufficient for article merge

## Notes
- `math-layer.station` appears to be an older duplicate/secondary copy. Treat `math-translation-layer.station` as the active station for this first-layer test.
- The Python tests emit a `requests` dependency warning from the local Python environment; it does not block the tested math extraction/rewrite helpers.
