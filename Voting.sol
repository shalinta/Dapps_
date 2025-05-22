// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;

    mapping(address => bool) public isVoted;
    mapping(address => bool) public isRegistered;

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin {
        require(admin == msg.sender, "Only admin allowed");
        _;
    }

    modifier onlyRegistered {
        require(isRegistered[msg.sender] == true, "Not registered to vote");
        _;
    }

    modifier notVoted {
        require(!isVoted[msg.sender], "Already voted");
        _;
    }

    event CandidateCreated(string name);
    event VoterRegistered(address voter);
    event Voted(address voter, uint candidateId);
    
    function createCandidate(string memory _name) public onlyAdmin {
        candidates.push(Candidate(_name, 0));
        emit CandidateCreated(_name);
    }

    // Admin registers a voter by address
    function registerVoter(address _voter) public onlyAdmin {
        require(!isVoted[_voter], "Already voted");
        require(!isRegistered[_voter], "Already registered");
        isRegistered[_voter] = true;
        emit VoterRegistered(_voter);
    }

    // Registered voter can vote only once
    function vote(uint candidateId) public onlyRegistered notVoted {
        require(candidateId < candidates.length, "Invalid candidate ID");
        candidates[candidateId].voteCount += 1;
        isVoted[msg.sender] = true;
        emit Voted(msg.sender, candidateId);
    }

    // View all candidates and vote counts
    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Admin-only function to determine the winner
    function getWinner() public view onlyAdmin returns (string memory winnerName, uint winnerVoteCount) {
        require(candidates.length > 0, "No candidates registered");

        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
        winnerVoteCount = candidates[winnerIndex].voteCount;
    }
}