# Rigor Gate: MDA-024-semantic-collapse

- Series: `Unsorted`
- Verdict: `NEEDS_RIGOR`
- Generated: `2026-05-30T05:35:29`
- Source JSON: `\\dlowenas\brain\apps\paper-intelligence-suite-python\OUTPUT\mda_math_translation_full61_20260530_053137\03_FINAL_READY\Unsorted\MDA-024-semantic-collapse\JSON\MDA-024-semantic-collapse.paper-grade.json`
- Claim count: 4
- Failing claim count: 4
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

- weak:Q3_mechanism: 1
- weak:Q4_evidence: 1
- weak:Q5_falsifiability: 4
- weak:Q6_boundary: 4

## Claim Checks

### Claim 1

- Status: `FAIL`
- Failures: weak:Q5_falsifiability, weak:Q6_boundary
- Claim: The Ngram data for "conscience" shows a steep decline commencing in the 1950s and accelerating downward through the 1960s.

### Claim 2

- Status: `FAIL`
- Failures: weak:Q5_falsifiability, weak:Q6_boundary
- Claim: But the data shows that the usage of words like *Modesty* and *Chastity* was already in a free fall by **1961**.

### Claim 3

- Status: `FAIL`
- Failures: weak:Q5_falsifiability, weak:Q6_boundary
- Claim: 1950s "Conscience" begins steep decline — Ngram data shows accelerating downward trend through the 1960s.

### Claim 4

- Status: `FAIL`
- Failures: weak:Q3_mechanism, weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: Core article, supporting evidence, and broader context Ring 1 — This Article
