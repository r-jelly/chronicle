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

매일 무언가를 배우지만, 정리하지 않으면 사라진다. Chronicle은 Claude가 직접 질문을 던지고 대화를 이끌어서 — 당신은 그냥 답하기만 하면 — 구조화된 마크다운 노트를 만들어 저장한다.

```
/til 실행
  └─ Claude: "오늘 어떤 내용을 TIL로 남기고 싶어요?"
       └─ 나: "RoPE가 상대 위치 임베딩이라는 걸 알게 됐어."
            └─ Claude: [질문을 이어가며 내용을 깊이 끌어냄]
                 └─ 마크다운 초안 생성 → 볼트에 저장 ✓
```

---

## 🛠 스킬 목록

| 명령어 | 설명 | 상태 |
|--------|------|------|
| `/til` | 오늘 배운 것을 대화식 Q&A로 TIL 노트 작성 | ✅ 사용 가능 |
| `/retro` | 한 주 / 스프린트 회고 작성 | 🔜 예정 |
| `/decision` | 기술 결정 로그 (ADR) 작성 | 🔜 예정 |
| `/debug` | 디버깅 과정을 재현 가능한 기록으로 | 🔜 예정 |

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

## 📝 /til 사용법

### 시작

```
/til
```

Claude가 오늘 배운 내용을 물어보는 것으로 시작한다. 따로 설정할 것 없다.

### 대화 흐름

```
┌─────────────────────────────────────────────────────┐
│  /til                                               │
│                                                     │
│  Claude  오늘 어떤 내용을 TIL로 남기고 싶어요?      │
│  나      Transformer의 Attention 구조 공부했어       │
│                                                     │
│  Claude  [타입 자동 감지: 정보 기록형]               │
│          배우게 된 계기가 뭔가요?                    │
│  나      LLM 구조를 이해하고 싶어서                  │
│                                                     │
│  Claude  핵심 내용을 설명해봐요...                   │
│  나      QKV 유사도 측정 후 softmax로...             │
│                                                     │
│  Claude  Scaled Dot-Product에서 √d_k 스케일링은     │
│          왜 필요한지 알고 있어요?  ← follow-up      │
│  나      gradient 소실 방지 때문에                  │
│                                                     │
│  ...                                                │
│                                                     │
│  Claude  📄 TIL 초안                                │
│          저장 위치: ~/obsidian/til/2026-06-24-...   │
│          [마크다운 전체 내용]                        │
│          저장할까요?                                 │
│  나      저장해줘                                   │
│                                                     │
│  Claude  ✓ ~/obsidian/til/2026-06-24-...md 저장됨  │
└─────────────────────────────────────────────────────┘
```

### TIL 타입 자동 감지

Claude가 첫 답변에서 자동으로 타입을 판단한다. 직접 고를 필요 없다.

| 타입 | 신호 | 핵심 질문 방향 |
|------|------|---------------|
| 📚 정보 기록형 | 개념·기술·도구 학습 | 계기 → 핵심 내용 → 전후 변화 |
| 🔨 구현 과정형 | 기능 구현, 코드 작성 | 기능 → 선택 이유 → 흐름 → 어려움 |
| 🐛 문제 해결형 | 버그, 에러 해결 | 상황 → 가설 → 원인 → 해결 → 재발 방지 |
| ⚖️ 기술 비교형 | 기술 선택, 장단점 | 배경 → 차이 → 선택 기준 → 사용 소감 |
| 🔄 회고형 | 한 일 돌아보기 | Keep → Problem → Try |

### 언어 자동 감지

첫 답변이 한국어면 한국어로, 영어면 영어로 — 세션 전체가 그 언어로 진행된다.

### 저장 위치

- Obsidian 볼트 자동 감지 (macOS)
- 감지된 경로는 `~/.claude/til-config.json`에 저장 → 다음 세션에 재사용
- 초안 미리보기 단계에서 경로 확인 및 변경 가능
- Obsidian 없이 임의 폴더에도 저장 가능

### 생성되는 노트 예시

```markdown
---
date: 2026-06-24
tags: [til, transformer, attention, positional-encoding]
type: 정보 기록형
---

# Transformer 핵심 구조: Attention, Positional Encoding, FFN

## Attention

Query에 대해 Key와의 유사도를 측정하고...

$$\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V$$

## Positional Encoding
...
```

---

## ⚙️ 내부 동작 (Hooks)

Chronicle은 Claude Code의 훅 시스템을 활용해 세션 전반을 관리한다.

```
SessionStart ──→ 이전 볼트 경로 로드 / 미완료 세션 감지
     │
     ▼
  /til 실행
     │
     ▼
UserPromptSubmit ──→ 답변마다 볼트 검색 → 관련 기존 노트를 컨텍스트에 주입
     │                (ripgrep 우선, 없으면 grep 폴백)
     ▼
  Q&A 진행
     │
     ▼
  초안 생성 → 저장
```

| 훅 | 역할 |
|----|------|
| `SessionStart` | `til-config.json`에서 이전 볼트 경로 로드. `til-session` 파일이 있으면 미완료 세션 알림 |
| `UserPromptSubmit` | TIL 세션 중에만 활성화. 답변 키워드로 볼트 전체 검색 → `[Related notes from vault]` 컨텍스트 주입 |

---

## 📁 구조

```
chronicle/
├── .claude-plugin/
│   └── plugin.json          # 플러그인 메타데이터
├── commands/
│   └── til.md               # /til 슬래시 커맨드
├── skills/
│   └── til/
│       └── SKILL.md         # Claude 행동 지침
├── hooks/
│   ├── hooks.json           # 훅 등록
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

## 🗺 로드맵

- [ ] `/retro` — 주간 회고 스킬
- [ ] `/decision` — 기술 결정 로그 (ADR)
- [ ] `/debug` — 디버깅 기록 스킬
- [ ] `/book` — 책/아티클 독서 노트

---

<div align="center">

Made with ☕ by [R-Jelly](https://github.com/royaljelly)

*Claude Code Plugin · MIT License*

</div>
