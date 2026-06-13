from engines.pipeline.backside_paths import (
    BACKSIDE_ROOT,
    KNOWLEDGE_GRAPHS_ROOT,
    SHARED_ROOT,
    STATIONS_ROOT,
    VECTORIZE_BEFORE_CLASSIFY,
    WORKFLOWS_ROOT,
)
from engines.pipeline.fap_boot import DIRS, ALL_STATIONS


def test_backside_spine_defaults_to_x_drive_roots():
    assert str(BACKSIDE_ROOT) == r"X:\Backside"
    assert str(STATIONS_ROOT) == r"X:\Backside\_Stations"
    assert str(WORKFLOWS_ROOT) == r"X:\Backside\workflows"
    assert str(KNOWLEDGE_GRAPHS_ROOT) == r"X:\Backside\knowledge-graphs"
    assert str(SHARED_ROOT) == r"X:\Backside\_Shared"


def test_station_doctrine_vectorize_before_classify():
    assert VECTORIZE_BEFORE_CLASSIFY is True
    assert ALL_STATIONS.index("vectorizer") < ALL_STATIONS.index("classifier")
    assert DIRS["lossless"].startswith(r"X:\Backside\workflows")
    assert DIRS["output"].startswith(r"X:\Backside\knowledge-graphs")
