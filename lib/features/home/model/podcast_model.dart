// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PodcastModel {
  final String id;
  final String podcastURL;
  final String thumbnailURL;
  final String podcastName;
  final String creatorId;
  final String creatorName;
  final String hexCode;
  const PodcastModel({
    required this.id,
    required this.podcastURL,
    required this.thumbnailURL,
    required this.podcastName,
    required this.creatorId,
    required this.creatorName,
    required this.hexCode,
  });

  PodcastModel copyWith({
    String? id,
    String? podcastURL,
    String? thumbnailURL,
    String? podcastName,
    String? creatorId,
    String? creatorName,
    String? hexCode,
  }) {
    return PodcastModel(
      id: id ?? this.id,
      podcastURL: podcastURL ?? this.podcastURL,
      thumbnailURL: thumbnailURL ?? this.thumbnailURL,
      podcastName: podcastName ?? this.podcastName,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      hexCode: hexCode ?? this.hexCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'podcast_url': podcastURL,
      'thumbnail_url': thumbnailURL,
      'podcast_name': podcastName,
      'creator_id': creatorId,
      'creator': creatorName,
      'hex_code': hexCode,
    };
  }

  factory PodcastModel.fromMap(Map<String, dynamic> map) {
    return PodcastModel(
      id: map["id"] ?? '',
      podcastURL: map["podcast_url"] ?? '',
      thumbnailURL: map["thumbnail_url"] ?? '',
      podcastName: map["podcast_name"] ?? '',
      creatorId: map["creator_id"] ?? '',
      creatorName: map["creator"] ?? '',
      hexCode: map["hex_code"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PodcastModel.fromJson(String source) =>
      PodcastModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PodcastModel(id: $id, podcastURL: $podcastURL, thumbnailURL: $thumbnailURL, podcastName: $podcastName, creatorId: $creatorId, creatorName: $creatorName, hexCode: $hexCode)';
  }

  @override
  bool operator ==(covariant PodcastModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.podcastURL == podcastURL &&
        other.thumbnailURL == thumbnailURL &&
        other.podcastName == podcastName &&
        other.creatorId == creatorId &&
        other.creatorName == creatorName &&
        other.hexCode == hexCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        podcastURL.hashCode ^
        thumbnailURL.hashCode ^
        podcastName.hashCode ^
        creatorId.hashCode ^
        creatorName.hashCode ^
        hexCode.hashCode;
  }
}
