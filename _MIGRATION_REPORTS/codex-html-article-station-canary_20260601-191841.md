# HTML Article Station Canary Report

Date: 2026-06-01
Station: `X:\Backside\stations\html-article.station`

## Verdict

`YELLOW`: the station is not a complete end-to-end article publisher yet, but it now has a safe station-level `RUN.bat` and the front/middle calibration lanes run locally.

## Changed

- Added `RUN.bat` for safe calibration execution.
- Updated `X:\Backside\stations\STATION_REGISTRY.json` so `stations.html-article.has_run_bat = true`.
- Patched `07_MATH_TRANSLATION\run.py` so unavailable/offline Desktop preview reports are skipped instead of crashing with WinError 4350.

## RUN.bat Scope

The wrapper runs these safe lanes against `00_DROP\CALIBRATION_pilot-preflight-checklist.md`:

- `02_SECTION_MAP`
- `03_YAML_METADATA`
- `07_MATH_TRANSLATION`
- `08_SECTION_VECTORS` with deterministic fallback vectors

It does not pretend to run missing/incomplete lanes such as lane 04 tags or full final page assembly.

## Verified Canary

Run output:

`X:\Backside\stations\html-article.station\_CANARY_RUNS\run_20260601_191841`

Desktop bundles:

- `\\dlowenas\HPWorkstation\Desktop\html-article-station-canary_20260601-191841`
- `C:\Users\lowes\Desktop\html-article-station-canary_20260601-191841`

Verification:

- Wrapper returned rc=0.
- Lane 02 produced 4 sections plus section packets.
- Lane 03 produced address `AVIATION/PILOT_PRE_FLIGHT_CHECKLIST/F/TEAM/I/R4`.
- Lane 07 produced math payload/snippets/translation with `math_status=passed-empty`.
- Lane 08 produced `section-vectors.jsonl` and `vector-metadata.json`.
- Desktop bundle contains 23 files/folders.
- Registry JSON parses.

## Remaining Gaps

- Lane 04 has no runnable `run.py` in this station.
- Full final page assembly is still not wired as a one-button run.
- Lane 08 used hash fallback vectors, not live embedding service.
- Lane 10 writes to its own sample output path and is not included in the safe station wrapper.
