/// 테마별 문화재 분류 데이터
/// 
/// 각 테마에 대한 분류 기준과 매핑 정보를 정의합니다.
class ThemeData {
  static const Map<String, Map<String, dynamic>> themeMapping = {
    'palace': {
      'code': 'TH001',
      'nameKo': '궁궐 탐방',
      'nameEn': 'Palace Tour',
      'subtitle': '조선의 왕실 문화',
      'description': '조선시대 왕실의 삶과 문화를 엿볼 수 있는 궁궐 문화재',
      'icon': 'palace',
      'color': 0xFFD32F2F, // dancheongRed
      'categories': ['국보', '보물', '사적'],
      'keywords': ['궁', '궐', '전', '당', '문', '왕', '조선'],
      'specificNames': [
        '경복궁', '창덕궁', '창경궁', '덕수궁', '경희궁',
        '종묘', '사직단', '운현궁', '남대문', '동대문'
      ],
      'expectedCount': 15,
    },
    'unesco': {
      'code': 'TH002',
      'nameKo': '세계유산',
      'nameEn': 'UNESCO Heritage',
      'subtitle': 'UNESCO 등재 문화재',
      'description': '유네스코가 인정한 인류의 소중한 문화유산',
      'icon': 'public',
      'color': 0xFF1976D2, // obangBlue
      'categories': ['세계유산', '세계기록유산', '세계무형유산'],
      'keywords': ['세계유산', 'UNESCO', '유네스코'],
      'specificNames': [
        '석굴암', '불국사', '해인사', '종묘', '창덕궁',
        '수원화성', '고인돌', '경주역사유적지구', '안동하회마을',
        '양동마을', '남한산성', '백제역사유적지구', '산사'
      ],
      'expectedCount': 14,
    },
    'village': {
      'code': 'TH003',
      'nameKo': '전통마을',
      'nameEn': 'Traditional Villages',
      'subtitle': '한옥과 고택의 정취',
      'description': '전통 건축과 마을 문화가 살아있는 민속마을',
      'icon': 'holiday_village',
      'color': 0xFF388E3C, // celadonGreen
      'categories': ['민속문화재', '중요민속자료', '사적'],
      'keywords': ['마을', '한옥', '고택', '종택', '서원', '향교'],
      'specificNames': [
        '안동하회마을', '경주양동마을', '아산외암마을', '순천낙안읍성',
        '고성왕곡마을', '성읍민속마을', '북촌한옥마을'
      ],
      'expectedCount': 12,
    },
    'buddhist': {
      'code': 'TH004',
      'nameKo': '불교 문화재',
      'nameEn': 'Buddhist Heritage',
      'subtitle': '사찰과 불탑',
      'description': '천년 불교 문화의 정수를 담은 사찰과 불교 유적',
      'icon': 'temple_buddhist',
      'color': 0xFF9C27B0, // purple
      'categories': ['국보', '보물', '사적'],
      'keywords': ['사', '절', '암', '탑', '불', '부처', '석굴', '대웅전', '보살'],
      'specificNames': [
        '불국사', '석굴암', '해인사', '통도사', '송광사',
        '백양사', '화엄사', '법주사', '마곡사', '선암사',
        '대흥사', '봉정사', '부석사', '금산사', '미황사'
      ],
      'expectedCount': 35,
    },
    'fortress': {
      'code': 'TH005',
      'nameKo': '산성과 성곽',
      'nameEn': 'Fortresses',
      'subtitle': '방어 유적지',
      'description': '외적을 막고 백성을 지킨 성곽과 산성',
      'icon': 'castle',
      'color': 0xFF795548, // brown
      'categories': ['사적', '국보', '보물'],
      'keywords': ['성', '산성', '읍성', '성곽', '성문', '문루', '치성', '옹성'],
      'specificNames': [
        '수원화성', '남한산성', '북한산성', '공산성', '부소산성',
        '낙안읍성', '해미읍성', '진주성', '동래읍성', '상당산성'
      ],
      'expectedCount': 20,
    },
    'intangible': {
      'code': 'TH006',
      'nameKo': '무형문화재',
      'nameEn': 'Intangible Heritage',
      'subtitle': '전통 기예와 문화',
      'description': '대대로 전승되어 온 무형의 문화유산',
      'icon': 'theater_comedy',
      'color': 0xFFFF6F00, // intangibleHeritage orange
      'categories': ['무형문화재', '중요무형문화재', '인간문화재'],
      'keywords': ['무형', '전통', '공예', '음악', '무용', '놀이', '의식'],
      'specificNames': [
        '판소리', '농악', '탈춤', '줄타기', '택견',
        '가곡', '가사', '처용무', '승무', '살풀이춤',
        '강강술래', '아리랑', '종묘제례악'
      ],
      'expectedCount': 25,
    },
  };

  /// 테마 코드로 테마 정보 가져오기
  static Map<String, dynamic>? getThemeByCode(String code) {
    return themeMapping.values.firstWhere(
      (theme) => theme['code'] == code,
      orElse: () => <String, dynamic>{},
    );
  }

  /// 문화재가 특정 테마에 속하는지 확인
  static bool belongsToTheme(String themeKey, {
    required String category,
    required String name,
    String? description,
  }) {
    final theme = themeMapping[themeKey];
    if (theme == null) return false;

    // 1. 카테고리 매칭
    final categories = theme['categories'] as List<String>;
    for (final cat in categories) {
      if (category.contains(cat)) return true;
    }

    // 2. 특정 이름 매칭
    final specificNames = theme['specificNames'] as List<String>;
    for (final specificName in specificNames) {
      if (name.contains(specificName)) return true;
    }

    // 3. 키워드 매칭
    final keywords = theme['keywords'] as List<String>;
    for (final keyword in keywords) {
      if (name.contains(keyword)) return true;
      if (description != null && description.contains(keyword)) return true;
    }

    return false;
  }

  /// 문화재가 속하는 모든 테마 찾기
  static List<String> findThemesForHeritage({
    required String category,
    required String name,
    String? description,
  }) {
    final themes = <String>[];
    
    for (final themeKey in themeMapping.keys) {
      if (belongsToTheme(
        themeKey,
        category: category,
        name: name,
        description: description,
      )) {
        themes.add(themeKey);
      }
    }
    
    return themes;
  }

  /// 모든 테마 코드 리스트
  static List<String> get allThemeCodes {
    return themeMapping.values
        .map((theme) => theme['code'] as String)
        .toList();
  }

  /// 테마 키로 테마 코드 가져오기
  static String? getThemeCode(String themeKey) {
    return themeMapping[themeKey]?['code'] as String?;
  }

  /// 테마 색상 가져오기
  static int getThemeColor(String themeKey) {
    return themeMapping[themeKey]?['color'] as int? ?? 0xFF757575;
  }
}