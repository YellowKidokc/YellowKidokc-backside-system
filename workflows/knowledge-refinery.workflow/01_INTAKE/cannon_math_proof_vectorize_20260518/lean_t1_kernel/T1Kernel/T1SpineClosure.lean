/-!
# T1 Spine Closure

**Theorem Lane:** FORMAL — local structural skeleton only.

This file formalizes the T1 closure theorem:

> If `Error` and `Reference` are disjoint predicates on one state space, and every
> self-generated operation preserves `Error`, then any finite sequence of those
> operations applied to an error state remains in `Error` and therefore cannot be
> `Reference`.

**What this proves:** A reference state is not constructible from error states
via error-preserving operations alone. The gap is real.

**What this does NOT prove:** Christianity, theology, product form, mediator
uniqueness, physics bridge, or any empirical claim. Those are intentionally
outside T1.

**Lean 4 Status:** ✅ PROVEN — compiles without `sorry`.
-/

namespace T1Kernel

variable {State : Type u}

/-- An operation preserves the error class when it maps every error state to an
error state. This is the formal definition of a "self-generated" operation in
the error class: it only uses information already present in the error state. -/
def PreservesError (Error : State → Prop) (op : State → State) : Prop :=
  ∀ state, Error state → Error (op state)

/-- Apply a finite list of operations from left to right. -/
def applyOps (ops : List (State → State)) (start : State) : State :=
  ops.foldl (fun state op => op state) start

/-- If every operation in a finite list preserves `Error`, then their finite
composition preserves `Error`. This is the inductive spine of the T1 argument. -/
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

/-- **T1 Closure Theorem**: No finite composition of error-preserving operations
can produce a reference state from an error state when `Error` and `Reference`
are disjoint.

Corollary: A reference state cannot be reached by self-generated operations alone.
Something external to the error class is required. -/
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
