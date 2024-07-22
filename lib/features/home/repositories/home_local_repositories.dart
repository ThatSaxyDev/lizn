import 'package:hive/hive.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_local_repositories.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(HomeLocalRepositoryRef ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box box = Hive.box();

  //! store podcast in local storage
  void storePodcasts({required PodcastModel podcast}) {
    box.put(podcast.id, podcast.toJson());
  }

  //! fetch podcasts from local storage
  List<PodcastModel> fetchPodcasts() {
    List<PodcastModel> podcasts = [];

    for (final key in box.keys) {
      podcasts.add(PodcastModel.fromJson(box.get(key)));
    }

    return podcasts;
  }
}
