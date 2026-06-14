# Station Repair Packet — Blocked in This Checkout

Generated: 2026-06-14

## Requested root and canary report

- Requested station root: `\\dlowenas\brain`
- Requested canary report: `\\dlowenas\brain\WORKFLOWS\STATION_CANARY_RESULTS_20260613-204048.md`

## What was available here

This rollout environment only exposes the repository checkout at `/workspace/YellowKidokc-backside-system`. The live station root (`\\dlowenas\brain`), the five station folders, and `station_canary_runner.py` are not present in this checkout.

Searches run from the repository found no local copies of:

- `deberta-runner.station`
- `hdbscan-cluster.station`
- `image-processor.station`
- `sbert-embedder.station`
- `whisper-transcribe.station`
- `station_canary_runner.py`

## Canary rerun result

Attempted command from the repository root:

```bash
python station_canary_runner.py
```

Result: blocked before station execution because the runner file is absent:

```text
python: can't open file '/workspace/YellowKidokc-backside-system/station_canary_runner.py': [Errno 2] No such file or directory
```

Canary counts from this environment:

- PASS: 0
- REVIEW: 0
- FAIL: 0
- BLOCKED: 5 station repairs + canary runner unavailable

## Required station-local repairs when `\\dlowenas\brain` is available

Patch only the station-local files for each station, preserving station-relative behavior and vectorize-before-classify doctrine:

1. `deberta-runner.station`
   - Replace hardcoded `D:\brain\_MODELS` cache/model references with an environment/root fallback such as `%BACKSIDE_MODEL_ROOT%`, `%BRAIN_ROOT%\_MODELS`, then station-relative defaults.
   - Do not download model binaries into Git.

2. `hdbscan-cluster.station`
   - Add `hdbscan` to the station requirements or runner environment manifest.
   - Do not create or commit a `venv`, wheel cache, or install tree.

3. `image-processor.station`
   - Replace hardcoded `D:\brain\_LOGS` with `%BACKSIDE_LOG_ROOT%`, `%BRAIN_ROOT%\_LOGS`, or a station/root-relative log path.
   - Keep canary output in a temp/non-destructive folder.

4. `sbert-embedder.station`
   - Add a non-destructive Infinity healthcheck before embedding calls.
   - If `http://192.168.1.177:7997` is unavailable, return REVIEW/BLOCKED with a service-start requirement instead of crashing.

5. `whisper-transcribe.station`
   - Add `faster-whisper` to the station requirements or runner environment manifest.
   - Keep model caches external to Git via environment/root fallback.

## Repository-side fix made while blocked

The previous path-rewire introduced mixed POSIX/Windows separators in `fap_boot.py` on Linux because `os.path.join()` was used with `PureWindowsPath` constants. This was repaired by building default Backside runtime paths with `PureWindowsPath.joinpath()`, preserving canonical `X:\Backside\...` formatting.
