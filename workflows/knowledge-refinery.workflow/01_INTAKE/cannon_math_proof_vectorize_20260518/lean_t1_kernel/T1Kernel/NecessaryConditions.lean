/-!
# Necessary Conditions and Product-Form Gate

Theorem lane: FORMAL skeleton with BRIDGE interpretation.

This file gates the product-form claim. It proves the binary/logical part:

If integrated coherence is modeled as the conjunction of jointly necessary
conditions, then failure of any listed condition blocks integrated coherence.

It does not prove that any specific theological or moral variable belongs in the
necessary-condition list. That remains a domain-specific bridge claim or a later
module-by-module proof.
-/

namespace T1Kernel

variable {State : Type u}

/-- A condition is necessary for a coherent/reference predicate when that
predicate entails the condition. -/
def IsNecessary (Coherent : State -> Prop) (Condition : State -> Prop) : Prop :=
  forall state, Coherent state -> Condition state

/-- Integrated coherence is the conjunction/intersection of all listed
conditions. This is the logical product gate, not a numeric product yet. -/
def IntegratedCoherence
    (Conditions : List (State -> Prop))
    (state : State) : Prop :=
  forall condition, condition ∈ Conditions -> condition state

/-- Logical zero-gate: if any listed condition fails, integrated coherence
fails. -/
theorem null_condition_nullifies_coherence
    (Conditions : List (State -> Prop))
    (condition : State -> Prop)
    (conditionInList : condition ∈ Conditions)
    (state : State)
    (conditionFails : Not (condition state)) :
    Not (IntegratedCoherence Conditions state) := by
  intro integrated
  exact conditionFails (integrated condition conditionInList)

/-- If every listed condition is necessary for reference/coherence, then
reference entails integrated coherence over the whole list. -/
theorem joint_necessity_entails_integrated_coherence
    (Reference : State -> Prop)
    (Conditions : List (State -> Prop))
    (allNecessary : forall condition, condition ∈ Conditions -> IsNecessary Reference condition) :
    IsNecessary Reference (IntegratedCoherence Conditions) := by
  intro state stateReference condition conditionInList
  exact allNecessary condition conditionInList state stateReference

/-- Total collapse is the existence of at least one failed listed condition. -/
def IsTotalCollapse
    (Conditions : List (State -> Prop))
    (state : State) : Prop :=
  exists condition, condition ∈ Conditions /\ Not (condition state)

/-- Collapse blocks integrated coherence. -/
theorem collapse_implies_not_coherent
    (Conditions : List (State -> Prop))
    (state : State)
    (collapse : IsTotalCollapse Conditions state) :
    Not (IntegratedCoherence Conditions state) := by
  rcases collapse with ⟨condition, conditionInList, conditionFails⟩
  exact null_condition_nullifies_coherence
    Conditions condition conditionInList state conditionFails

/-- A named gate theorem: product-form reasoning is justified only for condition
lists already supplied as jointly necessary. This theorem packages the exact
formal dependency so downstream modules cannot silently assume it. -/
theorem product_gate_requires_joint_necessity
    (Reference : State -> Prop)
    (Conditions : List (State -> Prop))
    (allNecessary : forall condition, condition ∈ Conditions -> IsNecessary Reference condition)
    (state : State)
    (stateReference : Reference state) :
    IntegratedCoherence Conditions state := by
  exact joint_necessity_entails_integrated_coherence
    Reference Conditions allNecessary state stateReference

end T1Kernel
