# 작업지시서 C — 프로젝트 진행 기록 앱

## 프로젝트 개요
- **앱 이름**: 프로젝트 진행 기록
- **목적**: 학생들이 프로젝트 활동 진행 상황을 단계별로 기록하고, 교사가 전체 학생 진행 상황을 한눈에 조회
- **배포**: GitHub Pages (정적 사이트)
- **DB**: Supabase

---

## 기술 스택
- HTML / CSS / JavaScript (단일 index.html 파일)
- Supabase JS 클라이언트 v2 (CDN)
- config.js — Supabase URL, anon key 분리 관리 (.gitignore 포함)
- GitHub Pages 배포

---

## Supabase 설정

아래 정보를 입력하고 SQL을 생성해 주세요.

- **PROJECT_URL**:='['text'](../Downloads/작업지시서_A_과학실험관찰.md) [여기에 Supabase Project URL 입력]
- **ANON_KEY**: [여기에 Supabase anon key 입력]

### DB 설정 지시
위 정보를 바탕으로 아래를 수행해 주세요.
- 테이블 생성 SQL 코드를 작성해 주세요 (테이블명: project_records)
- RLS 설정 SQL 코드도 포함해 주세요 (insert/select: anon 모두 허용)
- 학생이 Supabase SQL Editor에 붙여넣기만 하면 바로 실행되도록 전체 SQL을 하나로 묶어 주세요

### 테이블 컬럼 구성
| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| id | uuid | 기본키 (자동생성) |
| created_at | timestamp | 제출 시간 (자동생성) |
| project_name | text | 프로젝트 이름 |
| school_level | text | 학교급 (초등/중등/고등) |
| student_name | text | 학생 이름 |
| stage | text | 진행 단계 |
| today_work | text | 오늘 한 것 |
| good_points | text | 잘 된 것 |
| difficulty | text | 어려운 점 |
| next_plan | text | 다음 계획 |

---

## 화면 구성 (3개 화면, 단일 페이지 내 전환)

### 1. 설정 화면 (교사용)
- 프로젝트 이름 입력
- 학교급 선택 (초등 / 중등 / 고등) — 선택에 따라 이후 화면 언어 변경
- 시작 버튼 → 학생 입력 화면으로 전환
- 전체 기록 조회 버튼 → 조회 화면으로 전환

### 2. 학생 입력 화면
공통 항목: 이름 입력

학교급별 입력 항목 및 언어:
| 항목 | 초등 | 중등 | 고등 |
|------|------|------|------|
| 진행 단계 | 지금 어디까지 했나요? | 현재 진행 단계 | 진행 단계 |
| 오늘 한 것 | 오늘 무엇을 했나요? | 오늘 활동 내용 | 수행 내용 |
| 잘 된 것 | 잘 된 것은 무엇인가요? | 잘 된 점 | 성과 및 결과 |
| 어려운 점 | 힘든 게 있었나요? | 어려운 점 | 문제점 및 한계 |
| 다음 계획 | 다음엔 뭐 할 건가요? | 다음 활동 계획 | 후속 계획 및 개선방향 |

진행 단계 선택 (학교급별):
- 초등: 시작했어요 / 하는 중이에요 / 거의 다 됐어요 / 완성했어요
- 중등: 계획 수립 / 진행 중 / 마무리 단계 / 완료
- 고등: 기획 / 실행 / 검토 / 완성

### 3. 전체 조회 화면 (교사용)
- 전체 학생 기록 테이블 표시 (최신순)
- 진행 단계별 필터
- 학생 이름별 필터
- 새로고침 버튼
- 제출 인원 수, 단계별 학생 수 통계

---

## 파일 구조
```
aiedu-dev01/
├── index.html
├── config.js
├── .gitignore
└── README.md
```

---

## 환경변수 처리 규칙
config.js 형식:
```javascript
const SUPABASE_URL = 'your-supabase-url';
const SUPABASE_ANON_KEY = 'your-anon-key';
```
- .gitignore에 config.js 반드시 포함

---

## 디자인 가이드
- 배경: 흰색 또는 연한 회색
- 포인트 컬러: 초록 계열 (성장·진행 느낌)
- 폰트: Noto Sans KR 우선
- 모바일 대응: 최대 너비 600px 중앙 정렬
- 진행 단계별 색상: 시작(회색) / 진행(파랑) / 마무리(주황) / 완료(초록)

---

## 에러 핸들링 규칙
- Supabase 연결 실패 시 사용자 안내 메시지 표시
- 필수 항목 미입력 시 제출 버튼 비활성화
- 제출 중 로딩 상태 표시
- console.error로 에러 로깅 포함

---

## 개발 순서 (마일스톤)

### MVP (강사 시연용 — 초등 기준)
1. index.html 기본 구조
2. config.js 및 Supabase 연결
3. 설정 화면 구현
4. 학생 입력 화면 (초등 언어 기준)
5. Supabase insert 연동
6. 조회 화면 구현
7. GitHub Pages 배포 (레포명: aiedu-dev01)

### v0.2.0
- 학교급별 언어 전환
- 진행 단계별 필터 및 통계
- 학생 본인 이전 기록 조회 기능
- 모바일 반응형 개선

### v1.0.0
- 디자인 완성
- 에러 핸들링 강화

---

## 주의사항
- config.js는 절대 GitHub에 push하지 않는다
- 단일 HTML 파일로 구현
- Supabase CDN: https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2
- 한국어 주석 필수
- GitHub 레포명: aiedu-dev01 (로컬 폴더명과 동일)
- 강사 시연용: 초등 학교급으로 MVP 먼저 구현
