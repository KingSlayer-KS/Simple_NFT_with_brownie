from scripts import deploy_and_create
from scripts.helpful_scripts import LOCAL_DEVELOPMENT_ENVS, get_account
from brownie import network
import pytest
from scripts.deploy_and_create import create_and_dep


def test_can_create_simple_collectible():
    if network.show_active() not in LOCAL_DEVELOPMENT_ENVS:
        pytest.skip()
    simple_collectible = create_and_dep()
    assert simple_collectible.ownerOf(0) == get_account()


def main():
    test_can_create_simple_collectible()
