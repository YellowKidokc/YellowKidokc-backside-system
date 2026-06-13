# Top-Level Cleanup Second-Pass Handoff - 2026-06-02

Verdict from David: YELLOW-GREEN for classification, not cleanup authorization.

The first audit is accepted as a useful operating map. It does not authorize bulk cleanup, broad archive moves, or deletion.

## Safe To Leave Alone / Do Not Move

- `_models`
- `_STATION_EXPORTS`
- `EXPORTS`
- `_MIGRATION_REPORTS`
- `_MIGRATION_CLAIMS`
- `_LOGS`
- `_archive`
- `station_outputs`
- `conversion_lib`
- `_shared`
- `workflows`
- `station_lab`

## Next Cleanup Targets

- `knowledge`
- `services`
- `ollama`
- `apps`
- `brain`
- `knowledge-refinery`
- `_logs_MERGE_20260520-121539`

## Second-Pass Rule

Do second-pass cleanup only on `JUNK_REVIEW` and duplicate/merge surfaces.

Do not delete.

For each candidate, prove whether it is:

- empty
- migrated
- duplicated
- still referenced

If migrated and proven safe, move to:

```text
X:\Backside\_ARCHIVE\top_level_cleanup_20260602\
```

If uncertain, move nothing and write the decision item to:

```text
X:\Backside\_REVIEW\top_level_decisions.md
```

## Strongest Probe Point

`knowledge-refinery` and `brain` are not junk just because they overlap. They need a duplicate/merge pass.

`apps` is also not safe to archive as a whole. The audit found it is mostly migrated stubs, but `paper-proof-grader-main (1)` still contains payload and must be identified before any archive move.

## Final Call

YELLOW-GREEN: good root map. Approved for targeted second-pass review. Not approved for bulk moves/deletes yet.

## Follow-Up Approval Note

David confirmed: second-pass handoff is ready.

Constraint remains: targeted review only, no bulk moves/deletes. `knowledge-refinery`, `brain`, and `apps` require proof of migrated, duplicate, or still-live status before any archive action.

Mentioned path for context:

```text
X:\Backside\stations\metadata-extractor.station
```

## Green Handoff Confirmation

David confirmed: GREEN. The second-pass handoff is ready for the next partner.

Operational constraint remains unchanged:

- Targeted review only.
- No bulk moves/deletes.
- `knowledge-refinery`, `brain`, and `apps` require proof before archive action.

Additional station paths mentioned for context only:

```text
X:\Backside\stations\7q-classifier.station
X:\Backside\stations\7q-engine.station
```

## Additional Green Confirmation

David confirmed again: GREEN. The second-pass handoff remains valid.

`7q-classifier.station` and `7q-engine.station` remain logged as context only.

Operational constraint remains unchanged:

- Targeted review only.
- No bulk moves/deletes.
- Proof required before archiving `knowledge-refinery`, `brain`, or `apps`.

Additional station path mentioned for context only:

```text
X:\Backside\stations\summarizer.station
```

## Additional Context-Only Station Paths

David confirmed: GREEN handoff remains valid. `summarizer.station` is context only.

Operational constraint remains unchanged:

- Targeted review only.
- No bulk moves/deletes.
- Proof required before archiving `knowledge-refinery`, `brain`, or `apps`.

Additional station paths mentioned for context only:

```text
X:\Backside\stations\readability-rewriter.station
X:\Backside\stations\sbert-embedder.station
X:\Backside\stations\section-splitter.station
```

## Additional Context-Only Station Paths - Batch 2

David confirmed: GREEN handoff remains valid.

Operational constraint remains unchanged:

- Targeted review only.
- No bulk moves/deletes.
- Proof required before archiving `knowledge-refinery`, `brain`, or `apps`.

Additional station paths mentioned for context only:

```text
X:\Backside\stations\open-brain-map.station
X:\Backside\stations\operators-canon.station
X:\Backside\stations\overview_generator
```

## Additional Context-Only Station Path - Batch 3

David confirmed: GREEN handoff remains valid.

Operational constraint remains unchanged:

- Targeted review only.
- No bulk moves/deletes.
- Proof required before archiving `knowledge-refinery`, `brain`, or `apps`.

Additional station path mentioned for context only:

```text
X:\Backside\stations\paper-intelligence-suite.station
```

## Additional Context-Only Station Path - Batch 4

Additional station path mentioned for context only:

```text
X:\Backside\stations\lossless_context_pipeline
```
