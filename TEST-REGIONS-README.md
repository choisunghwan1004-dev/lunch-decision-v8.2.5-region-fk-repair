# V8.2.4 가상 지역 데이터 테스트

**기존 데이터 삭제 없이** `[TEST] 대한민국 → [TEST] 시도 → [TEST] 시군구 → [TEST] 읍면동 → [TEST] 점심상권`을 만듭니다. 이 자료는 실제 행정구역이 아니며 화면 연쇄 선택 및 관리자 등록 가능 여부만 시험합니다.

1. 기존 DB를 백업합니다.
2. MySQL Workbench에서 `sql/05_demo_region_seed.sql`을 열고 전체 실행합니다. DB는 `lunch_decision`입니다.
3. `npm install` → `npm start`로 서버를 시작합니다.
4. 일반 화면에서 국가 `[TEST] 대한민국`을 선택한 후 `[TEST] 시도 → [TEST] 시군구 → [TEST] 읍면동 → [TEST] 점심상권` 순서로 선택합니다.
5. 관리자 `/admin`에서도 같은 순서로 선택합니다.
6. 두 화면 모두 성공하면 기존 실제 데이터의 하위 단계 누락/parent_id 오류를 점검해야 합니다. 테스트도 실패하면 브라우저 Console 및 Network API 응답을 확인합니다.

주의: `[TEST]` 국가는 실제 국가 KR과 같은 `country_id`를 사용하지만 `locations`의 독립적인 루트입니다. 실제 국가 목록과 섞여 보일 수 있으므로 테스트 이후 비활성화하세요. `sql/06_demo_region_cleanup.sql`은 삭제 없이 목록만 조회합니다.

테스트는 `locations` 선택을 확인합니다. 음식점 등록까지 완전히 검증하려면 `restaurants` 테이블의 legacy `region_id/city_id` 매핑과 등록 API를 별도 검증해야 합니다. 본 버전은 가짜 legacy ID를 만들어 넣지 않습니다.
