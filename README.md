# ZK-Based Dark Pool (Financial Privacy)

A professional-grade implementation for private high-frequency trading. This repository solves the "Transparency Problem" in public blockchains where every large trade is visible to bots, leading to slippage and front-running. By using Zero-Knowledge Proofs, users can prove they have the funds and the intent to trade without revealing the specifics of their position to the public mempool.

## Core Features
* **Hidden Order Book:** Orders are submitted as "Commitments" (hashes) that do not reveal price or volume.
* **Match-Proofing:** A coordinator or decentralized circuit matches orders and generates a ZK-SNARK proving the trade was fair and executed at the correct price.
* **Atomic Settlement:** Trades settle only when the proof is verified on-chain, moving funds between private "Notes."
* **Flat Architecture:** Single-directory layout for the Dark Pool Manager, ZK-Verifier, and Liquidity Vault.

## Logic Flow
1. **Deposit:** User moves 100 ETH into the Dark Pool vault, receiving a private "Note."
2. **Order:** User submits a ZK-proof that they own a Note and wish to sell at a certain (hidden) price.
3. **Match:** The engine finds a matching buy order and generates a "Proof of Match."
4. **Settle:** The contract verifies the match proof and updates the internal private balances without ever revealing the trade details on-chain.

## Setup
1. `npm install`
2. Deploy `DarkPool.sol` and the ZK-Verifier.
