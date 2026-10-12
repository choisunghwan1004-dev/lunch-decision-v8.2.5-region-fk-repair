-- READ ONLY: 현재 DB의 계층 누락 검사
USE lunch_decision;
SELECT level, COUNT(*) total FROM locations WHERE active=1 GROUP BY level;
SELECT p.level parent_level,p.name parent_name,COUNT(c.id) children FROM locations p LEFT JOIN locations c ON c.parent_id=p.id AND c.active=1 WHERE p.active=1 AND p.level IN ('country','province','district','town','ri') GROUP BY p.id,p.level,p.name HAVING COUNT(c.id)=0 ORDER BY p.level,p.name LIMIT 150;
SELECT c.id,c.level,c.name,c.code,c.parent_id FROM locations c LEFT JOIN locations p ON p.id=c.parent_id WHERE c.level<>'country' AND (p.id IS NULL OR p.active<>1) LIMIT 100;
SELECT p.name province,d.name district,COUNT(t.id) towns FROM locations p JOIN locations d ON d.parent_id=p.id AND d.level='district' LEFT JOIN locations t ON t.parent_id=d.id AND t.level='town' WHERE p.level='province' GROUP BY p.id,d.id HAVING COUNT(t.id)=0 ORDER BY p.name,d.name LIMIT 100;
