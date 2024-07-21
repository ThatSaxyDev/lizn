// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:lizn/core/constants/server_constants.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/repositories/auth_local_repository.dart';

part 'home_repositories.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(
    authLocalRepository: ref.watch(authLocalRepositoryProvider),
  );
}

class HomeRepository {
  final AuthLocalRepository _authLocalRepository;
  HomeRepository({
    required AuthLocalRepository authLocalRepository,
  }) : _authLocalRepository = authLocalRepository;

  //! upload podcast
  FutureEither<String> uploadPodcast({
    required File selectedImage,
    required File selectedAudio,
    required String podcastName,
    required String creatorName,
    required String hexCode,
    required String creatorId,
  }) async {
    try {
      final token = _authLocalRepository.getToken();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstants.serverUrl}/podcasts/upload'),
      );

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('podcast', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
        ])
        ..fields.addAll({
          'creator': creatorName,
          'podcast_name': podcastName,
          'hex_code': hexCode,
          'creator_id': creatorId
        })
        ..headers.addAll({
          'x-auth-token': token!,
        });

      final res = await request.send();

      String responseStream = await res.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      responseInMap.toString().log();

      if (res.statusCode != 201) {
        return Left(AppFailure(message: responseInMap['message']));
      }

      return Right(responseInMap['message']);
    } catch (e) {
      e.log();
      return Left(AppFailure(message: e.toString()));
    }
  }

  //! get all podcasts
  FutureEither<List<PodcastModel>> getAllPodcasts() async {
    try {
      final token = _authLocalRepository.getToken();
      final res = await http.get(
        Uri.parse('${ServerConstants.serverUrl}/podcasts/get-all-podcasts'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token!,
        },
      );

      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode != 200) {
        return Left(AppFailure(message: resBodyMap['message']));
      }

      List<PodcastModel> podcasts = [];

      for (final map in resBodyMap['podcasts']) {
        podcasts.add(PodcastModel.fromMap(map));
      }

      return Right(podcasts);
    } catch (e) {
      e.log();
      return Left(AppFailure(message: e.toString()));
    }
  }
}
