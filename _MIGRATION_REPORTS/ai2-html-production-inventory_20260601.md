# AI2 HTML Production Inventory - 2026-06-01

Scope: inventory and merge planning only. No production HTML was rewritten, moved, or bulk-modified.

## Inventory Summary

Set A styled production candidate:

- Root: `\\dlowenas\HPWorkstation\Desktop\Master HTMl\K-Production-Ready\03-moral-decline`
- Top-level HTML files: 62
- Top-level MDA article/index files: 61 MDA files plus `index.html`
- Styled/nav/audio/SEO markers: 62 of 62 top-level files
- Four-tab markers detected: 60 of 62 top-level files
- Encoding/mojibake marker files detected: 6 top-level files

Set B four-tab reader/source candidate:

- Root: `X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD`
- Root-level HTML files: 61
- `reader_combined` HTML files: 62
- Recursive HTML files: 123
- Unique MDA ids detected recursively: 61
- Four-tab markers detected: 122 of 123 recursive files
- Encoding/mojibake marker files detected: 114 recursive files

Important break point: Set B is duplicated. The root has 61 HTML files, and `reader_combined` has a second copy of the same 61 MDA pages plus `index.html`. Do not merge both copies.

Existing output candidate also found:

- Root: `X:\WORKFLOWS\MDA-PUBLICATION\08_DEPLOY_READY`
- HTML files: 62
- MDA files: 61
- Styled markers: 62
- Four-tab markers: 60
- Status: treat as an existing merged output candidate, not proof that production is complete.

## Set A Styled Pages

Preferred Set A root:

`\\dlowenas\HPWorkstation\Desktop\Master HTMl\K-Production-Ready\03-moral-decline`

Why this is Set A:

- It contains the styled MDA production pages at top level.
- Representative page `MDA-003-measuring-moral-health.html` has sidebar/nav, audio markers, SEO/schema markers, and four reading-level/proof markers.
- It has production-side structure and media/metadata surface that should be preserved.

Top-level Set A count:

- `index.html`: 1
- `MDA-000`: 1
- `MDA-001` through `MDA-003`: present
- `MDA-004`: missing
- `MDA-005` through `MDA-054`: present
- `MDA-900` through `MDA-906`: present

Set A encoding marker hits:

- `index.html`
- `MDA-011-collective-security-1930.html`
- `MDA-017-unraveling-1960.html`
- `MDA-041-statistical-spine.html`
- `MDA-048-ordnung-algorithm-THE-MECHANISM.html`
- `MDA-903-appendix-series-home.html`

Note: `DEPLOY-READY` under Set A exists and contains 402 recursive HTML files, but that includes archive/workflow copies. For merge planning, the production candidate is the top-level Set A page set, not the recursive archive mass.

## Set B Four-Tab Pages

Preferred Set B root:

`X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD`

Subsets found:

- Root-level source: 61 HTML files, all four-tab.
- `reader_combined`: 62 HTML files, including `index.html`; 61 MDA pages are duplicate ids against the root-level source.

Why this is Set B:

- Representative root page `MDA-003-measuring-moral-health.html` has Easy, Standard, Academic, and Proof markers.
- It does not have production nav/audio/SEO markers.
- It has widespread mojibake in titles/body text and should not replace Set A metadata directly.

Representative structural difference:

- Set A representative: `\\dlowenas\HPWorkstation\Desktop\Master HTMl\K-Production-Ready\03-moral-decline\MDA-003-measuring-moral-health.html`
  - Size: about 45 KB
  - Title: `Part 1: What If We Could Measure Moral Health? &mdash; The Moral Decline of America`
  - Has sidebar/nav: yes
  - Has audio: yes
  - Has SEO/schema/canonical markers: yes
  - Has Easy/Standard/Academic/Proof markers: yes
  - Mojibake marker count: 0

- Set B representative: `X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD\MDA-003-measuring-moral-health.html`
  - Size: about 38 KB
  - Title contains mojibake: `Part 1: What If We Could Measure Moral Health? ... The Moral Decline of America ... Moral Decline of America`
  - Has sidebar/nav: no
  - Has audio: no
  - Has SEO/schema/canonical markers: no
  - Has Easy/Standard/Academic/Proof markers: yes
  - Mojibake marker count: 23

`reader_combined\MDA-003-measuring-moral-health.html` is larger at about 61 KB and has nav-like reader structure, but it is still a duplicate Set B source, not a production replacement.

## Match Table

| ID | Set A | Set B | Status |
|---|---|---|---|
| MDA-000 | `MDA-000-series-map.html` | missing | A only |
| MDA-001 | `MDA-001-story-introduction.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-002 | `MDA-002-samuel-1900.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-003 | `MDA-003-measuring-moral-health.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-004 | missing | `MDA-004-facts-framework.html` root + `reader_combined` | B only |
| MDA-005 | `MDA-005-empirical-evidence.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-006 | `MDA-006-research-method.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-007 | `MDA-007-nine-domains.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-008 | `MDA-008-henry-1926.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-009 | `MDA-009-the-1900-baseline.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-010 | `MDA-010-pre-modern-baseline.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-011 | `MDA-011-collective-security-1930.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-012 | `MDA-012-william-1950.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-013 | `MDA-013-peak-coherence-1940.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-014 | `MDA-014-fissure-1950.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-015 | `MDA-015-long-decline.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-016 | `MDA-016-thomas-1974.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-017 | `MDA-017-unraveling-1960.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-018 | `MDA-018-great-decoupling-1968.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-019 | `MDA-019-current-state-2024.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-020 | `MDA-020-phase-transition.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-021 | `MDA-021-anatomy-of-phase-transition.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-022 | `MDA-022-cascade.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-023 | `MDA-023-coherence-cascade.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-024 | `MDA-024-semantic-collapse.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-025 | `MDA-025-cognitive-decline.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-026 | `MDA-026-spiritual-collapse.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-027 | `MDA-027-signal-went-dark.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-028 | `MDA-028-phantom-money.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-029 | `MDA-029-observer-collapsed.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-030 | `MDA-030-trinity-mechanism.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-031 | `MDA-031-jacob-1998.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-032 | `MDA-032-why-bad-is-easier.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-033 | `MDA-033-entropic-society.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-034 | `MDA-034-technology-entropy.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-035 | `MDA-035-great-reconfiguration.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-036 | `MDA-036-regulatory-impulse-1900.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-037 | `MDA-037-biaxiosum-audit.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-038 | `MDA-038-coherence-metric.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-039 | `MDA-039-physics-of-coherence.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-040 | `MDA-040-statistical-synthesis.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-041 | `MDA-041-statistical-spine.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-042 | `MDA-042-amish-exception-THE-CLAIM.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-043 | `MDA-043-amish-proof-THE-PROOF.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-044 | `MDA-044-amish-control-study-THE-METHOD.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-045 | `MDA-045-amish-control-group-THE-DATA.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-046 | `MDA-046-amish-demographics-THE-NUMBERS.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-047 | `MDA-047-amish-tech-filter-THE-FILTER.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-048 | `MDA-048-ordnung-algorithm-THE-MECHANISM.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-049 | `MDA-049-coherence-factory-THE-SYNTHESIS.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-050 | `MDA-050-jacob-2025.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-051 | `MDA-051-korea-experiment.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-052 | `MDA-052-individual-recovery.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-053 | `MDA-053-the-question.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-054 | `MDA-054-way-back.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-900 | `MDA-900-appendix-original-introduction.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-901 | `MDA-901-appendix-america-index.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-902 | `MDA-902-appendix-trans-domain-analysis.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-903 | `MDA-903-appendix-series-home.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-904 | `MDA-904-appendix-sample.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-905 | `MDA-905-appendix-timeline.html` | root + `reader_combined` | matched but duplicated in B |
| MDA-906 | `MDA-906-appendix-93-year-floor.html` | root + `reader_combined` | matched but duplicated in B |

## Missing / Mismatched

Hard mismatches:

- `MDA-000` exists in Set A but not Set B.
- `MDA-004` exists in Set B but not Set A.
- All common Set B MDA ids are duplicated between root and `reader_combined`.

Metadata/title conflicts:

- Set B titles frequently append `Moral Decline of America` twice.
- Set B has widespread mojibake in title/body surfaces.
- Several Set A titles still contain legacy entity/malformed character patterns, but Set A is much cleaner than Set B and owns the production SEO/audio/nav surface.

Encoding risk:

- Set B should be treated as content-source only after ftfy/encoding cleanup or extraction through a parser that normalizes text.
- Do not copy Set B `<title>`, meta tags, JSON-LD, canonical URLs, stylesheet links, nav wrappers, or scripts into Set A.

Structural risk:

- Set A already has four-tab markers on 60 pages. A future merge script must compare existing tab content against Set B before replacing anything.
- `MDA-000`, `index.html`, and probably the series-map/navigation pages should be handled separately from article-body merges.
- `MDA-004` needs a production-styled shell or a deliberate insertion point in Set A before it can become a final production page.

## Recommended Merge Strategy

Recommendation: merge reader/proof content into the styled Set A production pages, preserving Set A styling, nav, audio, SEO, schema, canonical URLs, and page-level metadata.

Use Set A as the target:

`\\dlowenas\HPWorkstation\Desktop\Master HTMl\K-Production-Ready\03-moral-decline`

Use Set B as content input only after choosing one source copy:

- Prefer `X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD\reader_combined` if its body structure has the richer combined reader content needed for injection.
- Prefer root-level `X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD` if the goal is the cleaner/simple four-tab source.
- Do not use both without deduping by MDA id.

Merge policy:

1. Match by `MDA-###`, not by folder location.
2. For common ids, extract only the Easy / Standard / Academic / Proof content blocks from Set B.
3. Normalize encoding before injection.
4. Preserve Set A `<head>`, nav/sidebar, audio controls, schema, canonical, page order, and local assets.
5. For Set A pages that already have four-tab blocks, diff block-by-block before replacement.
6. For `MDA-004`, create or locate a Set A styled target shell before injection.
7. For `MDA-000` and `index.html`, leave unchanged unless a separate series-index merge is requested.
8. Emit a dry-run manifest before writing any HTML.

/CHAIN weakest link: content-block extraction. If the extractor grabs page chrome or malformed duplicated B pages, the final pages will preserve styling but inject broken or repeated reader content. The next pass must prove extraction correctness on two pages before any batch write.

## Exact Next Command Plan

Dry-run only:

```powershell
$setA = "\\dlowenas\HPWorkstation\Desktop\Master HTMl\K-Production-Ready\03-moral-decline"
$setB = "X:\WORKFLOWS\MDA-PUBLICATION\06_HTML_BUILD\reader_combined"
$out  = "X:\Backside\_MIGRATION_REPORTS\ai2-html-merge-dryrun_20260601.csv"

# 1. Build manifest by MDA id.
# 2. Select one Set B source per id.
# 3. Compare Set A and Set B titles without copying metadata.
# 4. Extract four tab blocks from Set B.
# 5. Detect whether Set A already has corresponding tab blocks.
# 6. Report action: skip, replace-tabs, add-tabs, create-target-needed.
# 7. Write CSV manifest only.
```

Pilot merge after dry-run review:

```powershell
# Copy two Set A pages into a sandbox folder first:
# - MDA-003-measuring-moral-health.html
# - MDA-004-facts-framework.html target shell decision required
#
# Run injection only inside sandbox.
# Verify in browser:
# - nav/sidebar still works
# - audio still present
# - SEO/head unchanged
# - four tabs switch correctly
# - no duplicated title chrome
# - no mojibake in visible reader text
```

Stop condition before batch:

- Any Set B extraction contains nav/sidebar/title chrome.
- Any injected page loses audio, schema, canonical URL, or stylesheet links.
- Any page retains mojibake after normalization.
- `MDA-004` target-shell decision is unresolved.

Closeout: production HTML is not done. This report is the inventory and merge-plan pass only.
