/-!
# T1 Closure Kernel

This file formalizes only the narrow closure skeleton:

If `Error` and `Reference` are disjoint predicates on one state space, and every
self-generated operation preserves `Error`, then any finite sequence of those
operations applied to an error state remains in `Error` and therefore cannot be
`Reference`.

It does not prove Christianity, theology, product form, mediator uniqueness, or
any physics bridge. Those are intentionally outside theorem one.
-/

namespace T1Kernel

variable {State : Type u}

/-- An operation preserves the error class when it maps every error state to an
error state. -/
def PreservesError (Error : State → Prop) (op : State → State) : Prop :=
  ∀ state, Error state → Error (op state)

/-- Apply a finite list of operations from left to right. -/
def applyOps (ops : List (State → State)) (start : State) : State :=
  ops.foldl (fun state op => op state) start

/-- If every operation in a finite list preserves `Error`, then their finite
composition preserves `Error`. -/
theorem applyOps_preserves_error
    (Error : State → Prop)
    (ops : List (State → State))
    (allPreserve : ∀ op ∈ ops, PreservesError Error op) :
    ∀ start, Error start → Error (applyOps ops start) := by
  induction ops with
  | nil =>
      intro start startError
      exact startError
  | cons op rest ih =>
      intro start startError
      unfold applyOps
      simp [List.foldl_cons]
      apply ih
      · intro nextOp nextOpInRest
        exact allPreserve nextOp (List.mem_cons_of_mem op nextOpInRest)
      · exact allPreserve op List.mem_cons_self start startError

/-- T1 closure theorem: no finite composition of error-preserving operations can
produce a reference state from an error state when `Error` and `Reference` are
disjoint. -/
theorem no_error_closed_path_to_reference
    (Error Reference : State → Prop)
    (disjoint : ∀ state, Error state → Reference state → False)
    (ops : List (State → State))
    (allPreserve : ∀ op ∈ ops, PreservesError Error op)
    (start : State)
    (startError : Error start) :
    ¬ Reference (applyOps ops start) := by
  intro resultReference
  exact disjoint
    (applyOps ops start)
    (applyOps_preserves_error Error ops allPreserve start startError)
    resultReference

end T1Kernel
