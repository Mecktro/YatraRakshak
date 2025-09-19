// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TouristID {
    struct Tourist {
        string encryptedName;
        string encryptedNationality;
        string kycHash;
        string ipfsDocHash;
        uint validUntil;
        bool isActive;
    }
    address public admin;
    mapping(address => Tourist) public tourists;
    mapping(address => bool) public isPolice;

    event IDGenerated(address indexed tourist, string kycHash, uint validUntil);
    event PoliceAccess(address indexed police, address indexed tourist, uint time);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    modifier onlyPolice() {
        require(isPolice[msg.sender], "Not authorized police");
        _;
    }

    constructor() {
        admin = msg.sender;
        isPolice[admin] = true;
    }

    function generateID(
        address _tourist,
        string memory _encryptedName,
        string memory _encryptedNationality,
        string memory _kycHash,
        string memory _ipfsDocHash,
        uint _validUntil
    ) public onlyAdmin {
        tourists[_tourist] = Tourist(_encryptedName, _encryptedNationality, _kycHash, _ipfsDocHash, _validUntil, true);
        emit IDGenerated(_tourist, _kycHash, _validUntil);
    }

    function viewTouristDetails(address _tourist) public view onlyPolice returns (
        string memory, string memory, string memory, string memory, uint, bool
    ) {
        Tourist storage t = tourists[_tourist];
        return (t.encryptedName, t.encryptedNationality, t.kycHash, t.ipfsDocHash, t.validUntil, t.isActive);
    }

    function addPolice(address _police) public onlyAdmin {
        isPolice[_police] = true;
    }
}
