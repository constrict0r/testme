# From root folder run: ./testme.sh.
import pytest


def test_lower_case():
    assert 'AMANITA'.lower() == 'amanita'
