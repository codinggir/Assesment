* @title Votingsystem
 * @dev Handles escrow logic for marketplace transactions
 * @custom:dev-run-script scripts/deploy_with_ethers.ts
 */


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    address public owner;
    uint public registrationDeadline = 1755120000; // 14th August 2025 (Unix timestamp)

    mapping(address => bool) public registeredVoters;
    mapping(address => bool) public hasVoted;
    mapping(address => bool) public blacklisted;
    mapping(string => uint) public votes;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Update registration deadline if needed
    function updateDeadline(uint newDeadline) public onlyOwner {
        registrationDeadline = newDeadline;
    }

    // Register a voter before the deadline
    function registerVoter() public {
        require(block.timestamp < registrationDeadline, "Registration closed");
        require(!registeredVoters[msg.sender], "Already registered");

        registeredVoters[msg.sender] = true;
    }

    // Cast a vote for a candidate
    function castVote(string memory candidate) public {
        require(registeredVoters[msg.sender], "Not registered");
        require(!blacklisted[msg.sender], "Blacklisted voter");

        if (hasVoted[msg.sender]) {
            // Revoke previous vote and blacklist the voter
            blacklisted[msg.sender] = true;
            votes[candidate]--;
        } else {
            votes[candidate]++;
            hasVoted[msg.sender] = true;
        }
    }

    // View total votes for a candidate
    function getVotes(string memory candidate) public view returns (uint) {
        return votes[candidate];
    }

    // Check blacklist status of a voter
    function isBlacklisted(address voter) public view returns (bool) {
        return blacklisted[voter];
    }
}
