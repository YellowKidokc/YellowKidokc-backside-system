import T1Kernel.RestorationProfile

/-!
# Continuity and Identity

Theorem lane: FORMAL skeleton.

This module adds the missing continuity/replacement predicate needed before
rival-model analysis.

Core distinction:

* continuity preserves the identity assigned to a state;
* replacement changes that identity;
* a path whose operations all preserve identity cannot change identity from
  start to terminal.

This is not yet a theory of soul, resurrection, memory, body, or personal
identity. It is the minimal formal gate that prevents "destroy and replace" from
being silently counted as "restore the same subject."
-/

namespace T1Kernel

variable {State : Type u}
variable {Identity : Type v}
variable {Target : Type w}

/-- An identity assignment maps each state to the subject/entity it preserves. -/
abbrev IdentityOf (State : Type u) (Identity : Type v) := State -> Identity

/-- An operation preserves identity when the output has the same identity as the
input. -/
def PreservesIdentity
    (identityOf : IdentityOf State Identity)
    (op : State -> State) : Prop :=
  forall state, identityOf (op state) = identityOf state

/-- An operation replaces identity when at least one input is mapped to a state
with a different identity. -/
def ReplacesIdentity
    (identityOf : IdentityOf State Identity)
    (op : State -> State) : Prop :=
  exists state, Not (identityOf (op state) = identityOf state)

/-- A finite path preserves identity when each operation in it preserves
identity. -/
def PathPreservesIdentity
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State)) : Prop :=
  forall op, op ∈ ops -> PreservesIdentity identityOf op

/-- A finite path contains an identity-replacing operation. -/
def ContainsIdentityReplacingOp
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State)) : Prop :=
  exists op, op ∈ ops /\ ReplacesIdentity identityOf op

/-- Replacement contradicts identity preservation. -/
theorem replacement_not_identity_preserving
    (identityOf : IdentityOf State Identity)
    (op : State -> State)
    (hReplacement : ReplacesIdentity identityOf op) :
    Not (PreservesIdentity identityOf op) := by
  intro hPreserves
  rcases hReplacement with ⟨state, hChanged⟩
  exact hChanged (hPreserves state)

/-- Failure to preserve identity is exactly replacement for some state. -/
theorem not_identity_preserving_implies_replacement
    (identityOf : IdentityOf State Identity)
    (op : State -> State)
    (hNotPreserves : Not (PreservesIdentity identityOf op)) :
    ReplacesIdentity identityOf op := by
  classical
  by_cases hReplacement : ReplacesIdentity identityOf op
  · exact hReplacement
  · have hPreserves : PreservesIdentity identityOf op := by
      intro state
      by_cases hSame : identityOf (op state) = identityOf state
      · exact hSame
      · exact False.elim (hReplacement ⟨state, hSame⟩)
    exact False.elim (hNotPreserves hPreserves)

/-- If every operation in a path preserves identity, the whole finite path
preserves identity from start to result. -/
theorem applyOps_preserves_identity
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State))
    (allPreserve : PathPreservesIdentity identityOf ops) :
    forall start, identityOf (applyOps ops start) = identityOf start := by
  induction ops with
  | nil =>
      intro start
      rfl
  | cons op rest ih =>
      intro start
      unfold applyOps
      simp [List.foldl_cons]
      calc
        identityOf (applyOps rest (op start)) = identityOf (op start) := by
          apply ih
          intro nextOp nextOpInRest
          exact allPreserve nextOp (List.mem_cons_of_mem op nextOpInRest)
        _ = identityOf start := by
          exact allPreserve op List.mem_cons_self start

/-- If a path contains no identity-replacing operation, every operation in it
preserves identity. -/
theorem no_replacement_ops_implies_path_preserves_identity
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State))
    (hNoReplacement : Not (ContainsIdentityReplacingOp identityOf ops)) :
    PathPreservesIdentity identityOf ops := by
  intro op opInOps
  classical
  by_cases hPreserves : PreservesIdentity identityOf op
  · exact hPreserves
  · have hReplacement : ReplacesIdentity identityOf op :=
      not_identity_preserving_implies_replacement identityOf op hPreserves
    exact False.elim (hNoReplacement ⟨op, opInOps, hReplacement⟩)

/-- If a finite path changes identity from start to result, it must contain an
identity-replacing operation. -/
theorem identity_change_path_contains_replacement
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State))
    (start : State)
    (hChanged : Not (identityOf (applyOps ops start) = identityOf start)) :
    ContainsIdentityReplacingOp identityOf ops := by
  classical
  by_cases hContains : ContainsIdentityReplacingOp identityOf ops
  · exact hContains
  · have hPathPreserves : PathPreservesIdentity identityOf ops :=
      no_replacement_ops_implies_path_preserves_identity identityOf ops hContains
    exact False.elim
      (hChanged (applyOps_preserves_identity identityOf ops hPathPreserves start))

/-- A continuous path preserves the identity of a named terminal state when that
terminal is the path result. -/
theorem continuous_path_preserves_terminal_identity
    (identityOf : IdentityOf State Identity)
    (ops : List (State -> State))
    (start terminal : State)
    (terminalIsPathResult : terminal = applyOps ops start)
    (pathPreserves : PathPreservesIdentity identityOf ops) :
    identityOf terminal = identityOf start := by
  rw [terminalIsPathResult]
  exact applyOps_preserves_identity identityOf ops pathPreserves start

/-- A restoration profile plus an identity-preserving path preserves identity
from start to terminal. -/
theorem profile_with_identity_continuity_preserves_terminal_identity
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (identityOf : IdentityOf State Identity)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState)
    (pathPreserves : PathPreservesIdentity identityOf ops) :
    identityOf terminal = identityOf start := by
  exact continuous_path_preserves_terminal_identity
    identityOf ops start terminal profile.terminalIsPathResult pathPreserves

end T1Kernel
