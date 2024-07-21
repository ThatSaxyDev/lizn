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
String _$homeViewModelHash() => r'50c6529e08802c84be6c27796d39582e4382806f';

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
