-- 읽기 전용: 먼저 확인 (기존 자료 변경 없음)
USE lunch_decision;
SELECT level,COUNT(*) count_rows FROM locations WHERE active=1 GROUP BY level;
SELECT c.code,c.name, l.id root_id FROM countries c LEFT JOIN locations l ON l.country_id=c.id AND l.level='country';
SELECT p.id,p.name,p.parent_id FROM locations p LEFT JOIN locations c ON c.id=p.parent_id AND c.level='country' WHERE p.level='province' AND c.id IS NULL;
SELECT p.name,COUNT(d.id) child_count FROM locations p LEFT JOIN locations d ON d.parent_id=p.id AND d.level='district' WHERE p.level='province' GROUP BY p.id,p.name ORDER BY p.name;
