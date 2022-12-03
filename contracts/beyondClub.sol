// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract beyondClub {

    uint public totalBrands = 0;
    uint public totalCampaigns = 0;

    mapping (string => address) usernameToAddress;
    mapping (string => uint) brandId;
    mapping (uint => string) brandIdToHash;
    mapping (uint => uint) campaignPerBrand;
    mapping (uint => mapping(uint => string)) campaignHashes;

    event brandCreated (
        string username,
        uint _brandId,
        address brandAddress
    );
    event campaignCreated (
        string _username,
        uint campaignId
    );

    function checkBrand (string memory _username) public view returns (uint, address) {
        return (brandId[_username], usernameToAddress[_username]);
    }

    function usernameAvailable (string memory _username) public view returns (bool) {
        if (usernameToAddress[_username] == address(0)) {
            return true;
        }
        else return false;
    }

    function createBrand (string memory _username) public {
        require(usernameToAddress[_username] == address(0), "this username is already taken");
        totalBrands++;
        usernameToAddress[_username] = msg.sender;
        brandId[_username] = totalBrands;
        campaignPerBrand[totalBrands] = 0;
        emit brandCreated(_username, brandId[_username], usernameToAddress[_username]);
    }
    
    function setBrandHash (string memory _hash) public {
        brandIdToHash[totalBrands] = _hash;
    }
    function newCampaign (string memory _brand, string memory _campaignHash) public {
        campaignPerBrand[brandId[_brand]]++;
        totalCampaigns++;
        campaignHashes[brandId[_brand]][campaignPerBrand[brandId[_brand]]] = _campaignHash;

        emit campaignCreated(_brand, totalCampaigns);
    }

    function checkCampaigns (string memory _brand, uint i) public view returns (string memory) {
        uint _brandId = brandId[_brand];
        return campaignHashes[_brandId][i];
    }
    function checkNumberOfCampaigns (string memory _brand) public view returns (uint) {
        uint _brandId = brandId[_brand];
        return campaignPerBrand[_brandId];
    }

}



