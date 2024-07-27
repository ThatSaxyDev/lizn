import 'dart:io';
import 'dart:ui';

import 'package:fpdart/fpdart.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/providers/current_user_notifier.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/utils.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/home/model/favourite_podcast_model.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/repositories/home_local_repositories.dart';
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
Future<List<PodcastModel>> getFavouritePodcasts(
    GetFavouritePodcastsRef ref) async {
  final res = await ref.watch(homeRepositoryProvider).getFavouritePodcasts();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late UserModel? _currentUser;
  late HomeLocalRepository _homeLocalRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _currentUser = ref.watch(currentUserNotifierProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadPodcast({
    required File selectedImage,
    required File selectedAudio,
    required String podcastName,
    required String creatorName,
    required Color selectedColor,
    required Function(String)? onError,
    required Function()? onSuccess,
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
      Left(value: AppFailure l) => {
          state = AsyncValue.error(l.message, StackTrace.current),
          onError!(l.message),
        },
      Right(value: String r) => {
          state = AsyncValue.data(r),
          onSuccess!(),
        },
    };

    val.log();
  }

  //! get recently playe songs from local storage
  List<PodcastModel> getRecentlyPlayedPodcasts() {
    return _homeLocalRepository.fetchPodcasts();
  }

  Future<void> favouritePodcast({
    required String podcastId,
    required Function(String)? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    final res = await _homeRepository.favouritePodcast(
      podcastId: podcastId,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => {
          onSuccess!(r),
          _favouritePodcastSuccess(r, podcastId)
        },
    };

    val.log();
  }

  AsyncValue _favouritePodcastSuccess(
    String isFavouritedMessage,
    String podcastId,
  ) {
    final userNotifer = ref.read(currentUserNotifierProvider.notifier);
    if (isFavouritedMessage == 'Added to favourites') {
      userNotifer.addUser(ref.read(currentUserNotifierProvider)!.copyWith(
        favouritePodcasts: [
          ...ref.read(currentUserNotifierProvider)!.favouritePodcasts,
          FavouritePodcastModel(
            id: '',
            podcastId: podcastId,
            userId: '',
          )
        ],
      ));
    } else {
      userNotifer.addUser(ref.read(currentUserNotifierProvider)!.copyWith(
            favouritePodcasts: ref
                .read(currentUserNotifierProvider)!
                .favouritePodcasts
                .where((fav) => fav.podcastId != podcastId)
                .toList(),
          ));
    }
    ref.invalidate(getFavouritePodcastsProvider);
    return state = AsyncValue.data(isFavouritedMessage);
  }
}
