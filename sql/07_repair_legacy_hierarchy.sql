-- V8.2.5 기존 지역 FK 구조 복구: 먼저 백업 필수
-- 기존 v8-locations.sql이 regions → cities를 province → town으로 잘못 연결함.
-- city에 연결된 기존 town을 district로 변경하되 ID는 유지한다.
-- 변경 전에 미리보기:
USE lunch_decision;
SELECT p.name AS province,l.id,l.name,l.level,l.legacy_city_id
FROM locations l JOIN locations p ON p.id=l.parent_id
WHERE p.level='province' AND l.level='town';
-- 적용: 해당 기존 도시 노드를 시/군/구로 재분류. 참조 ID 불변.
START TRANSACTION;
UPDATE locations l
JOIN locations p ON p.id=l.parent_id AND p.level='province'
SET l.level='district'
WHERE l.level='town' AND l.legacy_city_id IS NOT NULL;
COMMIT;
-- 남아있는 province 직속 town 진단
SELECT l.id,l.name,l.parent_id FROM locations l JOIN locations p ON p.id=l.parent_id
WHERE l.level='town' AND p.level='province';
-- DB 제약과 데이터 관계 진단
SELECT TABLE_NAME,CONSTRAINT_NAME,REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA=DATABASE() AND REFERENCED_TABLE_NAME IS NOT NULL
AND TABLE_NAME IN ('locations','restaurants','areas');
