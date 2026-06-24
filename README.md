<div align="center">

<img src="https://img.shields.io/badge/Claude_Code-Plugin-orange?style=for-the-badge&logo=anthropic&logoColor=white" />
<img src="https://img.shields.io/badge/version-0.1.0-blue?style=for-the-badge" />
<img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" />
<img src="https://img.shields.io/badge/Obsidian-Compatible-7C3AED?style=for-the-badge&logo=obsidian&logoColor=white" />

# 📖 Chronicle

**기록을 쌓아가는 Claude Code 개인 스킬 플러그인**

*당신이 배운 것, 만든 것, 고민한 것을 Claude와 함께 노트로.*

</div>

---

## ✨ 왜 Chronicle인가

매일 무언가를 배우지만, 정리하지 않으면 사라진다. Chronicle은 Claude가 직접 질문을 던지고 대화를 이끌어서 — 당신은 그냥 답하기만 하면 — 구조화된 마크다운 노트가 완성된다. Obsidian 볼트 또는 임의의 폴더에 저장된다.

---

## 🚀 설치

```bash
# 플러그인 설치
claude plugin install https://github.com/royaljelly/chronicle

# 설치 후 리로드
/reload-plugins
```

> **권장**: ripgrep이 있으면 볼트 내 관련 노트 검색이 빨라진다.
> ```bash
> brew install ripgrep
> ```

---

## ⚙️ 공통 동작 방식

Chronicle의 스킬들은 Claude Code 훅 시스템으로 세션 전반을 관리한다.

```
SessionStart ──→ 이전 저장 경로 로드 / 미완료 세션 감지
     │
     ▼
  스킬 실행 (/til, /retro, ...)
     │
     ▼
UserPromptSubmit ──→ 답변마다 볼트 검색 → 관련 기존 노트를 컨텍스트에 주입
     │
     ▼
  초안 생성 → 저장 경로 확인 → 저장
```

| 훅 | 역할 |
|----|------|
| `SessionStart` | 이전 저장 경로 자동 로드. 미완료 세션이 있으면 이어할지 알림 |
| `UserPromptSubmit` | 스킬 세션 중 활성화. 볼트 전체를 검색해 관련 노트를 Claude 컨텍스트에 주입 |

---

## 📁 구조

```
chronicle/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── til.md               # /til 슬래시 커맨드
├── skills/
│   └── til/
│       └── SKILL.md         # Claude 행동 지침
├── hooks/
│   ├── hooks.json
│   ├── til-context.sh       # UserPromptSubmit: 볼트 검색
│   └── til-sessionstart.sh  # SessionStart: 설정 로드
└── README.md
```

---

## 💾 요구사항

- [Claude Code](https://claude.ai/code)
- 저장 폴더 (Obsidian 볼트 또는 임의 폴더)
- ripgrep 권장: `brew install ripgrep`

---

<div align="center">

Made with ☕ by [R-Jelly](https://github.com/royaljelly)

*Claude Code Plugin · MIT License*

</div>
