import T1Kernel.Closure
import T1Kernel.TargetedOpenness

/-!
# External Operator

Theorem lane: FORMAL skeleton with BRIDGE interpretation.

This file proves the next T1 corollary:

If an error state reaches a reference state by a finite sequence of operations,
then the sequence cannot be entirely error-preserving. Equivalently, at least
one operation in the restoration path is external to the error class.

This is the formal core beneath "self-salvation is impossible" and "restoration
requires an external operator." It does not identify that operator with any
specific theological referent.
-/

namespace T1Kernel

variable {State : Type u}
variable {Target : Type v}

/-- A finite operation list is error-closed when every operation preserves the
error class. -/
def ErrorClosedPath (Error : State -> Prop) (ops : List (State -> State)) : Prop :=
  forall op, op ∈ ops -> PreservesError Error op

/-- A finite operation list contains an external operation when at least one
operation does not preserve the error class. -/
def ContainsExternalOp (Error : State -> Prop) (ops : List (State -> State)) : Prop :=
  exists op, op ∈ ops /\ IsExternalToError Error op

/-- If a path contains no external operation, then it is error-closed. -/
theorem no_external_ops_implies_error_closed
    (Error : State -> Prop)
    (ops : List (State -> State))
    (hNoExternal : Not (ContainsExternalOp Error ops)) :
    ErrorClosedPath Error ops := by
  intro op opInOps
  classical
  by_cases hPreserve : PreservesError Error op
  · exact hPreserve
  · exact False.elim (hNoExternal ⟨op, opInOps, hPreserve⟩)

/-- If an error state reaches reference through a finite operation list, then
the list contains at least one external operation. -/
theorem restoration_path_contains_external_op
    (Error Reference : State -> Prop)
    (disjoint : forall state, Error state -> Reference state -> False)
    (ops : List (State -> State))
    (start : State)
    (startError : Error start)
    (endsReference : Reference (applyOps ops start)) :
    ContainsExternalOp Error ops := by
  classical
  by_cases hExternal : ContainsExternalOp Error ops
  · exact hExternal
  · have hClosed : ErrorClosedPath Error ops :=
      no_external_ops_implies_error_closed Error ops hExternal
    have hBlocked : Not (Reference (applyOps ops start)) :=
      no_error_closed_path_to_reference Error Reference disjoint ops hClosed start startError
    exact False.elim (hBlocked endsReference)

/-- Targeted restoration additionally requires actual/reference openness for
the reception event. This theorem does not prove that reception occurs; it only
extracts the actual-target openness from the reception premise. -/
theorem targeted_restoration_reception_requires_actual_openness
    (O : OpenTo State Target)
    (actual : Target)
    (op : State -> State)
    (state : State)
    (receives : ReceivesActual O actual op state) :
    O state actual := by
  exact receives_actual_implies_actual_openness O actual op state receives

/-- Full local skeleton: if a finite path restores an error state to reference,
and a selected operator in that path is received as actual/reference-targeted,
then the path contains an external operation and that selected reception entails
actual openness.

The selected operator is intentionally not proven to be the external operation;
that stronger claim requires a richer model of step-indexed path reception. -/
theorem restoration_requires_external_path_and_actual_openness
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (disjoint : forall state, Error state -> Reference state -> False)
    (ops : List (State -> State))
    (start receiveState : State)
    (receiveOp : State -> State)
    (startError : Error start)
    (endsReference : Reference (applyOps ops start))
    (receives : ReceivesActual O actual receiveOp receiveState) :
    ContainsExternalOp Error ops /\ O receiveState actual := by
  constructor
  · exact restoration_path_contains_external_op
      Error Reference disjoint ops start startError endsReference
  · exact targeted_restoration_reception_requires_actual_openness
      O actual receiveOp receiveState receives

end T1Kernel
