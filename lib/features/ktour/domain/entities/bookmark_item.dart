import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_item.freezed.dart';
part 'bookmark_item.g.dart';

/// 북마크 아이템 엔티티
@freezed
class BookmarkItem with _$BookmarkItem {
  const factory BookmarkItem({
    required String contentId,
    required int contentTypeId,
    required String title,
    String? address1,
    String? address2,
    double? mapX,
    double? mapY,
    String? firstImage,
    String? firstImage2,
    String? tel,
    String? overview,
    required DateTime bookmarkedAt,
    @Default('attraction') String bookmarkType, // attraction, festival, stay 등
  }) = _BookmarkItem;

  factory BookmarkItem.fromJson(Map<String, dynamic> json) =>
      _$BookmarkItemFromJson(json);
}