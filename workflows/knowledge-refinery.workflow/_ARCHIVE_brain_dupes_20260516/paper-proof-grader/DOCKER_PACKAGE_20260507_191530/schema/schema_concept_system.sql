-- ARTICLE CONCEPT SYSTEM - Four-layer derivation chain
-- Public/docker copy. Load into Postgres when you want the concept ledger.

CREATE TABLE IF NOT EXISTS article_concept_fingerprints (
    id SERIAL PRIMARY KEY,
    paper_id TEXT NOT NULL,
    series TEXT,
    title TEXT,
    concept TEXT NOT NULL,
    surface_terms TEXT[],
    concept_role TEXT,
    math_role TEXT,
    theology_role TEXT,
    physics_role TEXT,
    confidence NUMERIC(4,3),
    nearest_equations TEXT[],
    nearest_claims TEXT[],
    linked_articles TEXT[],
    notes TEXT,
    auto_generated BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(paper_id, concept)
);

CREATE TABLE IF NOT EXISTS concept_evidence (
    id SERIAL PRIMARY KEY,
    fingerprint_id INT REFERENCES article_concept_fingerprints(id) ON DELETE CASCADE,
    paper_id TEXT NOT NULL,
    concept TEXT NOT NULL,
    metric_name TEXT NOT NULL,
    metric_value NUMERIC(5,3),
    metric_weight NUMERIC(4,3),
    metric_detail TEXT,
    raw_evidence TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS article_concept_links (
    id SERIAL PRIMARY KEY,
    source_paper TEXT NOT NULL,
    target_paper TEXT NOT NULL,
    shared_concept TEXT,
    shared_role TEXT,
    correlation_score NUMERIC(4,3),
    why_linked TEXT,
    auto_generated BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(source_paper, target_paper, shared_concept)
);

CREATE TABLE IF NOT EXISTS concept_axiom_links (
    id SERIAL PRIMARY KEY,
    concept TEXT NOT NULL,
    concept_role TEXT NOT NULL,
    axiom_id TEXT,
    technical_node_ids INT[],
    dependency_ids INT[],
    falsification_ids INT[],
    law_number INT,
    law_side TEXT,
    mapping_confidence NUMERIC(4,3),
    notes TEXT,
    auto_generated BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(concept, concept_role, axiom_id)
);

CREATE INDEX IF NOT EXISTS idx_fingerprint_paper ON article_concept_fingerprints(paper_id);
CREATE INDEX IF NOT EXISTS idx_fingerprint_concept ON article_concept_fingerprints(concept);
CREATE INDEX IF NOT EXISTS idx_fingerprint_role ON article_concept_fingerprints(concept_role);
CREATE INDEX IF NOT EXISTS idx_fingerprint_series ON article_concept_fingerprints(series);
CREATE INDEX IF NOT EXISTS idx_evidence_paper ON concept_evidence(paper_id);
CREATE INDEX IF NOT EXISTS idx_evidence_concept ON concept_evidence(concept);
CREATE INDEX IF NOT EXISTS idx_evidence_metric ON concept_evidence(metric_name);
CREATE INDEX IF NOT EXISTS idx_links_source ON article_concept_links(source_paper);
CREATE INDEX IF NOT EXISTS idx_links_target ON article_concept_links(target_paper);
CREATE INDEX IF NOT EXISTS idx_links_concept ON article_concept_links(shared_concept);
CREATE INDEX IF NOT EXISTS idx_axiom_concept ON concept_axiom_links(concept);
CREATE INDEX IF NOT EXISTS idx_axiom_role ON concept_axiom_links(concept_role);
CREATE INDEX IF NOT EXISTS idx_axiom_law ON concept_axiom_links(law_number);

CREATE OR REPLACE VIEW v_fingerprint_summary AS
SELECT
    f.paper_id,
    f.series,
    f.title,
    f.concept,
    f.concept_role,
    f.math_role,
    f.theology_role,
    f.physics_role,
    f.confidence,
    f.auto_generated,
    COUNT(e.id) AS evidence_count,
    array_agg(DISTINCT e.metric_name) AS metrics_used
FROM article_concept_fingerprints f
LEFT JOIN concept_evidence e ON e.fingerprint_id = f.id
GROUP BY f.id;

CREATE OR REPLACE VIEW v_paper_concept_rollup AS
SELECT
    paper_id,
    series,
    title,
    COUNT(*) AS concept_count,
    ROUND(AVG(confidence)::numeric, 3) AS avg_confidence,
    SUM(CASE WHEN confidence >= 0.7 THEN 1 ELSE 0 END) AS strong_concepts,
    SUM(CASE WHEN confidence < 0.4 THEN 1 ELSE 0 END) AS weak_concepts
FROM article_concept_fingerprints
GROUP BY paper_id, series, title;
