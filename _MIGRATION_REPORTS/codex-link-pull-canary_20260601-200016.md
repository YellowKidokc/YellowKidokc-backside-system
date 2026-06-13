# Migration Report: link-pull.station Canary

## Station
- station_id: link-pull
- station_root: X:\Backside\stations\link-pull.station
- run_id: 20260601-200016

## What Changed
- Rewired config.json from the old brain captures folders to station-local DROP_HERE, OUTPUT, ARCHIVE, OUTPUT\youtube, and OUTPUT\web.
- Rewired log_dir to X:\Backside\_LOGS.
- Patched RUN.bat label from workflow to station and removed the blocking pause.
- Patched pipeline.py to honor config.log_dir and to read config.json with utf-8-sig so BOM files do not crash the station.
- Left BIL untouched. This was station-lane work only.

## Canary
- Dropped one link file into DROP_HERE: codex_canary_links_20260601.txt.
- URL: https://example.com/
- RUN.bat returned rc=0 after the BOM-reader fix.
- Manifest reports url_count=1 and fetch.success=true.
- The source drop file was archived.

## Export Artifacts
- Desktop bundle: \\dlowenas\HPWorkstation\Desktop\link-pull-station-canary_20260601-200016
- Central manifest: X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels\link-pull_station_output_manifest.xlsx
- Desktop manifest mirror: \\dlowenas\HPWorkstation\Desktop\station-canary-excel-sheets_20260601\link-pull_station_output_manifest.xlsx

## Verification
- No stale references found in active config/RUN/pipeline for Backside\workflows, D:\brain, or the old captures folder.
- station_output_manifest.xlsx reopened through workbook verification: 4 rows, 11 columns.

## Notes
- The first canary failed correctly because of a BOM JSON decode defect. That is now repaired.
- The Python environment prints a requests dependency warning, but it did not block the canary fetch.
