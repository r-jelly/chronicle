# TIL Plugin

Claude Code 플러그인 — `/til`로 대화식 TIL(Today I Learned) 작성.

## 사용법

```
/til
```

Claude가 오늘 배운 내용을 물어보고, Q&A를 거쳐 구조화된 마크다운을 Obsidian 볼트에 저장한다.

## 설치

```bash
claude plugin install https://github.com/royaljelly/til-plugin
```

설치 후 `/reload-plugins` 실행.

## TIL 타입

Claude가 첫 답변에서 자동으로 판단하며, 타입을 직접 선택할 필요 없다.

- **정보 기록형** — 개념/기술 학습
- **구현 과정형** — 기능 구현 기록
- **문제 해결형** — 버그/에러 해결 과정
- **기술 비교형** — 기술 선택 비교 분석
- **회고형** — KPT 회고

## 흐름

1. `/til` 실행
2. Claude: "오늘 어떤 내용을 TIL로 남기고 싶어요?"
3. Q&A 5~8개 (5~10분)
4. 마크다운 초안 미리보기
5. 확정 시 볼트에 저장

## 저장 경로

`vault/til/<주제>(YYYY-MM-DD).md`

## Hook

`UserPromptSubmit` 훅이 TIL 세션 중 답변마다 Obsidian 볼트를 검색해 관련 기존 노트를 Claude 컨텍스트에 주입한다. 덕분에 "2025-12-01에 UV 배웠는데, 오늘과 어떻게 연결되나요?" 같은 맥락 있는 follow-up이 가능하다.

## 요구사항

- Claude Code
- Obsidian 볼트 경로 설정 (기본값: `~/Documents/obsidian`)
- ripgrep 권장 (`brew install ripgrep`), 없으면 grep으로 폴백
