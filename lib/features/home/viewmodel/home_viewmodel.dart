import 'dart:io';
import 'dart:ui';

import 'package:lizn/features/home/repositories/home_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
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

    final res = _homeRepository.uploadPodcast(
      selectedImage: selectedImage,
      selectedAudio: selectedAudio,
      podcastName: podcastName,
      creatorName: creatorName,
      hexCode: 'hexCode',
      creatorId: 'creatorId',
    );
  }
}
