import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lizn/core/providers/current_podcast_notifier.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/nav.dart';
import 'package:lizn/core/widgets/image_loader.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/viewmodel/home_viewmodel.dart';
import 'package:lizn/features/home/views/pages/upload_podcast_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: 'Library'.txt18(),
      ),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: ref.watch(getFavouritePodcastsProvider).when(
          data: (List<PodcastModel> favourites) {
            if (favourites.isEmpty) {
              return Center(
                child: 'Nothing to seee here'.toString().txt16(),
              );
            }
            return ListView.separated(
              itemCount: favourites.length + 1,
              separatorBuilder: (context, i) => 20.sbH,
              itemBuilder: (context, index) {
                if (index == favourites.length) {
                  return ListTile(
                    onTap: () {
                      goTo(context: context, view: const UploadSongView());
                    },
                    leading: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Pallete.backgroundColor,
                      child: Icon(PhosphorIconsBold.plus),
                    ),
                    title: 'Upload new podcast'.txt16(),
                  );
                }
                final podcast = favourites[index];
                return ListTile(
                  onTap: () {
                    ref
                        .read(currentPodcastNotifierProvider.notifier)
                        .updatePodcast(podcast: podcast);
                  },
                  leading: ImageLoader(imageUrl: podcast.thumbnailURL),
                  title: podcast.podcastName.txt16(),
                  subtitle: podcast.creatorName.txt16(),
                );
              },
            );
          },
          error: (error, stacktrace) {
            return Center(
              child: error.toString().txt16(),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
