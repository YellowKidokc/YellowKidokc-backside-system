# Migration Report: youtube-qa.station Canary

## Station
- station_id: youtube-qa
- station_root: X:\Backside\stations\youtube-qa.station
- run_id: 20260601-200000

## What Changed
- Patched RUN.bat so it reads workflow_root from config.json and passes it to scripts\extract_youtube_qa.py.
- Patched scripts\extract_youtube_qa.py so its default root is the station folder, not X:\Backside\workflows\youtube-qa.workflow.
- Left BIL untouched. This was station-lane work only.

## Verification
- RUN.bat returned rc=0.
- Canary processed 1 transcript.
- Output paths are station-local:
  - 02_QA_JSON\sample-apologetics-dialogue.qa.json
  - 03_QA_MARKDOWN\sample-apologetics-dialogue.qa.md
  - 04_QA_EXCEL\sample-apologetics-dialogue.qa.csv
  - 04_QA_EXCEL\sample-apologetics-dialogue.qa.xlsx
  - 05_SNAPSHOTS\sample-apologetics-dialogue.paper-snapshot.partial.json
- Search found no remaining references to Backside\workflows or youtube-qa.workflow in RUN.bat, config.json, or scripts\extract_youtube_qa.py.
- station_output_manifest.xlsx was created and reopened through the workbook verifier: 5 rows, 11 columns.

## Export Artifacts
- Desktop bundle: \\dlowenas\HPWorkstation\Desktop\youtube-qa-station-canary_20260601-200000
- Central manifest: X:\Backside\_STATION_EXPORTS\20260601_station_canary_excels\youtube-qa_station_output_manifest.xlsx
- Desktop manifest mirror: \\dlowenas\HPWorkstation\Desktop\station-canary-excel-sheets_20260601\youtube-qa_station_output_manifest.xlsx

## Notes
- This station is now safe for station-local canary runs.
- The old workflow-root outputs from the first failed-green run were not deleted in this pass; they should be handled by a later cleanup lane.
