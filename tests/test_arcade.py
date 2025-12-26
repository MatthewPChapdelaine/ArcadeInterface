"""Test suite for ArcadeInterface"""
import sys
sys.path.insert(0, '/workspaces/ArcadeInterface')

from arcade_interface import hello, __version__


def test_hello():
    assert hello() == "ArcadeInterface initialized"


def test_version():
    assert __version__ == "0.1.0"
