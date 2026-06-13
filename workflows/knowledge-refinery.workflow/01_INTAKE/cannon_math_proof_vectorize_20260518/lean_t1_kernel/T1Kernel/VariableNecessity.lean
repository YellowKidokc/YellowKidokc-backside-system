import T1Kernel.NecessaryConditions

/-!
# Variable Necessity Gate

Theorem lane: FORMAL skeleton.

This module protects the product-form layer from smuggling candidate variables
into the integrated-coherence gate.

It distinguishes three statuses:

* `proven`: a variable has a theorem-level necessity proof;
* `assumed`: a variable has an explicit premise supplied by a domain
  model;
* `candidate`: a variable is proposed but not yet usable in the product gate.

Only proven or explicitly assumed variables can feed the joint-necessity theorem.
This file does not prove that any named theological variable is necessary.
-/

namespace T1Kernel

variable {State : Type u}

/-- Status marker for a proposed variable in the product-form layer. -/
inductive NecessityStatus where
  | proven
  | assumed
  | candidate
deriving Repr, DecidableEq

/-- A named variable candidate consists of a human-readable label, a state
condition, and a status marker. -/
structure VariableSpec (State : Type u) where
  label : String
  condition : State -> Prop
  status : NecessityStatus

/-- The condition list extracted from variable specs. -/
def VariableConditions (variables : List (VariableSpec State)) : List (State -> Prop) :=
  variables.map VariableSpec.condition

/-- The variable is theorem-level proven necessary. -/
def ProvenNecessary
    (Reference : State -> Prop)
    (spec : VariableSpec State) : Prop :=
  spec.status = NecessityStatus.proven /\
    IsNecessary Reference spec.condition

/-- The variable is explicitly assumed necessary by a domain model. This is not
a Lean declaration; it is an ordinary premise that must be supplied wherever the
module is used. -/
def AssumedNecessary
    (Reference : State -> Prop)
    (spec : VariableSpec State) : Prop :=
  spec.status = NecessityStatus.assumed /\
    IsNecessary Reference spec.condition

/-- The variable is only a candidate and cannot yet enter the product gate. -/
def CandidateNecessary (spec : VariableSpec State) : Prop :=
  spec.status = NecessityStatus.candidate

/-- Usable necessity evidence is either theorem-level proof or an explicit
domain-model assumption. Candidate status alone is not usable evidence. -/
def HasUsableNecessity
    (Reference : State -> Prop)
    (spec : VariableSpec State) : Prop :=
  ProvenNecessary Reference spec \/ AssumedNecessary Reference spec

/-- Usable variable evidence entails ordinary `IsNecessary`. -/
theorem usable_necessity_entails_necessary
    (Reference : State -> Prop)
    (spec : VariableSpec State)
    (evidence : HasUsableNecessity Reference spec) :
    IsNecessary Reference spec.condition := by
  rcases evidence with provenEvidence | assumedEvidence
  · exact provenEvidence.right
  · exact assumedEvidence.right

/-- Candidate status is not usable necessity evidence. -/
theorem candidate_not_usable
    (Reference : State -> Prop)
    (spec : VariableSpec State)
    (candidate : CandidateNecessary spec) :
    Not (HasUsableNecessity Reference spec) := by
  intro evidence
  rcases evidence with provenEvidence | assumedEvidence
  · have impossibleStatus :
        NecessityStatus.candidate = NecessityStatus.proven := by
      exact candidate.symm.trans provenEvidence.left
    cases impossibleStatus
  · have impossibleStatus :
        NecessityStatus.candidate = NecessityStatus.assumed := by
      exact candidate.symm.trans assumedEvidence.left
    cases impossibleStatus

/-- If every listed variable has usable necessity evidence, then every extracted
condition is necessary for the reference predicate. -/
theorem variable_evidence_entails_joint_necessity
    (Reference : State -> Prop)
    (variables : List (VariableSpec State))
    (allEvidence :
      forall spec, spec ∈ variables -> HasUsableNecessity Reference spec) :
    forall condition,
      condition ∈ VariableConditions variables -> IsNecessary Reference condition := by
  intro condition conditionInList
  unfold VariableConditions at conditionInList
  rcases List.mem_map.mp conditionInList with ⟨spec, specInList, conditionEq⟩
  rw [← conditionEq]
  exact usable_necessity_entails_necessary
    Reference spec (allEvidence spec specInList)

/-- Product-gate entry from variables is valid only after every variable has
usable necessity evidence. -/
theorem variable_product_gate
    (Reference : State -> Prop)
    (variables : List (VariableSpec State))
    (allEvidence :
      forall spec, spec ∈ variables -> HasUsableNecessity Reference spec)
    (state : State)
    (stateReference : Reference state) :
    IntegratedCoherence (VariableConditions variables) state := by
  exact product_gate_requires_joint_necessity
    Reference
    (VariableConditions variables)
    (variable_evidence_entails_joint_necessity Reference variables allEvidence)
    state
    stateReference

/-- If one extracted variable condition fails, the variable product gate fails.
This is the logical version of the "one zero kills all" claim, still gated by
the explicit variable list. -/
theorem failed_variable_condition_blocks_product_gate
    (variables : List (VariableSpec State))
    (spec : VariableSpec State)
    (specInList : spec ∈ variables)
    (state : State)
    (conditionFails : Not (spec.condition state)) :
    Not (IntegratedCoherence (VariableConditions variables) state) := by
  have conditionInList : spec.condition ∈ VariableConditions variables := by
    unfold VariableConditions
    exact List.mem_map.mpr ⟨spec, specInList, rfl⟩
  exact null_condition_nullifies_coherence
    (VariableConditions variables)
    spec.condition
    conditionInList
    state
    conditionFails

end T1Kernel
