# Backside Workflow Spine Draft

Date: 2026-05-22
Scope: `\\dlowenas\brain\Backside`
Goal: name the workflow lanes so AI partners can refine process steps without redesigning the whole system every session.

## What The Live Tree Already Says

- `\Backside\_models` is becoming the substrate layer.
- `\Backside\stations` contains atomic actions plus a few misplaced app-sized bundles.
- `\Backside\apps` is the right home for orchestrators.
- `\Backside\workflows` already exists, but it mixes intake jobs, production jobs, and legacy experiments.

Working rule:

`WORKFLOW -> APP or STATION -> MODEL/FRONT DOOR -> OUTPUT -> GATE -> NEXT`

This means:

- workflows are routes
- stations are atomic operations
- apps are multi-step orchestrators
- models are substrate workers

## Structural Holds

- `math-layer.station` is not a station in the strict sense. It is app-shaped and should be treated as a workflow/app dependency.
- `paper-proof-grader.workflow` is already a workflow lane, but it behaves like a deep orchestrator and should likely call stations rather than own all logic forever.
- `knowledge-refinery.workflow` is the conductor lane, not the only workflow.

## Proposed Canonical Workflow Families

These are the high-value named lanes to stabilize first.

### 01 Lossless Layer

Purpose: preserve source material and extract maximum structure before compression or interpretation.

Input:
- raw HTML
- Markdown
- PDF
- audio/video
- link drops

Core actions:
- fetch
- transcribe
- convert
- preserve originals
- write canonical text
- emit manifests

Likely dependencies:
- `youtube-fetch.station`
- `whisper-transcribe.station`
- document conversion helpers
- `link-pull.workflow`
- `harvest-links.workflow`

Primary output:
- canonical text plus preserved original plus manifest

Why it matters:
- this is the anti-slop layer
- if this layer is weak, every later summary and grading lane inherits distortion

### 02 Summary Layer

Purpose: generate faithful reduction without destroying traceability.

Core actions:
- lossless summary
- overview generation
- section compression
- digest generation
- handoff generation

Likely dependencies:
- summarizer model/front door
- `overview_generator`
- `session-handoff-drop.workflow`

Primary output:
- readable summaries
- machine summaries
- handoff digests

Gate:
- summaries must point back to source chunks or section spans

### 03 Contradiction Layer

Purpose: test internal coherence, claim conflict, and evidence tension.

Core actions:
- claim extraction
- NLI pass
- contradiction pass
- entailment/neutral/contradiction scoring
- review queue for hard conflicts

Likely dependencies:
- `claim-extractor.station`
- `deberta-runner.station`
- `sbert-embedder.station`
- contradiction-focused model wrappers

Primary output:
- contradiction ledger
- claim support matrix
- review-needed flags

Gate:
- hard contradictions route to review before publication-grade outputs

### 04 Math Layer

Purpose: translate equations and symbolic expressions into readable structure without losing formal meaning.

Core actions:
- parse math
- translate math into plain English
- preserve raw math
- prepare article-safe render output
- hand clean math text to TTS and HTML lanes

Likely dependency:
- `Math-Translation-Layer` app, not `math-layer.station` as an atomic station

Primary output:
- translated equations
- math-aware HTML fragments
- TTS-safe math narration

Gate:
- output must preserve factor order and canonical variable meaning

### 05 Claim Layer

Purpose: pull claims, classify them, and make them routable.

Core actions:
- extract claims
- dedup claims
- classify claim type
- map claim to evidence needs

Likely dependencies:
- `claim-extractor.station`
- `7q-classifier.station`
- embedder/NLI substrate

Primary output:
- claim packets
- claim registry rows
- downstream routes for rigor, canon, or publication

### 06 Rigor Layer

Purpose: pressure-test a document before it becomes a published artifact.

Core actions:
- 7Q forward
- 7Q reverse
- evidence sufficiency
- contradiction scan
- formal/theoretical fit
- readiness score

Likely dependencies:
- `paper-proof-grader.workflow`
- `7q-classifier.station`
- contradiction layer
- fact verification layer

Primary output:
- rigor report
- readiness score
- kill conditions
- publication recommendations

### 07 Canon Layer

Purpose: compare outputs to locked framework structures and canonical definitions.

Core actions:
- canon term alignment
- Master Equation checks
- operator checks
- Trinity / fruits / law-family comparison

Likely dependencies:
- `master-equation-canon.station`
- `operators-canon.station`
- `trinity-canon.station`
- `fruits-spirit-canon.station`
- `axioms.workflow`

Primary output:
- canon alignment report
- drift flags
- candidate canon notes

### 08 Brain Layer

Purpose: route accepted material into Brain-facing structures.

Core actions:
- semantic snapshot
- Obsidian-ready note generation
- graph payload generation
- export to Brain map / Postgres / vault surfaces

Likely dependencies:
- `semantic-snapshot.workflow`
- `brain-map.station`
- `open-brain-map.station`
- `postgres-sync.station`
- `chi-tagging.workflow`

Primary output:
- vault notes
- graph entities
- database sync payloads

### 09 Publication Layer

Purpose: produce the final human-facing article or page with the fewest manual touches possible.

Core actions:
- combine source, summary, claims, math, and rigor outputs
- generate page sections
- preserve citations and traceability
- hand final text into HTML template system

Likely dependencies:
- `first-article.workflow`
- `ai-portal-generator.workflow`
- `Math-Translation-Layer` app
- summary layer
- rigor layer

Primary output:
- article-ready Markdown
- HTML-ready content packets
- portal/page payloads

This is the layer that should minimize human labor outside the final article craft pass.

## Recommended Spine For Article Production

If the real goal is "do as little as possible besides write the article on the HTML," the main production route should be:

1. `Lossless Layer`
2. `Claim Layer`
3. `Summary Layer`
4. `Contradiction Layer`
5. `Math Layer`
6. `Rigor Layer`
7. `Brain Layer`
8. `Publication Layer`

That ordering is better than leading with summary because summaries made before claim and contradiction extraction tend to wash out the structure you later need.

## Existing Workflow Names Worth Keeping

- `knowledge-refinery.workflow` = conductor / router
- `paper-proof-grader.workflow` = rigor-grade lane
- `semantic-snapshot.workflow` = brain export lane
- `first-article.workflow` = publication assembly lane
- `chi-tagging.workflow` = metadata/classification lane
- `session-handoff-drop.workflow` = session memory lane

## Existing Names That Probably Need Promotion Or Reclassification

- `math-layer.station` -> move conceptually to app lane
- `Paper-Grader-NLP-API-03-Axiom-main` -> legacy app package, probably reference material
- `paper-intelligence-suite-python` -> app lane, likely a better long-term dependency than a station-shaped bundle

## Minimal Next Build

To give multiple AI partners a stable target, the next step should not be "build everything." It should be:

1. Create one workflow registry doc that lists the canonical workflow names above.
2. Mark each as `active`, `draft`, or `legacy`.
3. Map each workflow to the stations and apps it is allowed to call.
4. Start with one production spine: `Lossless -> Claim -> Summary -> Contradiction -> Math -> Rigor -> Publication`.

## Suggested Statuses Right Now

- `Lossless Layer` = active target
- `Summary Layer` = active target
- `Contradiction Layer` = active target
- `Math Layer` = active target
- `Claim Layer` = active target
- `Rigor Layer` = active target
- `Canon Layer` = draft target
- `Brain Layer` = active target
- `Publication Layer` = active target

## Bottom Line

The clean model is not "one giant workflow." It is:

- conductor workflow
- a small set of named workflow lanes
- each lane calling stations and apps
- stations calling front doors
- front doors calling models

That gives you something swarmable by other AI partners without letting every partner redefine the architecture on entry.
