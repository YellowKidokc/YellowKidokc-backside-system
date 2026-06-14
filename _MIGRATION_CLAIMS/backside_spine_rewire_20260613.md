# Backside Spine Rewire — 2026-06-13

## Canonical roots

- Stations: `X:\Backside\_Stations`
- Workflows: `X:\Backside\workflows`
- Knowledge graphs: `X:\Backside\knowledge-graphs`
- Shared assets: `X:\Backside\_Shared`

## Runtime exclusions

Do not treat the following as source chunks during migration: dependency installs, package caches, generated exports, logs, virtual environments, `node_modules`, model binaries/weights/checkpoints, runtime queues, runtime state, temporary scratch folders, and database dumps.

## Station doctrine preserved

The pipeline boot order is lossless extraction, vectorization, then classification/framework classification. This keeps vector evidence ahead of semantic routing.

## Missing chunks / deferred inventory

- Private model binaries and local Ollama/Hugging Face folders are excluded and need operator-side mount documentation.
- Historical imported docs and dashboard mockups still contain legacy `D:\FAP`, `D:\BIL`, or NAS examples as provenance text.
- Generated graph JSON under workflow outputs should be regenerated into `X:\Backside\knowledge-graphs` instead of bulk-migrated when possible.
- Runtime reports, sync logs, queues, and health outputs now target workflow runtime folders but should not be committed after generation.
