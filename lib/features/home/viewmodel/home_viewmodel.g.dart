// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllPodcastsHash() => r'bbf80995a7cc444fe21ab5421e6ccbb49878196b';

/// See also [getAllPodcasts].
@ProviderFor(getAllPodcasts)
final getAllPodcastsProvider =
    AutoDisposeFutureProvider<List<PodcastModel>>.internal(
  getAllPodcasts,
  name: r'getAllPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllPodcastsRef = AutoDisposeFutureProviderRef<List<PodcastModel>>;
String _$getFavouritePodcastsHash() =>
    r'9f7c2b0f373f3278f5d7f99007ffdb7d7e969083';

/// See also [getFavouritePodcasts].
@ProviderFor(getFavouritePodcasts)
final getFavouritePodcastsProvider =
    AutoDisposeFutureProvider<List<PodcastModel>>.internal(
  getFavouritePodcasts,
  name: r'getFavouritePodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFavouritePodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFavouritePodcastsRef
    = AutoDisposeFutureProviderRef<List<PodcastModel>>;
String _$homeViewModelHash() => r'd79dd6a19095755fded30d20a37f38c844c0beb1';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
