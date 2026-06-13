# Migration Report: operators-canon.station Canary

## Station
- station_id: operators-canon
- station_root: X:\Backside\stations\operators-canon.station
- run_id: 20260601-205558

## Canary Command
`RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\operators-canon`

## Result
- RUN.bat returned rc=0.
- Produced canon-index.json and canon-index.md.
- Tagged blocks: 108.
- Equations: 47.
- Source files found: 2.
- Skipped sources: 1.

## Export Artifacts
- Desktop bundle: \\dlowenas\HPWorkstation\Desktop\operators-canon-station-canary_20260601-205558
- Central manifest: X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels\operators-canon_station_output_manifest.xlsx
- Desktop manifest mirror: \\dlowenas\HPWorkstation\Desktop\station-canary-excel-sheets_20260601\operators-canon_station_output_manifest.xlsx

## Verification
- Output JSON parses.
- station_output_manifest.xlsx reopened through workbook verification: 2 rows, 11 columns.
- No stale references found in active RUN/station files for D:\brain, Backside\workflows, or WORKFLOW labels.

## Notes
- This is a valid deterministic canary, but not a completeness lock because one configured canon source path was unavailable/missing in this run.
