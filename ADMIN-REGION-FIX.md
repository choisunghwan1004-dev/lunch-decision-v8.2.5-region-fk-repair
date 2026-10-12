# V8.2.2 지역 선택 수정

## 핵심 원인
공개 `/api/context/locations` API는 `parent_id`가 생략되면 `parent_id IS NULL`로 제한하여 국가만 반환했습니다. 사용자 화면은 이를 전체 트리로 간주하고 하위 목록을 찾았기 때문에 시/도가 열리지 않았습니다.

## 수정
- 공개 API: `parent_id` 생략 시 전체 활성 지역 트리를 반환
- 사용자: HTTP 오류/배열 검증, 국가 1개일 때 자동 선택
- 관리자: 국가 등록 선택지, 상위 단계 검증, 읍면동에 리가 없을 때 상권 직접 연결
- 관리자: 부가 API 실패가 지역 UI 전체 로딩을 중단하지 않도록 변경
- 서버: 국가 신규 등록과 읍면동 직속 상권 등록 허용

## 설치
1. 기존 프로젝트 폴더와 MySQL을 백업
2. ZIP을 별도 폴더에 압축 해제
3. 기존 `.env`를 복사 (이 ZIP에는 실키 없음)
4. `npm install` → `npm start`
5. 브라우저 Ctrl+Shift+R로 강력 새로고침
6. `/api/context/locations`를 열어 `country`, `province`, `district`, `town` 등 전체가 나오는지 확인
7. `/admin`에서 국가→시도→시군구→읍면동 순으로 확인

## 중요
이 패치는 기존 V8.2.1 `locations` 스키마에 대한 호환성 수정입니다. 새 `local_travel_v82` DB를 자동 적용하지 않습니다. 현재 데이터가 비어 있거나 parent_id가 잘못되면 `sql/03_region_diagnose.sql`을 실행해 데이터 상태를 먼저 확인하세요. 전국 데이터가 없으면 기존 `scripts/import-korea-locations.js`를 정부 법정동 CSV와 함께 사용해야 합니다.

실제 MySQL 연결 테스트는 수행하지 않았습니다. `node --check`만 통과 여부를 확인했습니다.
