// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:lizn/features/home/model/favourite_podcast_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;
  final List<FavouritePodcastModel> favouritePodcasts;
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.favouritePodcasts,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    List<FavouritePodcastModel>? favouritePodcasts,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      favouritePodcasts: favouritePodcasts ?? this.favouritePodcasts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'favourites':
          favouritePodcasts.map((podcast) => podcast.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      token: map["token"] ?? '',
      favouritePodcasts: map['favourites'] != null
          ? List<FavouritePodcastModel>.from(map['favourites']
              .map((podcast) => FavouritePodcastModel.fromMap(podcast)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, token: $token, favouritePodcasts: $favouritePodcasts)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.token == token &&
        listEquals(other.favouritePodcasts, favouritePodcasts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        token.hashCode ^
        favouritePodcasts.hashCode;
  }
}
