// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouritePodcastModel {
  final String id;
  final String podcastId;
  final String userId;
  const FavouritePodcastModel({
    required this.id,
    required this.podcastId,
    required this.userId,
  });

  FavouritePodcastModel copyWith({
    String? id,
    String? podcastId,
    String? userId,
  }) {
    return FavouritePodcastModel(
      id: id ?? this.id,
      podcastId: podcastId ?? this.podcastId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'podcast_id': podcastId,
      'user_id': userId,
    };
  }

  factory FavouritePodcastModel.fromMap(Map<String, dynamic> map) {
    return FavouritePodcastModel(
      id: map["id"] ?? '',
      podcastId: map["podcast_id"] ?? '',
      userId: map["user_id"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouritePodcastModel.fromJson(String source) =>
      FavouritePodcastModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavouritePodcastModel(id: $id, podcastId: $podcastId, userId: $userId)';

  @override
  bool operator ==(covariant FavouritePodcastModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.podcastId == podcastId &&
        other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ podcastId.hashCode ^ userId.hashCode;
}
