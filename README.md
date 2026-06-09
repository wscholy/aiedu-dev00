# 과학 실험 관찰 기록

초등·중등·고등 과학 실험 중 학생 관찰 내용을 실시간으로 기록하고, 교사가 전체 기록을 한눈에 조회하는 웹앱입니다.

**배포 주소**: `https://<GitHub계정>.github.io/aiedu-dev01/`

---

## 사용 방법

### 교사
1. 실험 이름 입력 → 학교급 선택 → **실험 시작**
2. 학생에게 URL 공유
3. **전체 기록 조회** 버튼으로 제출 현황 확인

### 학생
1. 교사가 공유한 URL 접속
2. 이름과 관찰 내용 입력 후 **제출하기**

---

## 설치 및 배포

### 1. config.js 설정

`config.js` 파일을 열고 Supabase 정보를 입력하세요.

```js
const SUPABASE_URL = 'https://xxxxxxxxxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJ...';
```

> `config.js`는 `.gitignore`에 등록되어 있으므로 GitHub에 올라가지 않습니다.

### 2. Supabase 테이블 설정

Supabase 대시보드 → **SQL Editor** → 아래 SQL 전체 붙여넣기 후 실행

```sql
-- 테이블 생성
CREATE TABLE IF NOT EXISTS science_records (
  id               uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at       timestamptz DEFAULT now() NOT NULL,
  experiment_name  text        NOT NULL,
  school_level     text        NOT NULL,
  student_name     text        NOT NULL,
  step             text,
  observation      text,
  feeling          text,
  next_plan        text,
  difficulty       text
);

-- RLS 활성화
ALTER TABLE science_records ENABLE ROW LEVEL SECURITY;

-- anon 삽입 허용
CREATE POLICY "anon_insert" ON science_records
  FOR INSERT TO anon WITH CHECK (true);

-- anon 조회 허용
CREATE POLICY "anon_select" ON science_records
  FOR SELECT TO anon USING (true);
```

### 3. GitHub Pages 배포

```bash
git init
git remote add origin https://github.com/<계정>/aiedu-dev01.git
git add index.html .gitignore README.md
git commit -m "init"
git push -u origin main
```

GitHub 레포 → Settings → Pages → Source: `main` 브랜치 선택 → Save

---

## 파일 구조

```
aiedu-dev01/
├── index.html    # 메인 앱 (3개 화면)
├── config.js     # Supabase 설정 ← gitignore 처리
├── .gitignore
└── README.md
```

---

## 학교급별 입력 항목

| 항목 | 초등 | 중등 | 고등 |
|------|------|------|------|
| 실험 단계 | 지금 뭐 하고 있나요? | 현재 실험 단계 | 진행 단계 |
| 관찰 내용 | 무엇을 보았나요? | 관찰 내용 | 실험 결과 및 관찰 |
| 느낀 점 | 어떤 느낌이었나요? | 소감 및 의문점 | 분석 및 고찰 |
| 다음 계획 | 다음엔 뭐 할까요? | 다음 실험 계획 | 후속 연구 계획 |
| 어려운 점 | 힘든 게 있었나요? | 어려운 점 | 문제점 및 개선사항 |
