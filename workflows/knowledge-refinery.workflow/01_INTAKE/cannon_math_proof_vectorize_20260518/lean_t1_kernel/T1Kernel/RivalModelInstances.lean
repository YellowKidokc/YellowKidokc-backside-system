import T1Kernel.RivalModels

/-!
# Named Rival Model Instances

Theorem lane: FORMAL skeleton.

This module is the safe bridge between generic rival failure gates and named
comparative models.

The discipline is strict:

* a name or label proves nothing;
* a named rival can inherit a failure theorem only after its exact formal
  premise is supplied;
* the theorem reports the failure of that supplied premise pattern, not the
  defeat of a whole religion, tradition, or historical theology.

This lets the framework say: "If a named proposal is modeled as self-repair,
decree-only, replacement, false-openness, or necessary-condition failure, then
the corresponding formal gate fires."
-/

namespace T1Kernel

variable {State : Type u}
variable {Identity : Type v}
variable {Target : Type w}

/-- A label-only rival record. This has no theorem power by itself. -/
structure RivalLabel where
  label : String

/-- A named self-repair rival: the label is paired with the explicit premise
that the operation preserves the error class. -/
structure NamedSelfRepairInstance (State : Type u) where
  label : RivalLabel
  Error : State -> Prop
  Reference : State -> Prop
  op : State -> State
  premise : SelfRepairRival Error op

/-- A named decree-only rival: the label is paired with the explicit premise
that the decree leaves the error class intact. -/
structure NamedDecreeOnlyInstance (State : Type u) where
  label : RivalLabel
  Error : State -> Prop
  Reference : State -> Prop
  op : State -> State
  premise : DecreeOnlyRival Error op

/-- A named replacement rival: the label is paired with the explicit premise
that the terminal state does not preserve the starting identity. -/
structure NamedReplacementInstance (State : Type u) (Identity : Type v) where
  label : RivalLabel
  identityOf : IdentityOf State Identity
  ops : List (State -> State)
  start : State
  terminal : State
  premise : ReplacementRival identityOf ops start terminal

/-- A named false-openness rival: the label is paired with the explicit
premise that the state is open to a non-actual target while lacking actual
target openness. -/
structure NamedFalseOpennessInstance (State : Type u) (Target : Type v) where
  label : RivalLabel
  O : OpenTo State Target
  actual : Target
  falseTarget : Target
  op : State -> State
  state : State
  premise : FalseOpennessRival O actual falseTarget state

/-- A named necessary-condition failure rival: the label is paired with the
explicit premise that at least one listed condition fails. -/
structure NamedNecessaryConditionFailureInstance (State : Type u) where
  label : RivalLabel
  Conditions : List (State -> Prop)
  state : State
  premise : NecessaryConditionFailure Conditions state

/-- Named self-repair instances fail weak mercy under their supplied premise. -/
theorem named_self_repair_fails_mercy
    (rival : NamedSelfRepairInstance State) :
    Not (MercyEnacting rival.Error rival.op) := by
  exact self_repair_rival_fails_mercy
    rival.Error rival.op rival.premise

/-- Named self-repair instances fail weak J/M/T under their supplied premise. -/
theorem named_self_repair_fails_jmt
    (rival : NamedSelfRepairInstance State) :
    Not
      (JusticePreserving rival.Error rival.op /\
        MercyEnacting rival.Error rival.op /\
        Transforming rival.Error rival.Reference rival.op) := by
  exact self_repair_rival_fails_jmt
    rival.Error rival.Reference rival.op rival.premise

/-- Named decree-only instances fail weak mercy under their supplied premise. -/
theorem named_decree_only_fails_mercy
    (rival : NamedDecreeOnlyInstance State) :
    Not (MercyEnacting rival.Error rival.op) := by
  exact decree_only_rival_fails_mercy
    rival.Error rival.op rival.premise

/-- Named decree-only instances fail weak J/M/T under their supplied premise. -/
theorem named_decree_only_fails_jmt
    (rival : NamedDecreeOnlyInstance State) :
    Not
      (JusticePreserving rival.Error rival.op /\
        MercyEnacting rival.Error rival.op /\
        Transforming rival.Error rival.Reference rival.op) := by
  exact decree_only_rival_fails_jmt
    rival.Error rival.Reference rival.op rival.premise

/-- Named replacement instances contain an identity-replacing operation under
their supplied premise. -/
theorem named_replacement_contains_identity_replacement
    (rival : NamedReplacementInstance State Identity) :
    ContainsIdentityReplacingOp rival.identityOf rival.ops := by
  exact replacement_rival_contains_identity_replacement
    rival.identityOf rival.ops rival.start rival.terminal rival.premise

/-- Named replacement instances fail identity continuity under their supplied
premise. -/
theorem named_replacement_fails_identity_continuity
    (rival : NamedReplacementInstance State Identity) :
    Not (rival.identityOf rival.terminal = rival.identityOf rival.start) := by
  exact replacement_rival_fails_identity_continuity
    rival.identityOf rival.ops rival.start rival.terminal rival.premise

/-- Named false-openness instances cannot receive through the actual target
under their supplied premise. -/
theorem named_false_openness_blocks_actual_reception
    (rival : NamedFalseOpennessInstance State Target) :
    Not (ReceivesActual rival.O rival.actual rival.op rival.state) := by
  exact false_openness_rival_blocks_actual_reception
    rival.O rival.actual rival.falseTarget rival.op rival.state rival.premise

/-- Named necessary-condition failure instances block integrated coherence under
their supplied premise. -/
theorem named_necessary_condition_failure_blocks_integrated_coherence
    (rival : NamedNecessaryConditionFailureInstance State) :
    Not (IntegratedCoherence rival.Conditions rival.state) := by
  exact necessary_condition_failure_blocks_integrated_coherence
    rival.Conditions rival.state rival.premise

end T1Kernel
