# 🪙 Mining Reward System – A Bitcoin-Native RPG Token Engine

**Mining Reward System** is a smart contract-based game engine for an RPG where players earn a native crypto token, **Deolax ($DEOLAX)**, by reaching milestones during gameplay. Built on the [Stacks](https://stacks.co) Bitcoin Layer 2 network using [Clarity](https://docs.stacks.co/write-smart-contracts/clarity), this project enables a play-to-earn economy where tokens are both functional and valuable.

---

## 🧱 Project Goals

- 🎮 Reward players with tokens for gameplay achievements (e.g., distance traveled, quests completed).
- 🪙 Use a fungible token (**Deolax**) as the in-game currency.
- 🛒 Allow in-game purchases with Deolax.
- 🔁 Enable withdrawal of Deolax for stablecoins or BTC equivalents.
- 🔐 Ensure a secure, transparent, and open-source foundation for play-to-earn gaming on Bitcoin.

---

## 📦 Contracts Overview

| Contract Name        | Description                                                   |
|----------------------|---------------------------------------------------------------|
| `game-token.clar`    | Implements the SIP-010 standard fungible token (`DEOLAX`)     |
| `mining-engine.clar` | Rewards players with Deolax when they reach game milestones   |
| *(More coming soon)* | Store contract, economy logic, withdrawal bridges, etc.       |

---

## 📂 Project Structure

```
mining-reward-system/
├── contracts/
│   ├── deolax-token.clar        # Deolax SIP-010 fungible token
│   └── mining-engine.clar       # Player milestone tracking and reward logic
├── tests/                       # Clarinet test suites (TBD)
├── settings/                    # Clarinet network config
├── Clarinet.toml                # Project metadata & contract configs
└── README.md                    # You're here!
```

---

## 🧪 Getting Started

### 📦 Prerequisites
- [Clarinet](https://docs.hiro.so/clarinet/get-started) (Clarity dev tool)
- Node.js (optional, for scripting)
- Git, a text editor, and basic terminal knowledge

### 🚀 Set Up Project
```bash
git clone https://github.com/your-username/mining-reward-system.git
cd mining-reward-system
clarinet check
```

### 🧰 Compile & Test Contracts
```bash
clarinet check      # Syntax check
clarinet test       # Run test suites (when added)
clarinet console    # Open REPL for live contract interaction
```

---

## 🧠 Token Details: $DEOLAX

| Attribute       | Value              |
|----------------|--------------------|
| Name           | Deolax             |
| Symbol         | DEOLAX             |
| Decimals       | 6                  |
| Standard       | SIP-010            |
| Initial Supply | Minted as players progress |

Deolax can be:
- 🔄 Transferred between players
- 🔥 Burned when used for purchases
- 🏅 Earned through in-game milestones

---

## 📜 How It Works

1. Players complete gameplay objectives (e.g., distance walked).
2. They call `update-progress` to log progress.
3. Once a milestone is met, players call `claim-reward`.
4. `mining-engine.clar` mints `DEOLAX` via `deolax-token.clar`.
5. Players can use tokens in-game or withdraw them.

---

## 🧩 Next Features (WIP)

- 🎯 **Store Contract** – spend $DEOLAX to buy in-game items
- 🧙 **Character Upgrades** – pay tokens to level up
- 💸 **Withdrawal Logic** – bridge to stable tokens or BTC
- 📱 **Frontend Game Integration** – Unity/WebGL support

---

## 🤝 Contributing

Want to contribute or build your own modules on top? Awesome!

1. Fork this repo
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Write clear, documented code
4. Submit a pull request 🚀

Please follow SIP-010 standards and include Clarinet tests where applicable.

---

## 📄 License

This project is licensed under the MIT License. See `LICENSE` for details.

---

## 🌐 Learn More

- [Stacks Docs](https://docs.stacks.co/)
- [Clarity Language](https://docs.stacks.co/write-smart-contracts/clarity)
- [Clarinet Tooling](https://docs.hiro.so/clarinet/overview)