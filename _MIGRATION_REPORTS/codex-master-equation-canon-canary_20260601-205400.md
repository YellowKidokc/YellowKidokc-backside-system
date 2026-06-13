# Migration Report: master-equation-canon.station Canary

## Station
- station_id: master-equation-canon
- station_root: X:\Backside\stations\master-equation-canon.station
- run_id: 20260601-205400

## Canary Command
`RUN.bat --out X:\Backside\_STATION_EXPORTS\20260601_station_canary_tmp\master-equation-canon`

## Result
- RUN.bat returned rc=0.
- Produced canon-index.json and canon-index.md.
- Tagged blocks: 50.
- Equations: 24.
- Source files found: 1.
- Skipped sources: 3.

## Export Artifacts
- Desktop bundle: \\dlowenas\HPWorkstation\Desktop\master-equation-canon-station-canary_20260601-205400
- Central manifest: X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels\master-equation-canon_station_output_manifest.xlsx
- Desktop manifest mirror: \\dlowenas\HPWorkstation\Desktop\station-canary-excel-sheets_20260601\master-equation-canon_station_output_manifest.xlsx

## Verification
- Output JSON parses.
- station_output_manifest.xlsx reopened through workbook verification: 2 rows, 11 columns.
- No stale references found in active RUN/station files for D:\brain, Backside\workflows, or WORKFLOW labels.

## Notes
- This is a valid deterministic canary, but not a completeness lock because three configured canon source paths were unavailable/missing in this run.
