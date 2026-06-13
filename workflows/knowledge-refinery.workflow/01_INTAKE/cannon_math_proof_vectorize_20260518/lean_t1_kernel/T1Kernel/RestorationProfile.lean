import T1Kernel.StepReception
import T1Kernel.NecessaryConditions
import T1Kernel.JusticeMercyTransform

/-!
# Restoration Profile

Theorem lane: FORMAL specification layer.

This module bundles the already-proven T1 corollaries into a minimum restoration
profile:

* the path has a localized external step;
* that step is received through actual/reference-targeted openness;
* the terminal/reference state satisfies every listed necessary condition;
* the selected operation can be checked against the weak J/M/T specification.

This is still not NT fulfillment. It does not identify the operator, prove
mediator uniqueness, or prove incarnation/cross/resurrection.
-/

namespace T1Kernel

variable {State : Type u}
variable {Target : Type v}

/-- A bundled local restoration profile for a finite path. -/
structure RestorationProfile
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State) : Type (max u v) where
  startsInError : Error start
  terminalIsPathResult : terminal = applyOps ops start
  terminalReference : Reference terminal
  receivedStep : ExternalStepReceivedActual Error O actual ops receiveState
  allConditionsNecessary :
    forall condition, condition ∈ Conditions -> IsNecessary Reference condition
  justiceMercyTransformWitness : State -> State
  justice : JusticePreserving Error justiceMercyTransformWitness
  mercy : MercyEnacting Error justiceMercyTransformWitness
  transform : Transforming Error Reference justiceMercyTransformWitness

/-- The profile entails a localized external step. -/
theorem profile_entails_external_step
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState) :
    ContainsExternalStep Error ops := by
  exact received_actual_step_implies_external_step
    Error O actual ops receiveState profile.receivedStep

/-- The profile entails actual/reference openness in the receiving state. -/
theorem profile_entails_actual_openness
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState) :
    O receiveState actual := by
  exact received_actual_step_implies_actual_openness
    Error O actual ops receiveState profile.receivedStep

/-- The profile entails integrated coherence of the terminal state over the
listed necessary conditions. -/
theorem profile_entails_integrated_coherence
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState) :
    IntegratedCoherence Conditions terminal := by
  exact product_gate_requires_joint_necessity
    Reference Conditions profile.allConditionsNecessary terminal profile.terminalReference

/-- The profile entails the weak J/M/T triple for its selected witness operator. -/
theorem profile_entails_jmt
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState) :
    JusticePreserving Error profile.justiceMercyTransformWitness /\
      MercyEnacting Error profile.justiceMercyTransformWitness /\
      Transforming Error Reference profile.justiceMercyTransformWitness := by
  exact ⟨profile.justice, profile.mercy, profile.transform⟩

/-- If a profile exists and the J/M/T witness were self-generated/error-preserving,
it would contradict the weak J/M/T incompatibility theorem. -/
theorem profile_jmt_witness_not_self_generated
    (Error Reference : State -> Prop)
    (O : OpenTo State Target)
    (actual : Target)
    (Conditions : List (State -> Prop))
    (ops : List (State -> State))
    (start terminal receiveState : State)
    (profile : RestorationProfile Error Reference O actual Conditions ops start terminal receiveState) :
    Not (PreservesError Error profile.justiceMercyTransformWitness) := by
  intro preserves
  have hJMT :
      JusticePreserving Error profile.justiceMercyTransformWitness /\
        MercyEnacting Error profile.justiceMercyTransformWitness /\
        Transforming Error Reference profile.justiceMercyTransformWitness :=
    profile_entails_jmt Error Reference O actual Conditions ops start terminal receiveState profile
  exact self_generated_cannot_satisfy_all_three
    Error Reference profile.justiceMercyTransformWitness preserves hJMT

end T1Kernel
