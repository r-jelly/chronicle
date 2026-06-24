# Chronicle

Claude Code 플러그인 — 기록을 쌓아가는 개인 스킬 모음.

현재 스킬:
- `/til` — 오늘 배운 것을 대화식 Q&A로 TIL 노트 작성

## 설치

```bash
claude plugin install https://github.com/royaljelly/chronicle
```

설치 후 `/reload-plugins` 실행.

## /til 스킬

Claude가 오늘 배운 내용을 물어보고, Q&A를 거쳐 구조화된 마크다운을 저장한다.

### TIL 타입

Claude가 첫 답변에서 자동으로 판단하며, 타입을 직접 선택할 필요 없다.

- **정보 기록형** — 개념/기술 학습
- **구현 과정형** — 기능 구현 기록
- **문제 해결형** — 버그/에러 해결 과정
- **기술 비교형** — 기술 선택 비교 분석
- **회고형** — KPT 회고

### 흐름

1. `/til` 실행
2. Claude: "오늘 어떤 내용을 TIL로 남기고 싶어요?"
3. Q&A 5~8개 (5~10분)
4. 마크다운 초안 미리보기
5. 확정 시 볼트에 저장

### 저장 경로

`vault/til/<주제>(YYYY-MM-DD).md`

### Hook

- **UserPromptSubmit**: TIL 세션 중 답변마다 볼트를 검색해 관련 기존 노트를 Claude 컨텍스트에 주입
- **Stop**: 미완료 세션 감지 — 저장 없이 끝나면 이어서 저장 여부 확인
- **SessionStart**: 이전 볼트 경로 자동 로드 — 매번 경로 재입력 불필요

## 요구사항

- Claude Code
- Obsidian 또는 임의 폴더 (세션 중 함께 설정)
- ripgrep 권장 (`brew install ripgrep`), 없으면 grep으로 폴백
