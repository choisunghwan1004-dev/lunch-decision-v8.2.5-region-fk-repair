-- 테스트 행만 삭제. FK 참조가 생긴 경우 RESTRICT/FK 오류가 발생할 수 있으므로 먼저 확인.
-- 이 파일은 안전을 위해 자동 DELETE하지 않습니다.
USE lunch_decision;
SELECT id,parent_id,level,name FROM locations WHERE name LIKE '[TEST]%' ORDER BY id;
-- 테스트를 끝낸 후 각 행의 참조 관계를 확인하고 관리자에서 비활성화하세요.
