# Migration Report: claim-extractor.station Canary

## Station
- station_id: claim-extractor
- station_root: X:\Backside\stations\claim-extractor.station
- run_id: 20260601-200253

## What Changed
- Rewired config.json output_dir from D:\brain\08_CLAIMS\_OUTPUT to station-local _OUTPUT.
- Rewired config.json log_dir from D:\brain\_LOGS to X:\Backside\_LOGS.
- Patched extract.py to read config.json with utf-8-sig so BOM files do not crash the station.
- Replaced RUN.bat with a non-interactive direct runner: RUN.bat <folder> [--recursive] [--format md|html|both].
- Left EXTRACT.bat intact for the old interactive menu.
- Left BIL untouched. This was station-lane work only.

## Canary
- Created INPUT_CANARY\codex_canary_claims_20260601.md.
- RUN.bat processed 1 markdown file.
- Extracted 3 claims.
- Classification distribution:
  - DEFINITION: 1
  - THEOREM: 1
  - EVIDENCE: 1
- Exported Excel review workbook with sheets: Summary, All Claims, By File, DEFINITION, EVIDENCE, THEOREM.

## Export Artifacts
- Desktop bundle: \\dlowenas\HPWorkstation\Desktop\claim-extractor-station-canary_20260601-200253
- Central manifest: X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels\claim-extractor_station_output_manifest.xlsx
- Desktop manifest mirror: \\dlowenas\HPWorkstation\Desktop\station-canary-excel-sheets_20260601\claim-extractor_station_output_manifest.xlsx

## Verification
- Review workbook is a valid xlsx zip package.
- station_output_manifest.xlsx reopened through workbook verification: 3 rows, 11 columns.
- No stale references found in active config/RUN/extract files for D:\brain or Backside\workflows.

## Notes
- export_excel.py still uses openpyxl directly; that is existing station behavior and was verified by the canary.
- EXTRACT.bat still contains old interactive-path references. It was intentionally left as a historical/manual menu, but it should be modernized or retired in a later cleanup pass.
