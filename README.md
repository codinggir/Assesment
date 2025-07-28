# Assesment
# 🗳️ Decentralized Voting & Escrow Marketplace (Solidity Smart Contracts)
This repository contains two Solidity-based smart contracts developed using the Remix IDE:

DecentralizedVoting — A simple voting system with registration, voting, and anti-fraud mechanisms.

EscrowMarketplace — A marketplace contract with escrow logic to protect buyers and sellers.

📂 Project Structure
Copy
Edit
📁 contracts/
 ├── DecentralizedVoting.sol
 └── EscrowMarketplace.sol
README.md
🚀 Deployment & Testing Steps
These steps guide you through compiling, deploying, and testing using the Remix IDE:

1. Open Remix IDE
Go to https://remix.ethereum.org.

2. Create New Files
In the Remix file explorer, create two new .sol files:

DecentralizedVoting.sol

EscrowMarketplace.sol

Copy and paste the corresponding code from this repository.

3. Compile the Contracts
Go to the Solidity Compiler tab.

Select the correct Solidity version (^0.8.0 for Voting, ^0.8.20 for Marketplace).

Click Compile.

4. Deploy the Contracts
Switch to the Deploy & Run Transactions tab.

Select Remix VM (JavaScript VM) as the environment.

Deploy each contract one by one.

5. Interact with the Contracts
🗳️ DecentralizedVoting
registerVoter() – Register an account as a voter.

castVote(candidate) – Vote for a candidate.

getVotes(candidate) – View vote count.

isBlacklisted(address) – Check if a voter is blacklisted.

updateDeadline(newDeadline) – Update the registration deadline (owner only).

🛒 EscrowMarketplace
listItem(name, price) – List an item for sale.

buyItem(name) – Purchase an item (with exact ETH).

confirmItem(name) – Buyer confirms receipt to release escrow.

getItem(name) – View item details.


🙋‍♀️ Author
Developed as part of an assignment project using Solidity and Remix IDE.

