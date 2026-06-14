"""Canonical Backside spine path contract.

The local repo is the canonical source for engine code, but runtime hot folders
belong under the mounted Backside spine on X:.
"""
from __future__ import annotations

import os
from pathlib import PureWindowsPath

BACKSIDE_ROOT = PureWindowsPath(os.environ.get("BACKSIDE_ROOT", r"X:\Backside"))
STATIONS_ROOT = PureWindowsPath(os.environ.get("BACKSIDE_STATIONS_ROOT", str(BACKSIDE_ROOT / "_Stations")))
WORKFLOWS_ROOT = PureWindowsPath(os.environ.get("BACKSIDE_WORKFLOWS_ROOT", str(BACKSIDE_ROOT / "workflows")))
KNOWLEDGE_GRAPHS_ROOT = PureWindowsPath(os.environ.get("BACKSIDE_KNOWLEDGE_GRAPHS_ROOT", str(BACKSIDE_ROOT / "knowledge-graphs")))
SHARED_ROOT = PureWindowsPath(os.environ.get("BACKSIDE_SHARED_ROOT", str(BACKSIDE_ROOT / "_Shared")))

PIPELINE_RUNTIME_ROOT = WORKFLOWS_ROOT / "pipelines"
PIPELINE_LOG_DIR = PIPELINE_RUNTIME_ROOT / "_LOGS"
PIPELINE_QUEUE_DIR = PIPELINE_RUNTIME_ROOT / "_queue"
PIPELINE_STATE_DIR = PIPELINE_RUNTIME_ROOT / "_state"
PIPELINE_REPORT_DIR = PIPELINE_RUNTIME_ROOT / "_reports"
PIPELINE_PROMPTS_DIR = SHARED_ROOT / "prompts" / "fap"
PIPELINE_WIKI_DIR = SHARED_ROOT / "wiki"

EXCLUDED_RUNTIME_NAMES = {
    ".git", ".mypy_cache", ".pytest_cache", ".ruff_cache", "__pycache__",
    "node_modules", "venv", ".venv", "env", ".env", "dist", "build",
    "exports", "EXPORTS", "logs", "LOGS", "_LOGS", "_state", "_queue",
    "models", "model-binaries", "checkpoints", "cache", "caches",
}

# Station doctrine: embeddings/chunk vectors are canonical routing evidence.
# Classification stations must consume vectorized/lossless text, not raw intake,
# when both lanes are available.
VECTORIZE_BEFORE_CLASSIFY = True
