# 📘 CLAUDE.md - 포켓 문화재 가이드 (K-Heritage Explorer)

> Claude Code가 **맥락을 이해하고 스스로 작업 계획을 세워 실행**하기 위한 가이드입니다.
> 톤: 간결하고 실행 중심. 산출물은 **작게, 자주**.

---

## 1) 미션

* 한국 공공데이터포털의 문화재 데이터를 기반으로 한 **포켓 문화재 가이드** 앱의 **MVP 구현**.
* **핵심 사용자 여정**: 앱 실행 → 위치 권한 → 지도에 주변 문화재 마커/리스트 → 상세 → 길찾기
* **다국어**(ko 기본, en/ja/zh)는 **Edge Function 프록시 + 캐시**로 처리.

---

## 2) 개발 원칙

1. **보안**: 외부 API 키는 클라이언트에 두지 않는다. 번역/민감 호출은 Edge Function을 통해 수행.
2. **품질**: 재사용 가능한 작은 위젯, 명확한 상태, 빠른 첫 렌더.
3. **확장성**: 데이터 레이어 분리(원격/로컬), 다국어/테마 추가를 스키마/시드로 확장 가능하게.
4. **가시성**: PR/커밋마다 작업 내역·의사결정 기록.

---

## 3) 초기가정(준수)

* Flutter + Riverpod + go_router + dio + freezed/json_serializable
* Supabase 사용(테이블: `heritage`, `heritage_image`, `theme`, `theme_map`, `user_setting`, `translation_cache`)
* 지도: google_maps_flutter
* 번역: `supabase/functions/translate-proxy` 호출

---

## 4) 파일/폴더 생성 규칙

* 기능 단위로 **폴더 1개**에 모으고(`features/heritage/...`) `presentation/application/domain/infrastructure` 4분할 유지.
* 위젯 1파일 200줄 이상이면 **분리**.
* 인터페이스(`repositories/`)와 구현(`repositories_impl/`)을 구분.

---

## 5) 작업 순서(권장 Plan)

1. **셋업**
   * Flutter 의존성 추가, `freezed`/`build_runner` 설정
   * Supabase 클라이언트 초기화, `.env` 로드

2. **도메인 모델**
   * `Heritage`, `HeritageImage` Freezed 생성

3. **데이터소스/리포지토리**
   * `HeritageRemoteDataSource`, `HeritageLocalDataSource`
   * `HeritageRepository`/`Impl` + 캐싱 전략 구현

4. **상태/프리젠테이션**
   * `HeritageController` + 홈(Map+List)
   * 상세/테마/설정 화면 스켈레톤

5. **번역 프록시 연동**
   * `TranslationDataSource` + 다국어 토글/캐시

6. **권한/오류/성능**
   * 위치 권한 플로우, 네트워크 에러 처리, 이미지 캐시

7. **QA**
   * 오프라인/권한거부/저속 네트워크 시나리오 테스트

---

## 6) 아키텍처 & 폴더 구조

```
lib/
  app/
    router.dart                 # go_router 정의
    localization/              # intl + .arb
  core/
    config/app_config.dart
    utils/logger.dart
    error/failure.dart
  features/
    heritage/
      presentation/
        screens/
          home_screen.dart
          map_screen.dart
          list_screen.dart
          detail_screen.dart
          theme_screen.dart
          settings_screen.dart
        widgets/
          heritage_card.dart
          heritage_chip.dart
          language_toggle.dart
      application/             # State (Riverpod Notifier/Controller)
        heritage_controller.dart
        theme_controller.dart
        settings_controller.dart
      domain/
        entities/
          heritage.dart
          heritage_image.dart
          theme.dart
        repositories/          # abstract
          heritage_repository.dart
      infrastructure/
        datasources/
          heritage_remote_ds.dart
          heritage_local_ds.dart   # Supabase
          translation_ds.dart
        repositories/
          heritage_repository_impl.dart
    common/
      widgets/app_scaffold.dart
      services/geolocator_service.dart
      services/permission_service.dart
supabase/functions/translate-proxy/
```

---

## 7) 코딩 규약

* **Dart/Flutter**
  * Null-safety 필수, `late` 남용 금지
  * `freezed` 데이터 모델 사용, `copyWith`로 불변 유지
  * UI는 **Stateless/ConsumerWidget** 우선, 비즈로직은 `StateNotifier`
  * 위젯은 **작게 쪼개기**(Card/Chip/Map/Toggle 등)

* **명명 규칙**
  * 파일명: `snake_case.dart`
  * 클래스/위젯: `PascalCase`
  * 변수/함수: `camelCase`
  * Provider: `xxxControllerProvider`, State: `XxxState`

* **에러 처리**
  * 공통 `Failure` 타입으로 감싸고 UI에 스낵바/플레이스홀더 제공
  * 네트워크/권한 별 에러 메시지 구분

* **커밋 규약(Conventional Commits)**
  * `feat: 홈 지도와 하단시트 연결`
  * `fix: iOS 위치 권한 문구 수정`
  * `refactor: HeritageRepository 캐시 경로 단순화`
  * `chore: lint 설정 및 의존성 업데이트`

---

## 8) 데이터 모델(요약)

* `heritage`: id, name_ko, category, lat, lng, addr, designated_year, desc_ko, *(다국어 필드 선택)*
* `heritage_image`: (heritage_id, url, copyright)
* `theme`, `theme_map`
* `user_setting`: (user_id, lang, radius_km)
* `translation_cache`: (src_lang, dst_lang, src_text_hash, dst_text)

> 좌표 검색 최적화: PostGIS 사용 가능 시 geometry/GIN 인덱스, 초기엔 bbox 근사 검색.

---

## 9) API 계약(의사 스펙)

* **주변 탐색**: (임시) 리전/시군구 단위 조회 → 앱에서 거리 필터
  ```
  GET https://api.example/heritage/list
    ?serviceKey=...&areaCode=..&sigunguCode=..&pageNo=1&numOfRows=50&type=json
  → items: [{ id, nameKo, category, lat, lng, addr, designatedYear, descKo, images[] }]
  ```

* **상세**:
  ```
  GET https://api.example/heritage/detail
    ?serviceKey=...&id=...
  → { ...Heritage }
  ```

* **번역(Edge Function)**:
  ```
  POST /translate-proxy
  { srcLang: "ko", dstLang: "en"|"ja"|"zh", text: "<원문>" }
  → { translated: "<번역문>" }
  ```

> 실제 API 파라미터/필드명은 작업 단계에서 **명확히 맵핑**하고, 파서 단에 집중 반영.

---

## 10) 보안 / 환경 변수

* `.env` 예시
  ```
  SUPABASE_URL=...
  SUPABASE_ANON_KEY=...
  MAPS_IOS_API_KEY=...
  MAPS_ANDROID_API_KEY=...
  ```

* **금지**: 번역 API 키, 공공데이터포털 서비스키를 앱에 직접 하드코딩
  → Edge Function(예: `translate-proxy`) 또는 서버 프록시 경유

* Supabase RLS: `user_setting`은 사용자별 RLS 활성화. 공개 데이터 테이블은 읽기 공개 가능.

---

## 11) 상태/인터랙션 시나리오

* 앱 진입 → 위치 권한 요청
  * 승인: 현재 좌표로 `getNearby` 호출
  * 거부: 기본 지역(서울시청 좌표) + 안내 배너

* 지도 마커 탭 → 상세 화면 푸시
* 언어 토글 → 화면 텍스트 + 데이터 설명 재요청/캐시 반환
* 테마 칩 선택 → 테마별 문화재 로드 → 지도/리스트 반영

---

## 12) 요청 템플릿(Claude에게 줄 구체 지시)

### 12.1 홈 화면 뼈대
```
다음 요구로 홈 화면을 구현해줘:
- google_maps_flutter로 MapView 위젯 생성
- DraggableScrollableSheet로 카드 리스트(더미 10개)
- FAB: 현재 위치로 카메라 이동 (geolocator 연동)
- Riverpod StateNotifier로 nearby 목록·마커 상태 관리
- 파일은 presentation/screens/home_screen.dart, widgets/heritage_card.dart로 분리
```

### 12.2 리포지토리+캐시
```
HeritageRepository/Impl을 작성해줘:
- getNearby(lat,lng,radiusKm,lang): local bbox 조회 → 없으면 remote fetch → upsert → 거리 필터 후 반환
- getDetail(id,lang), getByTheme(themeCode,lang)도 포함
- Local은 Supabase 테이블 `heritage`, `heritage_image` 사용
- Translation은 별도 DataSource로 주입하고 lang != 'ko'면 번역 필드 채우기
```

### 12.3 번역 프록시 DataSource
```
dio로 /translate-proxy 호출하는 TranslationDataSource를 작성해줘.
- translate(String text, {String from='ko', required String to})
- 실패 시 원문 반환
- 간단한 in-memory LRU 캐시도 추가(최대 100개).
```

### 12.4 상세 화면
```
상세 화면(detail_screen.dart)을 구현해줘:
- 상단 이미지 PageView, 기본 메타 정보, 설명(언어별), 길찾기 버튼(구글/네이버 딥링크)
- id를 라우터 파라미터로 받고, 리포지토리에서 lazy load
- 로딩/에러/빈 상태 핸들링
```

---

## 13) 품질 체크리스트

* [ ] 네트워크 없을 때 UI 상태 안전
* [ ] 위치 권한 거부·제한 상태 처리
* [ ] 60fps 스크롤, 이미지 캐시
* [ ] Dart analyze/lint 무경고
* [ ] 다국어 토글 시 UI/데이터 동시 반영

---

## 14) 수락 기준(DoD)

* 홈에서 현재 위치 기준 **리스트/마커 동시 렌더**
* 상세에서 이미지/메타/설명/길찾기 동작
* 언어 토글 시 번역 캐시를 통해 **연속 토글에도** 지연 최소
* 네트워크/권한 문제 발생 시 UI가 **깨지지 않음**
* analyze/lint 경고 0, 런타임 오류 0

---

## 15) 자주 하는 실수 방지

* 위치 권한 iOS Info.plist/AndroidManifest 문구 누락 → **반드시 추가**
* dio 타임아웃/취소 토큰 없이 무한 대기 → **타임아웃/재시도** 설정
* 대량 마커로 프레임드랍 → 초기엔 근접 50~100개 제한 + 클러스터링 TODO
* 이미지 원본 링크 만료 → Storage 캐시 또는 대체 이미지 제공

---

## 16) 금지/주의

* [금지] 하드코딩된 API 키/서비스키 커밋
* [금지] 거대한 단일 파일(>400줄); 기능 단위 분리
* [주의] 과도한 rebuild; Provider scope 최소화
* [주의] 무제한 요청(번역/원격 API) → 디바운스/캐시 적용

---

## 17) 주요 패키지

* `flutter_riverpod`: 상태 관리
* `go_router`: 라우팅
* `dio`: HTTP 클라이언트
* `freezed`: 데이터 모델 생성
* `json_serializable`: JSON 직렬화
* `geolocator`: 위치 서비스
* `google_maps_flutter`: 지도
* `intl`: 국제화
* `cached_network_image`: 이미지 캐싱
* `supabase_flutter`: Supabase 연동
* `flutter_dotenv`: 환경변수 관리

---

## 18) 개발 체크리스트

- [ ] Supabase 프로젝트 생성 및 스키마 적용
- [ ] Flutter 프로젝트 초기 설정
- [ ] 환경변수 설정 (API 키 등)
- [ ] 위치 권한 처리 플로우
- [ ] 홈 지도 화면 구현
- [ ] 문화재 리스트 및 상세 화면
- [ ] 다국어 지원 구현
- [ ] 테마 기능 구현
- [ ] 스토어 배포 준비

---

## 19) 산출물 형식

* **PR**: 변경 요약, 스크린샷/GIF, 테스트 방법(시나리오) 포함
* **커밋**: Conventional Commits 규약
* **문서**: 새 API/엔드포인트/파라미터 변경 시 `CLAUDE.md` 하단 "변경이력" 업데이트

---

## 20) 변경 이력

* v0.1 (초기) — MVP 스켈레톤 규칙/흐름 정의
* v0.2 — 번역 프록시/캐시 지침 추가, 지도/리스트 상호작용 구체화
* v0.3 (2025-01-14) — cursorrules 내용 통합, 개발 원칙 및 코딩 규약 구체화

---

> **바로 시작하세요.** 의문점이 생기면 가정 명시 후 진행하고, PR 설명에 의사결정 근거를 남깁니다.