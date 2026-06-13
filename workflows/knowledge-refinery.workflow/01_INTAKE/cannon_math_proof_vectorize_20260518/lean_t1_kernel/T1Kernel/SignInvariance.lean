import T1Kernel.Closure

/-!
# Sign Invariance

Theorem lane: FORMAL.

This file keeps the T8 claim honest:

* From `PreservesError` alone we can prove that self-generated/error-closed
  operations cannot reach a reference state.
* If a separate sign/orientation function is supplied, and error states are
  negative while reference states are positive, the same closure theorem also
  blocks sign-crossing into the positive/reference class.
* Full "sign preservation" requires an explicit `PreservesSign` assumption. It
  is not smuggled in as a theorem from error-closure alone.

Boundary: openness/repentance is posture, not restoring operation. That belongs
to `OpennessGrace`, not this theorem.
-/

namespace T1Kernel

variable {State : Type u}

/-- A sign/orientation function assigns a directed value to each state. -/
abbrev SignFunction (State : Type u) := State -> Int

/-- An operation preserves sign when it does not change the state's orientation. -/
def PreservesSign
    (Sign : SignFunction State)
    (op : State -> State) : Prop :=
  forall state, Sign (op state) = Sign state

/-- Apply a finite list of operations from left to right. This is kept separate
from `applyOps` only in documentation; the implementation uses `applyOps` from
`Closure.lean`. -/
theorem applyOps_preserves_sign
    (Sign : SignFunction State)
    (ops : List (State -> State))
    (allPreserve : forall op, op ∈ ops -> PreservesSign Sign op) :
    forall start, Sign (applyOps ops start) = Sign start := by
  induction ops with
  | nil =>
      intro start
      rfl
  | cons op rest ih =>
      intro start
      unfold applyOps
      simp [List.foldl_cons]
      calc
        Sign (applyOps rest (op start)) = Sign (op start) := by
          apply ih
          intro nextOp nextOpInRest
          exact allPreserve nextOp (List.mem_cons_of_mem op nextOpInRest)
        _ = Sign start := by
          exact allPreserve op List.mem_cons_self start

/-- If error states are negative and reference states are positive, an
error-preserving operation cannot map an error state to a reference state. -/
theorem error_preserving_op_cannot_reach_positive_reference
    (Error Reference : State -> Prop)
    (Sign : SignFunction State)
    (errorNegative : forall state, Error state -> Sign state < 0)
    (referencePositive : forall state, Reference state -> Sign state > 0)
    (op : State -> State)
    (preservesError : PreservesError Error op)
    (start : State)
    (startError : Error start) :
    Not (Reference (op start)) := by
  intro refAfter
  have errorAfter : Error (op start) := preservesError start startError
  have negAfter : Sign (op start) < 0 := errorNegative (op start) errorAfter
  have posAfter : 0 < Sign (op start) := referencePositive (op start) refAfter
  exact (Int.lt_irrefl (Sign (op start))) (Int.lt_trans negAfter posAfter)

/-- Finite-list version of the preceding theorem. If every operation preserves
the error class, the finite composition cannot land in a positive/reference
state from a negative/error start. -/
theorem error_closed_path_cannot_reach_positive_reference
    (Error Reference : State -> Prop)
    (Sign : SignFunction State)
    (errorNegative : forall state, Error state -> Sign state < 0)
    (referencePositive : forall state, Reference state -> Sign state > 0)
    (ops : List (State -> State))
    (allPreserveError : forall op, op ∈ ops -> PreservesError Error op)
    (start : State)
    (startError : Error start) :
    Not (Reference (applyOps ops start)) := by
  intro refAfter
  have errorAfter : Error (applyOps ops start) :=
    applyOps_preserves_error Error ops allPreserveError start startError
  have negAfter : Sign (applyOps ops start) < 0 :=
    errorNegative (applyOps ops start) errorAfter
  have posAfter : 0 < Sign (applyOps ops start) :=
    referencePositive (applyOps ops start) refAfter
  exact (Int.lt_irrefl (Sign (applyOps ops start))) (Int.lt_trans negAfter posAfter)

/-- If every operation preserves sign, their finite composition preserves sign.
This is the literal sign-invariance theorem, but it depends on the explicit
`PreservesSign` premise rather than deriving sign preservation from nowhere. -/
theorem sign_invariance_under_sign_preserving_ops
    (Sign : SignFunction State)
    (ops : List (State -> State))
    (allPreserve : forall op, op ∈ ops -> PreservesSign Sign op)
    (start : State) :
    Sign (applyOps ops start) = Sign start :=
  applyOps_preserves_sign Sign ops allPreserve start

end T1Kernel
