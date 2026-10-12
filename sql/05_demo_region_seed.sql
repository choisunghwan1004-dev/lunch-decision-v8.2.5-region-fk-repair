-- V8.2.4 안전한 지역 연쇄 선택 테스트 데이터
-- 운영 데이터 삭제/수정 없음. [TEST] 이름의 행만 신규 생성. 반복 실행 가능.
USE lunch_decision;
START TRANSACTION;
INSERT INTO countries(code,name) SELECT 'KR','대한민국' WHERE NOT EXISTS(SELECT 1 FROM countries WHERE code='KR');
SET @cid=(SELECT id FROM countries WHERE code='KR' LIMIT 1);
INSERT INTO locations(country_id,parent_id,name,level,code,sort_order,active)
 SELECT @cid,NULL,'[TEST] 대한민국','country','TEST-KR',999,1
 WHERE NOT EXISTS(SELECT 1 FROM locations WHERE country_id=@cid AND parent_id IS NULL AND name='[TEST] 대한민국');
SET @country=(SELECT id FROM locations WHERE country_id=@cid AND parent_id IS NULL AND name='[TEST] 대한민국' LIMIT 1);
INSERT INTO locations(country_id,parent_id,name,level,code,sort_order,active)
 SELECT @cid,@country,'[TEST] 시도','province','TEST-P',999,1
 WHERE NOT EXISTS(SELECT 1 FROM locations WHERE parent_id=@country AND name='[TEST] 시도');
SET @province=(SELECT id FROM locations WHERE parent_id=@country AND name='[TEST] 시도' LIMIT 1);
INSERT INTO locations(country_id,parent_id,name,level,code,sort_order,active)
 SELECT @cid,@province,'[TEST] 시군구','district','TEST-D',999,1
 WHERE NOT EXISTS(SELECT 1 FROM locations WHERE parent_id=@province AND name='[TEST] 시군구');
SET @district=(SELECT id FROM locations WHERE parent_id=@province AND name='[TEST] 시군구' LIMIT 1);
INSERT INTO locations(country_id,parent_id,name,level,code,sort_order,active)
 SELECT @cid,@district,'[TEST] 읍면동','town','TEST-T',999,1
 WHERE NOT EXISTS(SELECT 1 FROM locations WHERE parent_id=@district AND name='[TEST] 읍면동');
SET @town=(SELECT id FROM locations WHERE parent_id=@district AND name='[TEST] 읍면동' LIMIT 1);
INSERT INTO locations(country_id,parent_id,name,level,code,sort_order,active)
 SELECT @cid,@town,'[TEST] 점심상권','area','TEST-A',999,1
 WHERE NOT EXISTS(SELECT 1 FROM locations WHERE parent_id=@town AND name='[TEST] 점심상권');
COMMIT;
SELECT id,parent_id,level,name FROM locations WHERE name LIKE '[TEST]%' ORDER BY id;
