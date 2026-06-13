import T1Kernel.OpennessGrace

/-!
# Targeted Openness

Theorem lane: FORMAL skeleton with BRIDGE interpretation.

This file locks the "Lord Lord" / false-vacuum correction:

* openness must have a target;
* openness to some target is not the same as openness to the reference target;
* grace-coupling is modeled as reception through openness to the actual target.

This does not prove that any concrete target is Christ, self-image, religious
identity, or a counterfeit. It only prevents untargeted openness from being
silently treated as reference-coupling.
-/

namespace T1Kernel

variable {State : Type u}
variable {Target : Type v}

/-- Targeted openness: a state is open to a specific target. -/
def OpenTo (State : Type u) (Target : Type v) : Type (max u v) :=
  State -> Target -> Prop

/-- Openness to a named target induces an ordinary untargeted `Open` predicate
by fixing the target. -/
def OpenTo.asOpen (O : OpenTo State Target) (target : Target) : Open State :=
  fun state => O state target

/-- Untargeted openness means the state is open to at least one target. -/
def OpenToAny (O : OpenTo State Target) (state : State) : Prop :=
  exists target, O state target

/-- Restorative reception is reception through openness to the actual/reference
target. -/
def ReceivesActual
    (O : OpenTo State Target)
    (actual : Target)
    (op : State -> State)
    (state : State) : Prop :=
  Receives (OpenTo.asOpen O actual) op state

/-- Openness to the actual target entails untargeted openness. -/
theorem actual_openness_implies_open_to_any
    (O : OpenTo State Target)
    (actual : Target)
    (state : State)
    (hActual : O state actual) :
    OpenToAny O state := by
  exact ⟨actual, hActual⟩

/-- Openness to a counterfeit/false target also entails untargeted openness.
This is why untargeted openness is too weak to classify restoration. -/
theorem false_openness_implies_open_to_any
    (O : OpenTo State Target)
    (falseTarget : Target)
    (state : State)
    (hFalse : O state falseTarget) :
    OpenToAny O state := by
  exact ⟨falseTarget, hFalse⟩

/-- Receiving through the actual target implies openness to the actual target. -/
theorem receives_actual_implies_actual_openness
    (O : OpenTo State Target)
    (actual : Target)
    (op : State -> State)
    (state : State)
    (hReceive : ReceivesActual O actual op state) :
    O state actual := by
  exact reception_implies_openness (OpenTo.asOpen O actual) op state hReceive

/-- If actual openness is absent, openness to a false target is not enough to
receive through the actual target. -/
theorem false_openness_not_enough_for_actual_reception
    (O : OpenTo State Target)
    (actual falseTarget : Target)
    (op : State -> State)
    (state : State)
    (_hFalse : O state falseTarget)
    (hNotActual : Not (O state actual)) :
    Not (ReceivesActual O actual op state) := by
  intro hReceive
  exact hNotActual (receives_actual_implies_actual_openness O actual op state hReceive)

/-- If openness to the false target excludes openness to the actual target, then
false-target openness cannot serve as actual reception. -/
theorem exclusive_false_target_blocks_actual_reception
    (O : OpenTo State Target)
    (actual falseTarget : Target)
    (op : State -> State)
    (state : State)
    (exclusive : O state falseTarget -> Not (O state actual))
    (hFalse : O state falseTarget) :
    Not (ReceivesActual O actual op state) := by
  exact false_openness_not_enough_for_actual_reception
    O actual falseTarget op state hFalse (exclusive hFalse)

/-- Untargeted openness cannot by itself produce actual reception unless the
actual target is supplied as an additional premise. -/
theorem actual_openness_suffices_for_actual_reception
    (O : OpenTo State Target)
    (actual : Target)
    (op : State -> State)
    (state : State)
    (hActual : O state actual) :
    ReceivesActual O actual op state := by
  exact hActual

end T1Kernel
