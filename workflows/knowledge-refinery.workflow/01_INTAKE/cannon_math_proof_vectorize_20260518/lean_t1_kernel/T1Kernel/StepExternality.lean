import T1Kernel.ExternalOperator

/-!
# Step-Localized Externality

Theorem lane: FORMAL skeleton.

`ExternalOperator.lean` proves that a restoration path contains some external
operation. This module makes the witness path-local: there is a prefix, an
external operation, and a suffix whose concatenation is the original operation
list.

This is the minimum structure needed before later modules can attach reception,
coupling, or stress-test semantics to the crossing step itself.
-/

namespace T1Kernel

variable {State : Type u}

/-- A path contains an external step when it decomposes into a prefix, an
external operation, and a suffix. -/
def ContainsExternalStep
    (Error : State -> Prop)
    (ops : List (State -> State)) : Prop :=
  exists before op after,
    ops = before ++ op :: after /\ IsExternalToError Error op

/-- A located external step always gives the unlocated external-operation
predicate. -/
theorem external_step_implies_external_op
    (Error : State -> Prop)
    (ops : List (State -> State))
    (hStep : ContainsExternalStep Error ops) :
    ContainsExternalOp Error ops := by
  rcases hStep with ⟨before, op, after, hEq, hExternal⟩
  refine ⟨op, ?_, hExternal⟩
  rw [hEq]
  exact List.mem_append_right before List.mem_cons_self

/-- Any unlocated external operation in a finite list can be localized as a
prefix/op/suffix decomposition. -/
theorem external_op_implies_external_step
    (Error : State -> Prop)
    (ops : List (State -> State))
    (hExternalOp : ContainsExternalOp Error ops) :
    ContainsExternalStep Error ops := by
  induction ops with
  | nil =>
      rcases hExternalOp with ⟨op, opInOps, _hExternal⟩
      cases opInOps
  | cons head tail ih =>
      rcases hExternalOp with ⟨op, opInOps, hExternal⟩
      have hCases := List.mem_cons.mp opInOps
      cases hCases with
      | inl opEqHead =>
          subst op
          exact ⟨[], head, tail, rfl, hExternal⟩
      | inr opInTail =>
          have hTailStep : ContainsExternalStep Error tail :=
            ih ⟨op, opInTail, hExternal⟩
          rcases hTailStep with ⟨before, stepOp, after, hTailEq, hStepExternal⟩
          exact ⟨head :: before, stepOp, after, by
            rw [hTailEq]
            rfl, hStepExternal⟩

/-- The unlocated and step-localized externality predicates are equivalent. -/
theorem external_op_iff_external_step
    (Error : State -> Prop)
    (ops : List (State -> State)) :
    ContainsExternalOp Error ops <-> ContainsExternalStep Error ops := by
  constructor
  · exact external_op_implies_external_step Error ops
  · exact external_step_implies_external_op Error ops

/-- If an error state reaches reference through a finite path, the external
operation can be localized to a concrete path step. -/
theorem restoration_path_contains_external_step
    (Error Reference : State -> Prop)
    (disjoint : forall state, Error state -> Reference state -> False)
    (ops : List (State -> State))
    (start : State)
    (startError : Error start)
    (endsReference : Reference (applyOps ops start)) :
    ContainsExternalStep Error ops := by
  exact external_op_implies_external_step Error ops
    (restoration_path_contains_external_op
      Error Reference disjoint ops start startError endsReference)

end T1Kernel
