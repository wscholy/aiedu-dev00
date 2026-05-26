-- =====================================================
-- 프로젝트 진행 기록 앱 — Supabase 설정 SQL
-- Supabase SQL Editor에 전체 복사하여 실행하세요
-- =====================================================

-- 테이블 생성
CREATE TABLE IF NOT EXISTS project_records (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz      DEFAULT now(),
  project_name text,
  school_level text,
  student_name text,
  stage        text,
  today_work   text,
  good_points  text,
  difficulty   text,
  next_plan    text
);

-- RLS(Row Level Security) 활성화
ALTER TABLE project_records ENABLE ROW LEVEL SECURITY;

-- 익명 사용자(anon)에게 INSERT 허용 — 학생 기록 제출
CREATE POLICY "anon_can_insert"
  ON project_records
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- 익명 사용자(anon)에게 SELECT 허용 — 교사/학생 조회
CREATE POLICY "anon_can_select"
  ON project_records
  FOR SELECT
  TO anon
  USING (true);
