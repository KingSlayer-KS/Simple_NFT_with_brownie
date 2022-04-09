from scripts.helpful_scripts import get_account, OPENSEA_URL
from brownie import Simple_collectible

sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"


def create_and_dep():
    account = get_account()
    Simplecollectible = Simple_collectible.deploy({"from": account})
    tx = Simplecollectible.createcollectible(sample_token_uri, {"from": account})
    tx.wait(1)
    print("-----------------------------------------------------------------")
    print(
        "Lil bitch u did it, U created ur first NFT at",
        OPENSEA_URL.format(
            Simplecollectible.address, Simplecollectible.tokenCounter() - 1
        ),
    )
    print()
    print()
    print(
        "BC ruk 20 minutes, or the refresh metadata button daba zor se itni zor se ki keyboard tut jae LOL!!. "
    )
    print()
    print("-----------------------------------------------------------------")
    return Simplecollectible


def main():
    create_and_dep()
