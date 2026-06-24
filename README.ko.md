<div align="center">

<img src="https://img.shields.io/badge/Claude_Code-Plugin-orange?style=for-the-badge&logo=anthropic&logoColor=white" />
<img src="https://img.shields.io/badge/version-0.1.0-blue?style=for-the-badge" />
<img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" />
<img src="https://img.shields.io/badge/Obsidian-Compatible-7C3AED?style=for-the-badge&logo=obsidian&logoColor=white" />

# 📖 Chronicle

**기록을 쌓아가는 Claude Code 개인 스킬 플러그인**

*당신이 배운 것, 만든 것, 고민한 것을 Claude와 함께 노트로.*

[English](README.md)

</div>

---

## ✨ 왜 Chronicle인가

매일 무언가를 배우지만, 정리하지 않으면 사라진다. Chronicle은 Claude가 직접 질문을 던지고 대화를 이끌어서 — 당신은 그냥 답하기만 하면 — 구조화된 마크다운 노트가 완성된다.

---

## 🚀 설치

```bash
claude plugin install https://github.com/r-jelly/chronicle

/reload-plugins
```

> **권장**: ripgrep이 있으면 볼트 내 관련 노트 검색이 빨라진다.
> ```bash
> brew install ripgrep
> ```

---

## 🛠 스킬

### `/til` — Today I Learned

Claude가 짧은 Q&A로 오늘 배운 내용을 끌어내고, 대화를 바탕으로 TIL 노트를 작성한다.

```
/til
  └─ Claude: "오늘 어떤 내용을 TIL로 남기고 싶어요?"
       └─ 나: 답변
            └─ Claude: 한 번에 하나씩 follow-up 질문
                 └─ 마크다운 초안 + 저장 경로 확인 → 확정 → 저장 ✓
```

**Claude가 자동으로 처리하는 것:**
- 첫 답변에서 노트 타입 자동 감지 (정보 기록형 / 구현 과정형 / 문제 해결형 / 기술 비교형 / 회고형)
- 언어 자동 감지 (한국어 / 영어) — 세션 전체를 그 언어로 진행
- 볼트에서 관련 기존 노트를 검색해 질문에 자연스럽게 연결
- 저장 경로는 config에서 자동 결정 — 초안 단계에서 확인 및 변경 가능

---

## ⚙️ 공통 동작 방식

Chronicle의 스킬들은 Claude Code 훅 시스템으로 세션 전반을 관리한다.

```
SessionStart ──→ 이전 저장 경로 로드 / 미완료 세션 감지
     │
     ▼
  스킬 실행 (/til, ...)
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

## 💾 요구사항

- [Claude Code](https://claude.ai/code)
- 저장 폴더 (Obsidian 볼트 또는 임의 폴더)
- ripgrep 권장: `brew install ripgrep`

---

<div align="center">

Made with ☕ by [R-Jelly](https://github.com/r-jelly)

*Claude Code Plugin · MIT License*

</div>
