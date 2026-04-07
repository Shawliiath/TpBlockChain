// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

/**
 * @title SimpleStorage
 * @notice Contrat de démonstration : stockage d'une valeur uint256
 * @dev Illustre les concepts fondamentaux de Solidity :
 *      variables d'état, visibilité, events, modifiers, constructor
 */
contract SimpleStorage {

    // Variables d'état
    address public owner;
    uint256 private storedValue;
    uint256 public updateCount;

    // Event émis quand la valeur change
    event ValueUpdated(
        uint256 indexed oldValue,
        uint256 newValue,
        address indexed updatedBy
    );

    // Erreur custom si c'est pas le owner
    error NotOwner(address caller, address owner);

    // Modifier pour restreindre au owner
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender, owner);
        }
        _;
    }

    constructor() {
        owner = msg.sender;
        storedValue = 0;
        updateCount = 0;
    }

    // Stocker une nouvelle valeur (owner only)
    function store(uint256 newValue) external onlyOwner {
        uint256 oldValue = storedValue;
        storedValue = newValue;
        updateCount += 1;
        emit ValueUpdated(oldValue, newValue, msg.sender);
    }

    // Lire la valeur stockée
    function retrieve() external view returns (uint256) {
        return storedValue;
    }

    // Retourne tout l'état du contrat d'un coup
    function getState() external view returns (
        uint256 _value,
        uint256 _updateCount,
        address _owner
    ) {
        return (storedValue, updateCount, owner);
    }
}
