/-!
# Reference State Foundation

This file establishes the foundational vocabulary for the OT diagnostic chain.
All downstream theorems take these as explicit parameters to maintain boundary
discipline.

## Core Parameters

- `State : Type u` — the abstract state space.
- `Error : State → Prop` — predicate identifying deviation/decoherence states.
- `Reference : State → Prop` — predicate identifying the target coherence state.
- `disjoint : ∀ s, Error s → Reference s → False` — no state can be both.

## Boundary Discipline

- **FORMAL** lane: pure structural definitions, no empirical content.
- Does NOT assert existence of a Reference state (that requires a separate argument).
- Does NOT introduce physics, theology, or historical claims.
- Disjointness is treated as axiomatic for the problem structure.
-/

namespace T1Kernel

/-- Documentation-only: the abstract state space parameter.
In downstream applications this may be instantiated as moral states, relational
states, or physical states. At the kernel level it remains a parameter. -/
abbrev StateDoc := "See variable {State : Type u} in each theorem module"

/-- Documentation-only: the Error predicate parameter.
Identifies states exhibiting deviation from the reference condition. -/
abbrev ErrorDoc := "See parameter (Error : State → Prop) in each theorem"

/-- Documentation-only: the Reference predicate parameter.
Identifies states satisfying the target coherence condition. -/
abbrev ReferenceDoc := "See parameter (Reference : State → Prop) in each theorem"

/-- Lemma: disjointness is symmetric in its contrapositive form.
If a state is Reference, it cannot be Error. -/
theorem reference_not_error
    {State : Type u}
    (Error Reference : State → Prop)
    (disjoint : ∀ s, Error s → Reference s → False)
    (s : State)
    (h : Reference s) :
    ¬ Error s := by
  intro hError
  exact disjoint s hError h

end T1Kernel
