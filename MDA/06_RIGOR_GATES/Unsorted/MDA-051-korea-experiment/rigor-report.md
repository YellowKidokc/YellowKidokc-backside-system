# Rigor Gate: MDA-051-korea-experiment

- Series: `Unsorted`
- Verdict: `NEEDS_RIGOR`
- Generated: `2026-05-30T05:35:30`
- Source JSON: `\\dlowenas\brain\apps\paper-intelligence-suite-python\OUTPUT\mda_math_translation_full61_20260530_053137\03_FINAL_READY\Unsorted\MDA-051-korea-experiment\JSON\MDA-051-korea-experiment.paper-grade.json`
- Claim count: 3
- Failing claim count: 3
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
- weak:Q4_evidence: 3
- weak:Q5_falsifiability: 3
- weak:Q6_boundary: 3

## Claim Checks

### Claim 1

- Status: `FAIL`
- Failures: weak:Q3_mechanism, weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: Remember the coherence equation: χ(t+1) = χ(t) × (1 − δ) + β

### Claim 2

- Status: `FAIL`
- Failures: weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: South Korea in 1953 was rubble. * Colonized for 35 years (Japan) * War-devastated * Split from half its country * One of poorest nations on Earth * χ was **well below threshold** By every measure, South Korea should have collapsed into permanent dysfunction.

### Claim 3

- Status: `FAIL`
- Failures: weak:Q3_mechanism, weak:Q4_evidence, weak:Q5_falsifiability, weak:Q6_boundary
- Claim: North Korea shows what happens when β = 0.
