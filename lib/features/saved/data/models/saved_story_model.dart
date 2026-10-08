import '../../domain/entities/saved_story.dart';

class SavedStoryModel extends SavedStory {
  const SavedStoryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.coverUrl,
    required super.languageLabel,
    required super.readTime,
    required super.rating,
    required super.reviewCount,
    super.isSaved = true,
    super.status = SavedReadStatus.unread,
    super.savedAt,
  });

  factory SavedStoryModel.fromJson(Map<String, dynamic> json) {
    return SavedStoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverUrl: json['coverUrl'] as String,
      languageLabel: json['languageLabel'] as String,
      readTime: json['readTime'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isSaved: json['isSaved'] as bool? ?? true,
      status: SavedReadStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SavedReadStatus.unread,
      ),
      savedAt: json['savedAt'] != null
          ? DateTime.tryParse(json['savedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverUrl': coverUrl,
      'languageLabel': languageLabel,
      'readTime': readTime,
      'rating': rating,
      'reviewCount': reviewCount,
      'isSaved': isSaved,
      'status': status.name,
      'savedAt': savedAt?.toIso8601String(),
    };
  }

  factory SavedStoryModel.fromEntity(SavedStory entity) {
    return SavedStoryModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      coverUrl: entity.coverUrl,
      languageLabel: entity.languageLabel,
      readTime: entity.readTime,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      isSaved: entity.isSaved,
      status: entity.status,
      savedAt: entity.savedAt,
    );
  }
}
