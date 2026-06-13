import T1Kernel.StepExternality

/-!
# Step Reception

Theorem lane: FORMAL skeleton.

This module attaches targeted reception to a localized external step.

`StepExternality` proves that the external operation in a restoration path can
be localized as `before ++ op :: after`. Here we add the minimal reception layer:
if that localized operation is received through the actual/reference target,
then the receiving state is actually open to that target. If actual openness is
absent, the localized external step cannot be received through the actual target.

This still does not identify the external step with Christ, incarnation, cross,
or any NT fulfillment claim.
-/

namespace T1Kernel

variable {State : Type u}
variable {Target : Type v}

/-- A localized external step packaged with a state that receives that exact
operation through the actual/reference target. -/
def ExternalStepReceivedActual
    (Error : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (ops : List (State -> State))
    (receiveState : State) : Prop :=
  exists before op after,
    ops = before ++ op :: after /\
      IsExternalToError Error op /\
      ReceivesActual O actual op receiveState

/-- A received localized external step entails the ordinary localized
external-step predicate. -/
theorem received_actual_step_implies_external_step
    (Error : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (ops : List (State -> State))
    (receiveState : State)
    (hReceived : ExternalStepReceivedActual Error O actual ops receiveState) :
    ContainsExternalStep Error ops := by
  rcases hReceived with ⟨before, op, after, hEq, hExternal, _hReceive⟩
  exact ⟨before, op, after, hEq, hExternal⟩

/-- A received localized external step entails actual/reference openness in the
receiving state. -/
theorem received_actual_step_implies_actual_openness
    (Error : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (ops : List (State -> State))
    (receiveState : State)
    (hReceived : ExternalStepReceivedActual Error O actual ops receiveState) :
    O receiveState actual := by
  rcases hReceived with ⟨_before, op, _after, _hEq, _hExternal, hReceive⟩
  exact receives_actual_implies_actual_openness O actual op receiveState hReceive

/-- If actual/reference openness is absent, no localized external step can be
received through the actual/reference target at that state. -/
theorem no_actual_openness_blocks_received_external_step
    (Error : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (ops : List (State -> State))
    (receiveState : State)
    (hNotActual : Not (O receiveState actual)) :
    Not (ExternalStepReceivedActual Error O actual ops receiveState) := by
  intro hReceived
  exact hNotActual
    (received_actual_step_implies_actual_openness
      Error O actual ops receiveState hReceived)

/-- If a finite restoration path has a localized external step that is received
as actual/reference-targeted, then both externality and actual openness hold.

The restoration premises are retained so later modules can replace this skeleton
with a tighter step-indexed transition model without changing the downstream
shape. -/
theorem restoration_with_received_step_yields_externality_and_actual_openness
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (_disjoint : forall state, Error state -> Reference state -> False)
    (ops : List (State -> State))
    (start receiveState : State)
    (_startError : Error start)
    (_endsReference : Reference (applyOps ops start))
    (hReceived : ExternalStepReceivedActual Error O actual ops receiveState) :
    ContainsExternalStep Error ops /\ O receiveState actual := by
  constructor
  · exact received_actual_step_implies_external_step
      Error O actual ops receiveState hReceived
  · exact received_actual_step_implies_actual_openness
      Error O actual ops receiveState hReceived

end T1Kernel
