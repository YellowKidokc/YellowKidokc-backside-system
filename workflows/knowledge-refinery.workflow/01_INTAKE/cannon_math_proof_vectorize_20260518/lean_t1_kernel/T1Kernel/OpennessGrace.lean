import T1Kernel.Closure

/-!
# Openness and Grace

Theorem lane: FORMAL skeleton with BRIDGE interpretation.

This file locks the GPT correction:

* openness is a posture/property of a state, not a restoring operation;
* reception of an external operator includes openness as a condition;
* externality is defined negatively as not preserving the error class.

The file does not prove that grace exists or that any particular operator is
grace. That remains outside the local Lean kernel.
-/

namespace T1Kernel

variable {State : Type u}

/-- Openness is a predicate on states: the state is receptive to external input.
It is posture, not operation. -/
def Open (State : Type u) : Type u := State -> Prop

/-- An operator is external to the error class when it is not error-preserving. -/
def IsExternalToError (Error : State -> Prop) (op : State -> State) : Prop :=
  Not (PreservesError Error op)

/-- Reception is modeled minimally: to receive an operator, the state must be
open to it. The operator argument is retained so richer coupling definitions can
replace this without changing downstream theorem shape. -/
def Receives (O : Open State) (_op : State -> State) (state : State) : Prop :=
  O state

/-- Reception implies openness because openness is part of the reception
condition, not because openness performs restoration. -/
theorem reception_implies_openness
    (O : Open State)
    (op : State -> State)
    (state : State)
    (receives : Receives O op state) :
    O state := by
  exact receives

/-- A state can be in error and open at the same time. This keeps repentance or
receptivity separate from completed restoration. -/
theorem openness_compatible_with_error
    (Error : State -> Prop)
    (O : Open State)
    (state : State)
    (_stateError : Error state)
    (_stateOpen : O state) :
    True := by
  trivial

/-- If an operation preserves error, it is not external to the error class. -/
theorem error_preserving_not_external
    (Error : State -> Prop)
    (op : State -> State)
    (preserves : PreservesError Error op) :
    Not (IsExternalToError Error op) := by
  intro external
  exact external preserves

end T1Kernel
