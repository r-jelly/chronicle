<div align="center">

<img src="https://img.shields.io/badge/Claude_Code-Plugin-orange?style=for-the-badge&logo=anthropic&logoColor=white" />
<img src="https://img.shields.io/badge/version-0.1.0-blue?style=for-the-badge" />
<img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" />
<img src="https://img.shields.io/badge/Obsidian-Compatible-7C3AED?style=for-the-badge&logo=obsidian&logoColor=white" />

# 📖 Chronicle

**A Claude Code plugin for building your personal record — one conversation at a time.**

*What you learned, what you built, what you thought through — turned into structured notes with Claude.*

[한국어](README.ko.md)

</div>

---

## ✨ Why Chronicle

Every day you learn something. Most of it disappears because writing it down feels like work. Chronicle flips that: Claude asks the questions, you just answer, and a structured markdown note is ready to save.

---

## 🚀 Installation

```bash
claude plugin install https://github.com/r-jelly/chronicle

/reload-plugins
```

> **Recommended**: install ripgrep for faster vault search.
> ```bash
> brew install ripgrep
> ```

---

## 🛠 Skills

### `/til` — Today I Learned

Claude guides you through a short Q&A and writes a TIL note from your answers.

```
/til
  └─ Claude: "What do you want to record as a TIL today?"
       └─ You: answer
            └─ Claude: follow-up questions, one at a time
                 └─ Draft preview with save path → confirm → saved ✓
```

**What Claude handles automatically:**
- Detects note type from your first answer (concept learned / implementation / bug fix / tech comparison / retrospective)
- Detects language (Korean or English) and stays consistent throughout
- Searches your vault for related past notes and weaves them into questions
- Resolves save location from config — shows it in the draft, change only if needed

---

## ⚙️ How It Works

Chronicle uses Claude Code's hook system to manage sessions end-to-end.

```
SessionStart ──→ Load previous save path / detect incomplete session
     │
     ▼
  Skill runs (/til, ...)
     │
     ▼
UserPromptSubmit ──→ Search vault on every answer → inject related notes into context
     │
     ▼
  Draft generated → save path shown → confirmed → saved
```

| Hook | Role |
|------|------|
| `SessionStart` | Loads saved vault path. Alerts if a previous session was not completed. |
| `UserPromptSubmit` | Active during skill sessions. Searches the entire vault and injects related notes as context. |

---

## 📁 Structure

```
chronicle/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── til.md
├── skills/
│   └── til/
│       └── SKILL.md
├── hooks/
│   ├── hooks.json
│   ├── til-context.sh
│   └── til-sessionstart.sh
└── README.md
```

---

## 💾 Requirements

- [Claude Code](https://claude.ai/code)
- A save folder (Obsidian vault or any directory)
- ripgrep recommended: `brew install ripgrep`

---

<div align="center">

Made with ☕ by [R-Jelly](https://github.com/r-jelly)

*Claude Code Plugin · MIT License*

</div>
