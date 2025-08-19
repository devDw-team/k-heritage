import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';

/// 설정 화면
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _selectedLanguage = 'ko';
  double _searchRadius = 3.0;
  bool _enableNotifications = true;
  bool _enableNearbyAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          // 언어 설정 섹션
          _buildSection(
            title: '언어 설정',
            children: [
              _buildLanguageSelector(),
            ],
          ),
          
          // 탐색 설정 섹션
          _buildSection(
            title: '탐색 설정',
            children: [
              _buildRadiusSlider(),
              _buildOfflineMapTile(),
            ],
          ),
          
          // 알림 설정 섹션
          _buildSection(
            title: '알림 설정',
            children: [
              _buildSwitchTile(
                title: '주변 문화재 알림',
                subtitle: '근처에 문화재가 있을 때 알려드립니다',
                value: _enableNearbyAlerts,
                onChanged: (value) {
                  setState(() {
                    _enableNearbyAlerts = value;
                  });
                },
              ),
              _buildSwitchTile(
                title: '이벤트 알림',
                subtitle: '문화재 관련 이벤트 소식을 받아보세요',
                value: _enableNotifications,
                onChanged: (value) {
                  setState(() {
                    _enableNotifications = value;
                  });
                },
              ),
            ],
          ),
          
          // 앱 정보 섹션
          _buildSection(
            title: '앱 정보',
            children: [
              _buildInfoTile(
                title: '버전',
                trailing: '1.0.0',
              ),
              _buildInfoTile(
                title: '오픈소스 라이선스',
                onTap: () {
                  // TODO: 라이선스 화면 표시
                },
              ),
              _buildInfoTile(
                title: '개인정보 처리방침',
                onTap: () {
                  // TODO: 개인정보 처리방침 페이지 열기
                },
              ),
              _buildInfoTile(
                title: '서비스 이용약관',
                onTap: () {
                  // TODO: 이용약관 페이지 열기
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.grayMedium,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.grayLight),
              bottom: BorderSide(color: AppColors.grayLight),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    final languages = [
      {'code': 'ko', 'name': '한국어'},
      {'code': 'en', 'name': 'English'},
      {'code': 'zh', 'name': '中文'},
      {'code': 'ja', 'name': '日本語'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '앱 언어',
            style: AppTypography.bodyMedium,
          ),
          Row(
            children: languages.map((lang) {
              final isSelected = _selectedLanguage == lang['code'];
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang['code']!;
                    });
                  },
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.obangBlue
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.obangBlue
                            : AppColors.grayLight,
                      ),
                    ),
                    child: Text(
                      lang['name']!,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.baekjaWhite
                            : AppColors.grayDark,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '탐색 반경',
                style: AppTypography.bodyMedium,
              ),
              Text(
                '${_searchRadius.toStringAsFixed(0)}km',
                style: AppTypography.numberMedium.copyWith(
                  color: AppColors.celadonGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.celadonGreen,
              inactiveTrackColor: AppColors.grayLight,
              thumbColor: AppColors.surface,
              overlayColor: AppColors.celadonGreen.withOpacity(0.1),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 2,
              ),
            ),
            child: Slider(
              value: _searchRadius,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  _searchRadius = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineMapTile() {
    return ListTile(
      title: Text(
        '오프라인 지도',
        style: AppTypography.bodyMedium,
      ),
      trailing: ElevatedButton(
        onPressed: () {
          // TODO: 오프라인 지도 다운로드
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.obangBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        child: const Text('다운로드'),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.bodyMedium,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grayMedium,
              ),
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.celadonGreen,
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    String? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.bodyMedium,
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.grayMedium,
              ),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.grayMedium,
            ),
      onTap: onTap,
    );
  }
}