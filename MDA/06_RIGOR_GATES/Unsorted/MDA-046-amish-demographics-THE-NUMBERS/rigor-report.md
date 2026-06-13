# Rigor Gate: MDA-046-amish-demographics-THE-NUMBERS

- Series: `Unsorted`
- Verdict: `NEEDS_RIGOR`
- Generated: `2026-05-30T05:35:30`
- Source JSON: `\\dlowenas\brain\apps\paper-intelligence-suite-python\OUTPUT\mda_math_translation_full61_20260530_053137\03_FINAL_READY\Unsorted\MDA-046-amish-demographics-THE-NUMBERS\JSON\MDA-046-amish-demographics-THE-NUMBERS.paper-grade.json`
- Claim count: 6
- Failing claim count: 6
- Formal marker count: 0

## Meaning

- `FORMALIZED` is reserved for a verified Lean/Lake build artifact. This gate does not award it automatically.
- `FORMALIZATION_CANDIDATE` means the paper has formal-looking material and no detected audit gaps.
- `AUDIT_READY` means the paper has enough claim/evidence/boundary structure for downstream use, but is not Lean-formalized.
- `NEEDS_RIGOR` means it should not be treated as accepted or reusable without repair.

## Rejection-First Requirements

- State the positive claim.
- Name the exact dependency chain.
- Name close false positives.
- Explain why each false positive fails.
- Keep evidence, boundary, and kill conditions separate.
- Log mistakes and overclaims instead of smoothing them away.

## Failure Counts

- weak:Q3_mechanism: 2
- weak:Q4_evidence: 6
- weak:Q5_falsifiability: 4
- weak:Q6_boundary: 6

## Claim Checks

### Claim 1

- Status: `FAIL`
- Failures: weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: Demographers therefore rely on a bottom-up approach: count church districts (congregations) and multiply by average district size, which runs roughly 130 to 170 individuals (adults and children combined).

### Claim 2

- Status: `FAIL`
- Failures: weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: Ultra-conservative groups — Swartzentruber, Andy Weaver — exhibit TFRs north of 9.0. **Differential fertility means the Amish population is becoming statistically more conservative over time**, because the strictest subgroups reproduce fastest.

### Claim 3

- Status: `FAIL`
- Failures: weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: That demographic momentum guarantees continued growth for decades even if fertility were to modestly decline, because the cohort of women entering reproductive years is constantly expanding. ---

### Claim 4

- Status: `FAIL`
- Failures: weak:Q3_mechanism, weak:Q4_evidence, weak:Q6_boundary
- Claim: It also predicts something uncomfortable for the broader culture: the part of the Amish population that is growing fastest is also the part with the strictest separation, the most rigorous shunning, and the lowest tolerance for compromise. ---

### Claim 5

- Status: `FAIL`
- Failures: weak:Q4_evidence, weak:Q6_boundary
- Claim: The migration drivers are predictable and worth naming because they recur across every settlement directory: fertile farmland at reasonable prices, proximity to non-farm work, rural isolation, pro-Amish regulatory environments, proximity to family, and church conflict resolution through physical separation. ---

### Claim 6

- Status: `FAIL`
- Failures: weak:Q3_mechanism, weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: The most tangible evidence of Amish capital accumulation is a single regulated institution: the **Bank of Bird-in-Hand (BBIH)**, established in 2013 in the heart of Lancaster County as the first U.S. bank chartered specifically to serve the Plain community.
