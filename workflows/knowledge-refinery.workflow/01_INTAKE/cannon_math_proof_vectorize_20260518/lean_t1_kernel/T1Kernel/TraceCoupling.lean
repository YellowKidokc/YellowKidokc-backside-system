import T1Kernel.Closure

/-!
# Trace Coupling

Theorem lane: FORMAL skeleton.

This file restates the T1 closure theorem in trace/coupling language.
-/

namespace T1Kernel

variable {State : Type u}

/-- A trace is a finite sequence of operations applied to a start state. -/
structure Trace (State : Type u) where
  ops : List (State -> State)
  start : State

/-- A trace is error-closed when every operation preserves the Error predicate. -/
def Trace.IsErrorClosed (Error : State -> Prop) (t : Trace State) : Prop :=
  forall op, op ∈ t.ops -> PreservesError Error op

/-- State `b` is coupled to state `a` by executing the listed operations. -/
def Coupled (a b : State) (ops : List (State -> State)) : Prop :=
  applyOps ops a = b

/-- If `b` is coupled to `a` by an error-closed trace and `a` is error, then
`b` is error. -/
theorem coupled_error_preservation
    (Error : State -> Prop)
    (a b : State)
    (ops : List (State -> State))
    (hCouple : Coupled a b ops)
    (hClosed : forall op, op ∈ ops -> PreservesError Error op)
    (hError : Error a) :
    Error b := by
  unfold Coupled at hCouple
  rw [← hCouple]
  exact applyOps_preserves_error Error ops hClosed a hError

/-- No error-closed coupling can carry an error state to reference when Error and
Reference are disjoint. -/
theorem no_error_closed_coupling_to_reference
    (Error Reference : State -> Prop)
    (disjoint : forall state, Error state -> Reference state -> False)
    (start : State)
    (ops : List (State -> State))
    (hClosed : forall op, op ∈ ops -> PreservesError Error op)
    (hError : Error start) :
    Not (Reference (applyOps ops start)) := by
  intro hRef
  exact disjoint (applyOps ops start)
    (applyOps_preserves_error Error ops hClosed start hError)
    hRef

end T1Kernel
