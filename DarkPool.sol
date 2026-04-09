// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title DarkPool
 * @dev Manages private deposits and ZK-verified trade settlements.
 */
contract DarkPool is Ownable, ReentrancyGuard {
    mapping(bytes32 => bool) public commitments;
    mapping(bytes32 => bool) public nullifiers;

    event OrderSubmitted(bytes32 indexed commitment);
    event TradeSettled(bytes32 indexed nullifierA, bytes32 indexed nullifierB);

    constructor() Ownable(msg.sender) {}

    /**
     * @dev Submit a hidden order commitment.
     */
    function submitOrder(bytes32 _commitment) external {
        require(!commitments[_commitment], "Commitment already exists");
        commitments[_commitment] = true;
        emit OrderSubmitted(_commitment);
    }

    /**
     * @dev Settles a trade using a ZK-Proof that two orders match.
     */
    function settleTrade(
        bytes32 _nullifierA,
        bytes32 _nullifierB,
        uint256[8] calldata _proof
    ) external nonReentrant {
        require(!nullifiers[_nullifierA] && !nullifiers[_nullifierB], "Already settled");

        // In production: verifier.verifyProof(_proof, ...);
        
        nullifiers[_nullifierA] = true;
        nullifiers[_nullifierB] = true;

        emit TradeSettled(_nullifierA, _nullifierB);
    }
}
