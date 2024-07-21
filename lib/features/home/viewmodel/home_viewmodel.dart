import 'dart:io';
import 'dart:ui';

import 'package:fpdart/fpdart.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/providers/current_user_notifier.dart';
import 'package:lizn/core/utils/utils.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/repositories/home_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<PodcastModel>> getAllPodcasts(GetAllPodcastsRef ref) async {
  final res = await ref.watch(homeRepositoryProvider).getAllPodcasts();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late UserModel? _currentUser;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _currentUser = ref.watch(currentUserNotifierProvider);
    return null;
  }

  Future<void> uploadPodcast({
    required File selectedImage,
    required File selectedAudio,
    required String podcastName,
    required String creatorName,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();

    final res = await _homeRepository.uploadPodcast(
      selectedImage: selectedImage,
      selectedAudio: selectedAudio,
      podcastName: podcastName,
      creatorName: creatorName,
      hexCode: rgbToHex(color: selectedColor),
      creatorId: _currentUser!.id,
    );

    final val = switch (res) {
      Left(value: AppFailure l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: String r) => state = AsyncValue.data(r),
    };

    print(val);
  }
}
