# Station Output Merge Map
**Author:** Opus | **Date:** 2026-06-01 | **Status:** MERGE MAP ONLY — nothing moved or deleted

---

## 1. Source Inventory

### Station A: paper-proof-grader
**Folder:** `paper-grader-dashboard-canary_20260601-191427`
**Manifest:** `station_output_manifest.xlsx` — 5 sheets

| Sheet | Grain | Row Count | Key Columns |
|-------|-------|-----------|-------------|
| Station_Label | 1 row per station | 1 | station, label, desktop_folder, notes |
| Paper_Control | 1 row per paper (key-value) | 19 fields | paper_id, source_file, run_id, word_count, section_count, equation_count, claim_candidate_count, sha256, grader_version |
| Claim_Detail | 1 row per claim | 3 | paper_id, section, one_sentence_claim, claim_maturity_level/label, Q1-Q7, formal_verification |
| Structure | 1 row per section | 1 | type, paper_id, name_or_equation, character_count, preview |
| Files | 1 row per output file | 7 | relative_path, size_bytes, modified_utc, extension |

### Station B: html-article
**Folder:** `html-article-station-canary_20260601-191841`
**Manifest:** `station_output_manifest.xlsx` — 6 sheets

| Sheet | Grain | Row Count | Key Columns |
|-------|-------|-----------|-------------|
| Station_Control | 1 row per station (key-value) | 7 fields | station, label, address, sections, vector_source, math_status |
| Metadata | 1 row per paper (key-value) | 35 fields | lane_id, article_slug, paper_uuid, page_id, title, source_file_name, domain, named_entity, state, audience, use, risk, address_string, section_count, equation_count, citation_count |
| Section_Map | 1 row per section | 4 | section_id, title, char_start, char_end, preview |
| Vector_Metadata | 1 row per paper (key-value) | 16 fields | section_count, vector_dim, vector_source, mocked, top_neighbors, loopback.triggered |
| Math_Payload | 1 row per paper (key-value) | 30 fields | protocol_version, semantic_address, semantic_vector (G/M/E/S/T/K/R/Q/F/C), vector_string, address_hash, equation_count, math_status, content_hash, run_id |
| Files | 1 row per output file | 17 | relative_path, size_bytes, modified_utc, extension |

### Station C: classify-documents
**Folder:** `classify-documents-station-canary_20260601-192636`
**Manifest:** `station_output_manifest.xlsx` — 4 sheets

| Sheet | Grain | Row Count | Key Columns |
|-------|-------|-----------|-------------|
| Station_Control | 1 row per station (key-value) | 9 fields | station, label, generated_at, input_dir, output_dir, file_count, embedding_engine |
| Classification_Summary | 1 row per file | 2 | path, top_label, top_score, embedding_engine, classification_engine |
| Sidecars | 1 row per sidecar file | 2 | file, top_label, top_score, embedding_engine, classification_engine |
| Files | 1 row per output file | 7 | relative_path, size_bytes, modified_utc, extension |

### Station D: SELF_CONTAINED_STATION_INDEX
**Folder:** `station-canary-excel-sheets_20260601`
**File:** `SELF_CONTAINED_STATION_INDEX.xlsx` — 1 sheet

| Sheet | Grain | Row Count | Key Columns |
|-------|-------|-----------|-------------|
| Station_Index | 1 row per station | 3 | station, label, desktop_folder, run_status, primary_excel, notes |

**Also contains:** 3 copies of the per-station manifests (see Duplicates below).

---

## 2. Proposed Master Workbook Mapping

### Sheet: PaperMaster
**Grain:** One row per paper/document
**Purpose:** Single source of truth for every paper that has passed through any station

| Source Station | Source Sheet | Fields to Promote |
|---------------|-------------|-------------------|
| paper-grader | Paper_Control | paper_id, word_count, section_count, equation_count, claim_candidate_count, top_terms |
| html-article | Metadata | paper_uuid, page_id, title, source_file_name, domain, named_entity, type, status, maturity, audience, use, risk, address_string, website_layers |
| classify-documents | Classification_Summary | top_label, top_score, embedding_engine, classification_engine |

**Join key:** paper_id (paper-grader) = paper_uuid (html-article) = filename stem (classify-documents). These need normalization — classify-documents uses bare filename (`canary-theophysics.md`), the others use compound IDs.

**Action required:** Define a canonical `paper_id` format all stations emit.

### Sheet: Paper_Control
**Grain:** One row per paper × station run
**Purpose:** Operational provenance — when each station processed each paper, with what version, what hash

| Source Station | Source Sheet | Fields to Promote |
|---------------|-------------|-------------------|
| paper-grader | Paper_Control | run_id, source_file, source_archive_path, source_sha256, source_size_bytes, detected_format, ingested_at, grader_version, rubric_version |
| html-article | Math_Payload | run_id, content_hash, protocol_version, generated_at, worker, source_path |
| html-article | Vector_Metadata | generated_at_utc, vector_source, mocked |
| classify-documents | Station_Control | generated_at, embedding_engine, engine_notes |

**Note:** Paper_Control is multi-row because the same paper may be processed by multiple stations. Compound key = `paper_id + station + run_id`.

### Sheet: Claim_Detail
**Grain:** One row per claim
**Purpose:** Every claim extracted from every paper, with maturity scoring and 7Q assessment

| Source Station | Source Sheet | Fields |
|---------------|-------------|--------|
| paper-grader | Claim_Detail | paper_id, section, one_sentence_claim, claim_maturity_level, claim_maturity_label, facts_snapshot, forward_test, reverse_test, evidence_bar, kill_conditions, not_claimed, proof_boundary, nearby_equation, Q1-Q7, formal_verification |

**No equivalent in other stations.** This sheet is paper-grader exclusive. html-article and classify-documents do not extract claims.

### Sheet: Structure
**Grain:** One row per section (or equation)
**Purpose:** Structural map of every paper — sections, equations, character positions

| Source Station | Source Sheet | Fields |
|---------------|-------------|--------|
| paper-grader | Structure | type, paper_id, name_or_equation, character_count, preview |
| html-article | Section_Map | section_id, title, char_start, char_end, preview |

**Overlap:** Both stations produce section-level rows. paper-grader uses `name_or_equation` + `character_count`; html-article uses `section_id` + `char_start/char_end`. These should merge into a unified section row with columns from both.

**Additional columns from html-article Math_Payload:** semantic_vector (G/M/E/S/T/K/R/Q/F/C), vector_string, address_hash — these attach at the paper level but could be promoted to per-section if the vector data is section-granular (it is — see section-vectors.jsonl in the Files output).

### Sheet: Output_Manifest
**Grain:** One row per output file
**Purpose:** Complete inventory of every file every station produced

| Source Station | Source Sheet | Fields |
|---------------|-------------|--------|
| paper-grader | Files | relative_path, size_bytes, modified_utc, extension |
| html-article | Files | relative_path, size_bytes, modified_utc, extension |
| classify-documents | Files | relative_path, size_bytes, modified_utc, extension |

**All three use identical column schema.** Direct UNION with an added `station` column.

### Sheet: Station_Index
**Grain:** One row per station
**Purpose:** Registry of all stations, their labels, run status, output locations

| Source | Sheet | Fields |
|--------|-------|--------|
| SELF_CONTAINED_STATION_INDEX | Station_Index | station, label, desktop_folder, run_status, primary_excel, notes |

**Enrichment candidates:** Add columns for sheet_count, total_file_count, total_size_bytes (computable from Output_Manifest).

---

## 3. Duplicates Flagged

| # | What | Where | Verdict |
|---|------|-------|---------|
| D1 | `station-canary-excel-sheets_20260601/paper-proof-grader_station_output_manifest.xlsx` | Exact copy of `paper-grader-dashboard-canary.../station_output_manifest.xlsx` | **Drop the copy.** Station_Index in this folder is the only unique file. |
| D2 | `station-canary-excel-sheets_20260601/html-article_station_output_manifest.xlsx` | Exact copy of `html-article-station-canary.../station_output_manifest.xlsx` | **Drop the copy.** |
| D3 | `station-canary-excel-sheets_20260601/classify-documents_station_output_manifest.xlsx` | Exact copy of `classify-documents-station-canary.../station_output_manifest.xlsx` | **Drop the copy.** |
| D4 | classify-documents: `Classification_Summary` vs `Sidecars` | Nearly identical grain (1 row per input file), nearly identical columns (top_label, top_score, engines). Classification_Summary uses `path` column; Sidecars uses `file` column and lists the .json sidecars instead of .md source files. | **Merge into one sheet.** Add a `file_type` column (source vs sidecar). |
| D5 | Station_Label / Station_Control across all 3 stations vs Station_Index | Station_Index already captures station, label, folder, status. Per-station control sheets add a few extra fields. | **Keep Station_Index as canonical.** Promote unique fields (address, vector_source, math_status, embedding_engine) to Station_Index columns. |

---

## 4. Canonical Column Normalization

These fields represent the same concept under different names. Pick one, alias the rest.

| Concept | paper-grader | html-article | classify-documents | **Canonical Name** |
|---------|-------------|--------------|--------------------|--------------------|
| Paper identifier | `paper_id` | `paper_uuid` / `page_id` | filename stem | **paper_id** |
| Source file | `source_file` | `source_file_name` | `path` | **source_file** |
| Run identifier | `run_id` | `run_id` | (not present) | **run_id** |
| Station name | `station` | `station` | `station` | **station** (consistent) |
| Timestamp | `ingested_at` | `last_updated_utc` / `generated_at_utc` / `generated_at` | `generated_at` | **processed_at_utc** |
| Content hash | `source_sha256` | `content_hash` | (not present) | **content_hash** |
| Section count | `section_count` (in Paper_Control) | `section_count` (in Metadata + Vector_Metadata) | (not present) | **section_count** |
| Equation count | `equation_count` (in Paper_Control) | `equation_count` (in Metadata + Math_Payload) | (not present) | **equation_count** |

---

## 5. Sheets With No Clear Master Home

| Sheet | Station | Issue | Recommendation |
|-------|---------|-------|----------------|
| Vector_Metadata | html-article | Per-paper embedding metadata (dim, source, mocked flag, top_neighbors). Not section-level despite containing section neighbor data. | **New sheet: Vector_Control** or fold into Paper_Control as extra columns. |
| Math_Payload | html-article | Per-paper math translation status + full semantic_vector (G/M/E/S/T/K/R/Q/F/C). Rich but paper-level. | **Split:** semantic_vector columns → PaperMaster. Run metadata → Paper_Control. |
| Sidecars | classify-documents | Duplicate of Classification_Summary (see D4). | **Merge into Classification_Summary with file_type column.** |

---

## 6. Master Workbook Schema Summary

```
MASTER_WORKBOOK.xlsx
├── PaperMaster          — 1 row/paper — identity, title, domain, classification, χ-vector
├── Paper_Control        — 1 row/paper/station — provenance, hashes, versions, timestamps  
├── Claim_Detail         — 1 row/claim — 7Q scoring, maturity, formal verification
├── Structure            — 1 row/section — section IDs, char positions, previews
├── Output_Manifest      — 1 row/file — every file every station produced
├── Station_Index        — 1 row/station — registry with enriched metadata
```

**Total unique grains:** 6
**Total source sheets across all stations:** 16
**Duplicates to eliminate:** 5
**Column normalizations needed:** 8

---

## 7. Next Steps (for David/Codex to decide)

1. **Codex:** Have each station emit canonical `paper_id` in a consistent format.
2. **Codex:** Have each station emit `processed_at_utc` instead of variant timestamp names.
3. **Opus:** Once stations are running on real papers (not canary), build the actual master workbook by reading manifests and merging per this map.
4. **Decision needed:** Should Vector_Control be its own sheet or columns on PaperMaster? Depends on whether vector metadata grows per-section.
5. **Decision needed:** Should Math_Payload semantic_vector (G/M/E/S/T/K/R/Q/F/C) live on PaperMaster or Structure? Currently paper-level but section-vectors.jsonl exists at section-level.

---

*Nothing was moved, deleted, or modified. This is a read-only merge map.*


---

## 8. IDENTITY CONTRACT (added by David, 2026-06-01)

### Canonical Join Key: `paper_uuid`

Every station output manifest MUST emit these columns:

| Column | Required | Purpose |
|--------|----------|---------|
| `paper_uuid` | YES | Corpus-level identity. Not station-local. Not display title. |
| `run_id` | YES | Which run of which station produced this row. |
| `station_id` | YES | Which station. |
| `source_sha256` | YES | Content hash of the source file at ingest time. |
| `source_path` | YES | Original path or archive path of the source file. |
| `source_file_name` | YES | Bare filename for human readability. |

### Current State (broken)

| Station | What It Emits | Problem |
|---------|---------------|---------|
| paper-proof-grader | `paper_id` = `codex_canary_dashboard_gtq02_20260601-191427` | Station-local compound name, not corpus identity |
| html-article | `paper_uuid` = `html-article-calibration` | Has the right column name but wrong value — still station-local |
| classify-documents | `path` = `canary-theophysics.md` / `canary-aviation.md` | Bare filename, no UUID concept at all |

None of these join cleanly. They are all local station names, not corpus identity.

### Fallback Join Rule (for the combiner)

```
1. If paper_uuid exists → join on paper_uuid
2. If no paper_uuid → derive provisional_paper_key from source_sha256
3. If no source_sha256 → derive provisional_paper_key from normalized source filename
4. NEVER join only on display title
```

### Columns Added to Every Master Sheet

All six master sheets (PaperMaster, Paper_Control, Claim_Detail, Structure, Output_Manifest, Station_Index) now carry:

```
paper_uuid              — canonical, corpus-level
provisional_paper_key   — fallback derived per rule above
run_id                  — station run
station_id              — which station
source_sha256           — content hash at ingest
source_path             — original location
source_file_name        — bare filename
```

This lets the workbook combine imperfect outputs without lying about identity. Stations get repaired to emit `paper_uuid` natively later — the combiner doesn't wait for that.

### Why This Matters

The merge map exposed the missing identity contract. Three stations, three local naming schemes, zero shared key. The workbook merge did its job: it found the structural gap before any data got joined on garbage.

---

*Identity contract added 2026-06-01. Merge map remains read-only — no data moved or deleted.*
