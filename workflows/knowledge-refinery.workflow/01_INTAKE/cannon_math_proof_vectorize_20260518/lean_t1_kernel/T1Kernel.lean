import T1Kernel.ReferenceState
import T1Kernel.Closure
import T1Kernel.TraceCoupling
import T1Kernel.OpennessGrace
import T1Kernel.TargetedOpenness
import T1Kernel.ExternalOperator
import T1Kernel.StepExternality
import T1Kernel.StepReception
import T1Kernel.NecessaryConditions
import T1Kernel.VariableNecessity
import T1Kernel.RestorationProfile
import T1Kernel.ContinuityIdentity
import T1Kernel.RivalModels
import T1Kernel.RivalModelInstances
import T1Kernel.SignInvariance
import T1Kernel.JusticeMercyTransform
import T1Kernel.FormalLoveBoundary

/-!
# T1Kernel — Old Testament Diagnostic Chain

Formal Lean 4 kernel for the T1 closure theorem and the first corollary layer.

## Kernel Run Order

1. `ReferenceState` — foundational predicate vocabulary.
2. `Closure` — proven T1: error-closed operations cannot reach reference.
3. `TraceCoupling` — proven dependency/coupling restatement of T1.
4. `OpennessGrace` — proven posture vs. operation distinction.
5. `TargetedOpenness` — proven actual-vs-false openness distinction.
6. `ExternalOperator` — proven restoration path requires an external operation.
7. `StepExternality` — proven external operation can be path-localized.
8. `StepReception` — proven localized received step entails actual openness.
9. `NecessaryConditions` — proven logical product-form gate under joint necessity.
10. `VariableNecessity` — proven gate blocking candidate-variable smuggling.
11. `RestorationProfile` — bundled minimum restoration skeleton.
12. `ContinuityIdentity` — proven continuity vs replacement identity gate.
13. `RivalModels` — minimal formal failure patterns for rival proposals.
14. `RivalModelInstances` — named-instance gates only under explicit premises.
15. `SignInvariance` — proven sign/orientation corollaries under explicit premises.
16. `JusticeMercyTransform` — proven weak J/M/T incompatibility for self-generated operators.

17. `FormalLoveBoundary` — proven boundary: modeled effects do not exhaust an
    uncontainable source.

## Boundary Discipline

Promoted to theorem: local formal skeletons only.

Blocked from theorem status: Christianity uniqueness, Trinity, incarnation,
atonement uniqueness, resurrection, hiddenness, and soul speculation.

Symbol lock:

* `C` = coherence state
* `chi` = integrated coherence
* `S` = sin/decoherence
* `G` = external restoration
* `O` = openness/posture
* `alpha` = covering coefficient

`C = chi = Christ` collapse is prohibited unless explicitly marked as narrative
bridge.
-/
