// ignore_for_file: avoid_public_notifier_properties
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/repositories/home_local_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';

part 'current_podcast_notifier.g.dart';

@riverpod
class CurrentPodcastNotifier extends _$CurrentPodcastNotifier {
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  late HomeLocalRepository _homeLocalRepository;
  @override
  PodcastModel? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  //! tap to play a podcast
  void updatePodcast({required PodcastModel podcast}) async {
    await audioPlayer?.stop();
    audioPlayer = AudioPlayer();

    final audioSource = AudioSource.uri(
      Uri.parse(podcast.podcastURL),
      tag: MediaItem(
        id: podcast.id,
        title: podcast.podcastName,
        artist: podcast.creatorName,
        artUri: Uri.parse(podcast.thumbnailURL),
      ),
    );

    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.playerStateStream.listen((PlayerState playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;

        state = state?.copyWith(hexCode: state?.hexCode);
      }
    });

    _homeLocalRepository.storePodcasts(podcast: podcast);

    audioPlayer!.play();
    isPlaying = true;
    state = podcast;
  }

  //! play and pause
  void playPause() {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(hexCode: state?.hexCode);
  }

  void seekTrack({required double value}) {
    audioPlayer!.seek(Duration(
        milliseconds: (value * audioPlayer!.duration!.inMilliseconds).toInt()));
  }
}
