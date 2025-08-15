# 🚀 기술 설계 & 구현 가이드 (Flutter + Supabase) ― “포켓 문화재 가이드” (MVP)

아래 내용은 **개발자가 즉시 코딩 가능한 수준**의 설계서입니다. Flutter 앱 구조, Supabase 스키마, API 연동, i18n/캐싱/보안, 화면별 위젯 구조까지 **마크다운**으로 정리했습니다.

---

## 0) 목표 요약 (MVP 범위 재확인)

* **주변 문화재 탐색**: 현재 위치 반경 **1\~5km** 내 문화재 카드/지도 표시
* **상세 정보**: 명칭·지정번호·유형·위치·설명·이미지
* **다국어**: ko 기본, en/ja/zh 번역 제공 (번역 캐시)
* **테마 추천**: “궁궐/세계유산/전통마을”… 사전 정의 코스 노출

> **데이터 공급원**: 공공데이터포털(문화재청/국가문화유산포털) + (보조) 한국관광공사 관광정보 API
> **지도**: `google_maps_flutter` 또는 `flutter_naver_map` 중 택1

---

## 1) 아키텍처 개요

```
Flutter App
 ├─ Presentation (UI)  : Screens, Widgets
 ├─ State Management   : Riverpod (or Bloc)
 ├─ Domain             : Entities, UseCases
 └─ Data               : Repositories, DataSources (Remote API + Supabase Cache)

Supabase (Postgres + Storage + Edge Functions)
 ├─ Tables: heritage, heritage_image, theme, user_setting, translation_cache
 ├─ Policies (RLS)
 ├─ Edge Functions: translate-proxy (번역 API 프록시), tiles-proxy(선택)
 └─ Storage: images/heritage (선택적 사전 캐시)
```

---

## 2) Flutter 프로젝트 구조안

```
lib/
  main.dart
  app/
    router.dart                // go_router 정의
    localization/              // intl + .arb
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
      application/             // State (Riverpod Notifier/Controller)
        heritage_controller.dart
        theme_controller.dart
        settings_controller.dart
      domain/
        entities/
          heritage.dart
          heritage_image.dart
          theme.dart
        repositories/          // abstract
          heritage_repository.dart
      infrastructure/
        datasources/
          heritage_remote_ds.dart
          heritage_local_ds.dart   // Supabase
          translation_ds.dart
        repositories/
          heritage_repository_impl.dart
    common/
      widgets/app_scaffold.dart
      services/geolocator_service.dart
      services/permission_service.dart
```

**권장 패키지**

* 상태관리: `flutter_riverpod`
* 라우팅: `go_router`
* 네트워킹: `dio` (+ `retrofit` 선택)
* 직렬화: `freezed`, `json_serializable`
* 위치: `geolocator`
* 지도: `google_maps_flutter` *(또는* `flutter_naver_map`)\*
* i18n: `intl`
* 로컬 캐시: Supabase(Postgres) + `shared_preferences`(경량 설정)

---

## 3) 데이터 모델 (Domain Entities)

```dart
// heritage.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'heritage.freezed.dart';
part 'heritage.g.dart';

@freezed
class Heritage with _$Heritage {
  const factory Heritage({
    required String id,            // 문화재 고유 ID (API 지정번호 기반)
    required String nameKo,
    String? nameEn,
    String? nameJa,
    String? nameZh,
    required String category,      // 유형(국보/보물/사적/시도유형문화재 등)
    required double lat,
    required double lng,
    String? addr,
    int? designatedYear,
    String? descKo,
    String? descEn,
    String? descJa,
    String? descZh,
    List<HeritageImage>? images,
  }) = _Heritage;

  factory Heritage.fromJson(Map<String, dynamic> json) => _$HeritageFromJson(json);
}

// heritage_image.dart
@freezed
class HeritageImage with _$HeritageImage {
  const factory HeritageImage({
    required String url,
    String? copyright, // 출처/저작권
    String? desc,
  }) = _HeritageImage;

  factory HeritageImage.fromJson(Map<String, dynamic> json) =>
      _$HeritageImageFromJson(json);
}
```

---

## 4) Supabase 스키마 (SQL)

> **주의**: 실제 컬럼명은 API 스펙에 맞춰 가감. 인덱스/좌표 검색 최적화 포함.

```sql
-- heritage: 문화재 기본
create table if not exists public.heritage (
  id text primary key,
  name_ko text not null,
  name_en text,
  name_ja text,
  name_zh text,
  category text not null,
  lat double precision not null,
  lng double precision not null,
  addr text,
  designated_year int,
  desc_ko text,
  desc_en text,
  desc_ja text,
  desc_zh text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 좌표 검색 최적화: PostGIS 사용 가능하면 geometry 추가 (권장)
-- PostGIS가 어려우면 lat/lng btree + 간단한 범위쿼리 사용
create index if not exists idx_heritage_lat on public.heritage (lat);
create index if not exists idx_heritage_lng on public.heritage (lng);
create index if not exists idx_heritage_category on public.heritage (category);

-- heritage_image: 이미지 다대일
create table if not exists public.heritage_image (
  heritage_id text references public.heritage(id) on delete cascade,
  url text not null,
  copyright text,
  desc text,
  idx int default 0,
  primary key (heritage_id, url)
);

-- theme: 추천 테마
create table if not exists public.theme (
  id uuid primary key default gen_random_uuid(),
  code text unique not null, -- ex) "palace", "unesco", "village"
  name_ko text not null,
  name_en text,
  name_ja text,
  name_zh text,
  desc_ko text,
  desc_en text,
  desc_ja text,
  desc_zh text
);

-- theme_map: 테마-문화재 매핑
create table if not exists public.theme_map (
  theme_id uuid references public.theme(id) on delete cascade,
  heritage_id text references public.heritage(id) on delete cascade,
  primary key (theme_id, heritage_id)
);

-- user_setting: 사용자 설정 (언어/반경 등)
create table if not exists public.user_setting (
  user_id uuid primary key references auth.users(id) on delete cascade,
  lang text default 'ko',
  radius_km int default 3
);

-- translation_cache: 번역 캐시
create table if not exists public.translation_cache (
  src_lang text not null,
  dst_lang text not null,
  src_text_hash text not null,        -- hash(src_text)
  dst_text text not null,
  created_at timestamptz default now(),
  primary key (src_lang, dst_lang, src_text_hash)
);
```

### RLS 정책 (예시)

```sql
alter table public.user_setting enable row level security;

create policy "users can read own settings"
on public.user_setting for select
to authenticated
using (auth.uid() = user_id);

create policy "users can upsert own settings"
on public.user_setting for insert
to authenticated
with check (auth.uid() = user_id);

create policy "users can update own settings"
on public.user_setting for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
```

> `heritage`, `theme` 등 공개 데이터는 **RLS 비활성화**(read-only 공개) 또는 **anon key read 허용**으로 단순화 가능.

---

## 5) 외부 API 연동 설계

> 문화재청/국가문화유산포털 API는 **키·포맷·파라미터**가 서비스마다 상이합니다. 아래는 **일반화된 패턴**이며, 실제 호출 시 해당 API 문서의 `serviceKey`, `numOfRows`, `pageNo`, `MobileOS`, `MobileApp`, `arrange`, `mapX/mapY/radius` 또는 `areaCode/sigunguCode` 등 **정확 파라미터로 치환**하세요.

### 5.1 원칙

* **앱 → Remote API** 직접 호출(초기엔 간단) + 응답을 Supabase에 **캐시/정규화**
* 번역은 \*\*Edge Function `translate-proxy`\*\*를 통해 호출 → `translation_cache` 저장
* 위치 기반은

  * (A) 문화재 API가 **좌표/반경 검색 지원** 시 해당 엔드포인트 사용
  * (B) 미지원 시: 행정구역/지역 코드로 1차 조회 → 앱에서 **거리 필터링**

### 5.2 Remote DataSource (Dio 예시)

```dart
class HeritageRemoteDataSource {
  final Dio _dio;
  HeritageRemoteDataSource(this._dio);

  Future<List<Heritage>> fetchByRegion({
    required String areaCode,
    String? sigunguCode,
    int page = 1,
    int pageSize = 50,
  }) async {
    final resp = await _dio.get(
      'https://api.example/heritage/list',
      queryParameters: {
        'serviceKey': '<API_KEY>',
        'areaCode': areaCode,
        'sigunguCode': sigunguCode,
        'pageNo': page,
        'numOfRows': pageSize,
        'type': 'json',
      },
    );
    // TODO: 응답 JSON을 Heritage 리스트로 매핑
    return parseHeritages(resp.data);
  }

  Future<Heritage?> fetchDetail({required String id}) async {
    final resp = await _dio.get(
      'https://api.example/heritage/detail',
      queryParameters: {
        'serviceKey': '<API_KEY>',
        'ccbaKdcd': /* 유형코드 */,
        'ccbaAsno': /* 지정번호 */,
        'ccbaCtcd': /* 시도코드 */,
        'type': 'json',
      },
    );
    return parseDetail(resp.data);
  }
}
```

> **TIP**: 초기엔 **리스트 API만** 가져와도 MVP 가능. 상세는 리스트의 `id`로 **지연 로딩**.

---

## 6) Repository & 캐싱 전략

```dart
abstract class HeritageRepository {
  Future<List<Heritage>> getNearby({
    required double lat,
    required double lng,
    required int radiusKm,
    String lang = 'ko',
  });

  Future<Heritage> getDetail(String id, {String lang = 'ko'});

  Future<List<Heritage>> getByTheme(String themeCode, {String lang = 'ko'});
}
```

```dart
class HeritageRepositoryImpl implements HeritageRepository {
  final HeritageRemoteDataSource remote;
  final HeritageLocalDataSource local; // Supabase
  final TranslationDataSource translator;

  HeritageRepositoryImpl(this.remote, this.local, this.translator);

  @override
  Future<List<Heritage>> getNearby({required double lat, required double lng, required int radiusKm, String lang = 'ko'}) async {
    // 1) Local 캐시(대략적 bbox/행정코드) 조회
    var cached = await local.queryByBoundingBox(lat, lng, radiusKm);
    if (cached.isNotEmpty) {
      return _translateIfNeeded(cached, lang);
    }

    // 2) Remote 호출 후 정규화 저장
    final fetched = await remote.fetchByRegion(areaCode: guessAreaCode(lat, lng));
    await local.upsertHeritages(fetched);

    // 3) 거리 필터링 후 반환
    final filtered = fetched.where((h) => distanceKm(lat, lng, h.lat, h.lng) <= radiusKm).toList();
    return _translateIfNeeded(filtered, lang);
  }

  @override
  Future<Heritage> getDetail(String id, {String lang = 'ko'}) async {
    final cached = await local.getById(id);
    if (cached != null) return _translateIfNeeded([cached], lang).then((v) => v.first);

    final detail = await remote.fetchDetail(id: id);
    if (detail == null) throw NotFoundFailure();
    await local.upsertHeritages([detail]);
    return _translateIfNeeded([detail], lang).then((v) => v.first);
  }

  Future<List<Heritage>> _translateIfNeeded(List<Heritage> items, String lang) async {
    if (lang == 'ko') return items;
    return Future.wait(items.map((h) async {
      final name = await translator.translate(h.nameKo ?? '', to: lang);
      final desc = await translator.translate(h.descKo ?? '', to: lang);
      return h.copyWith(
        nameEn: lang == 'en' ? name : h.nameEn,
        nameJa: lang == 'ja' ? name : h.nameJa,
        nameZh: lang == 'zh' ? name : h.nameZh,
        descEn: lang == 'en' ? desc : h.descEn,
        descJa: lang == 'ja' ? desc : h.descJa,
        descZh: lang == 'zh' ? desc : h.descZh,
      );
    }));
  }
}
```

---

## 7) Supabase Local DataSource (예시)

```dart
class HeritageLocalDataSource {
  final SupabaseClient supabase;
  HeritageLocalDataSource(this.supabase);

  Future<void> upsertHeritages(List<Heritage> items) async {
    final rows = items.map((h) => {
      'id': h.id,
      'name_ko': h.nameKo,
      'name_en': h.nameEn,
      'name_ja': h.nameJa,
      'name_zh': h.nameZh,
      'category': h.category,
      'lat': h.lat,
      'lng': h.lng,
      'addr': h.addr,
      'designated_year': h.designatedYear,
      'desc_ko': h.descKo,
      'desc_en': h.descEn,
      'desc_ja': h.descJa,
      'desc_zh': h.descZh,
    }).toList();

    await supabase.from('heritage').upsert(rows);
    // 이미지도 upsert (bulk)
  }

  Future<Heritage?> getById(String id) async {
    final row = await supabase.from('heritage').select('*')
      .eq('id', id).maybeSingle();
    if (row == null) return null;
    final imgs = await supabase.from('heritage_image').select('*')
      .eq('heritage_id', id).order('idx');
    return Heritage.fromJson({
      ...row,
      'images': imgs,
    });
  }

  Future<List<Heritage>> queryByBoundingBox(double lat, double lng, int radiusKm) async {
    // 단순 bbox (반경 근사) 예: lat±delta, lng±delta
    final delta = radiusKm / 111.0; // 위도 1도 ≈ 111km
    final rows = await supabase.from('heritage').select('*')
      .gte('lat', lat - delta)
      .lte('lat', lat + delta)
      .gte('lng', lng - delta)
      .lte('lng', lng + delta);
    return rows.map<Heritage>((e) => Heritage.fromJson(e)).toList();
  }
}
```

---

## 8) Edge Function: 번역 프록시 (의사코드)

> 외부 번역 API 키를 보호하고, `translation_cache`에 저장합니다.

```ts
// supabase/functions/translate-proxy/index.ts (Deno)
import { serve } from "std/http/server.ts";
import { createClient } from "supabase";
import { hash } from "./utils.ts";

serve(async (req) => {
  const { srcLang = "ko", dstLang, text } = await req.json();
  const supabase = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);

  const key = hash(text); // sha256 등
  const { data: cached } = await supabase.from("translation_cache")
    .select("dst_text").eq("src_lang", srcLang).eq("dst_lang", dstLang).eq("src_text_hash", key).maybeSingle();

  if (cached) return new Response(JSON.stringify({ translated: cached.dst_text }));

  // 실제 번역 API 호출
  const translated = await callTranslateAPI(text, srcLang, dstLang);

  await supabase.from("translation_cache").insert({
    src_lang: srcLang, dst_lang: dstLang, src_text_hash: key, dst_text: translated
  });

  return new Response(JSON.stringify({ translated }), { headers: { "content-type": "application/json" }});
});
```

Flutter에서 호출:

```dart
final resp = await dio.post(
  'https://<YOUR_SUPABASE_FUNCTION_URL>/translate-proxy',
  data: {'srcLang': 'ko', 'dstLang': 'en', 'text': source},
);
final translated = resp.data['translated'] as String;
```

---

## 9) i18n 설계

* 앱 UI 텍스트: `intl` + `arb`
* 데이터 설명: **ko 원문 → 번역 프록시** (캐시)
* 언어 토글: 상단 바/설정 화면에서 `ko/en/ja/zh`

**ARB 예시**

```json
// lib/app/localization/intl_en.arb
{
  "appTitle": "Pocket Heritage",
  "nearby": "Nearby",
  "themes": "Themes",
  "settings": "Settings",
  "distanceKm": "{value} km away"
}
```

---

## 10) 화면 설계 (위젯 구조 & 인터랙션)

### 10.1 홈/탐색(HomeScreen)

* **상단 AppBar**: 검색창(키워드), 언어 토글 버튼
* **본문**: 지도(MapView) + 하단 시트(주변 문화재 리스트)
* **FAB**: 현재 위치로 리센터
* **인터랙션**: 마커 탭 → `DetailScreen` 이동

구성 스니펫:

```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(heritageControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [LanguageToggle()],
      ),
      body: Stack(
        children: [
          HeritageMap(markers: state.markers),
          DraggableScrollableSheet(
            builder: (_, ctrl) => ListView.builder(
              controller: ctrl,
              itemCount: state.nearby.length,
              itemBuilder: (_, i) => HeritageCard(item: state.nearby[i]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(heritageControllerProvider.notifier).recenter(),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
```

### 10.2 리스트(ListScreen)

* 필터(거리/유형), 정렬(거리/이름)
* 카드형 리스트 → 상세로 이동

### 10.3 상세(DetailScreen)

* 대표 이미지 캐러셀
* 기본 정보(명칭/유형/지정연도/주소)
* 설명(언어별 자동 스위칭)
* 버튼: 지도 길찾기(네이버/구글 앱으로 딥링크)

### 10.4 테마(ThemeScreen)

* 테마 칩/카드 → 지도 + 리스트 연동
* 예: `palace`, `unesco`, `village` 등

### 10.5 설정(SettingsScreen)

* 언어 선택, 반경 설정(슬라이더)
* 데이터 초기화(캐시 삭제)

---

## 11) 상태 관리 (Riverpod 예시)

```dart
final heritageControllerProvider = StateNotifierProvider<HeritageController, HeritageState>(
  (ref) => HeritageController(ref.read(heritageRepositoryProvider)),
);

class HeritageController extends StateNotifier<HeritageState> {
  HeritageController(this.repo): super(HeritageState.initial());

  final HeritageRepository repo;

  Future<void> loadNearby(double lat, double lng, int radiusKm, String lang) async {
    state = state.copyWith(loading: true);
    final items = await repo.getNearby(lat: lat, lng: lng, radiusKm: radiusKm, lang: lang);
    state = state.copyWith(loading: false, nearby: items, markers: itemsToMarkers(items));
  }

  void recenter() {/* geolocator로 현재 위치 → loadNearby */}
}
```

---

## 12) 권한/에러/성능

* 위치 권한: `geolocator`로 요청, 거부 시 **지역 선택 모드** 제공
* 네트워크 에러: 스낵바 + 오프라인 캐시(최근 결과)
* 이미지 로딩: `cached_network_image`
* 성능:

  * 리스트는 `ListView.builder`
  * 지도 마커는 **클러스터링**(초기엔 단순화 가능)
  * 번역은 **지연 호출 + 캐시** 필수

---

## 13) 보안 & 레이트 리밋

* **번역 API 키는 클라이언트에 노출 금지** → Edge Function 프록시
* 공공데이터 API 키는 가능한 서버(Edge Function)에서 대리 호출 고려
* Supabase RLS: 사용자 설정 테이블 보호
* 캐시 만료 정책: 번역 180일, 문화재 기본 7\~30일(변경 적음)

---

## 14) 테마 설계(초기 내장)

```json
[
  {"code":"palace","name_ko":"궁궐 코스","name_en":"Palace Tour"},
  {"code":"unesco","name_ko":"세계유산","name_en":"UNESCO Sites"},
  {"code":"village","name_ko":"전통마을","name_en":"Folk Villages"}
]
```

`theme_map`은 초기 Seed로 수동 등록(운영툴은 추후).

---

## 15) 개발 체크리스트

* [ ] Supabase 프로젝트/테이블/정책/Edge Functions 배포
* [ ] Flutter 패키지 세팅 + 환경변수(`flutter_dotenv`)
* [ ] API 키 관리(.env & Edge Function)
* [ ] 위치 권한 플로우
* [ ] 홈 지도 + 주변 데이터 로드
* [ ] 상세화면 데이터 바인딩
* [ ] 언어 토글 + 번역 캐시 연동
* [ ] 테마 화면/필터
* [ ] 스토어 빌드 세팅(iOS/Android 권한 문구)

---

## 16) 일정(예시, 2주 스프린트)

* **W1**: 스키마/엣지 함수/기본 화면 뼈대, 위치/지도, 리스트
* **W2**: 상세/번역 캐시/테마, QA & 퍼포먼스, 테스트 빌드

---

## 17) 향후 확장 로드맵 (MVP 이후)

* **오디오 가이드(TTS)**, **AR 복원**, **퀘스트/포인트**, **리뷰/사진 UGC**
* **오프라인 지도 타일 캐시**, **접근성 개선(대체 텍스트/글자크기)**
* **운영툴(Admin)**: 테마/매핑/수정 이력 관리

---

## 18) 샘플: 길찾기 딥링크

```dart
// 구글맵
Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
// 네이버지도 (앱 설치 시)
Uri.parse('nmap://route/walk?dlat=$lat&dlng=$lng&dname=${Uri.encodeComponent(name)}');
```

---

## 19) 샘플: 거리 계산 (Haversine 근사)

```dart
double distanceKm(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0;
  final dLat = (lat2 - lat1) * (pi / 180);
  final dLon = (lon2 - lon1) * (pi / 180);
  final a = sin(dLat/2)*sin(dLat/2) +
            cos(lat1*pi/180)*cos(lat2*pi/180)*
            sin(dLon/2)*sin(dLon/2);
  final c = 2*atan2(sqrt(a), sqrt(1-a));
  return R * c;
}
```

---

# ✅ 다음 단계 제안

1. **실제 사용할 공공데이터 API 엔드포인트 & 필드 맵핑표**를 확정
2. **Supabase 프로젝트** 생성 및 위 스키마 적용
3. Flutter 패키지 세팅 & 홈 지도/주변 리스트부터 구현

원하시면 **실제 API 스펙(요청/응답 필드) 기준의 파라미터/파싱 코드**까지 바로 작성해 드릴게요.
또, **Cursor/Claude Code에 넣을 개발 프롬프트**도 준비해 드릴 수 있습니다.
