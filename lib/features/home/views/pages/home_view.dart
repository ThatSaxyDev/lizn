import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/providers/current_podcast_notifier.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/widgets/image_loader.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/viewmodel/home_viewmodel.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedPodcasts =
        ref.watch(homeViewModelProvider.notifier).getRecentlyPlayedPodcasts();
    ref.watch(currentPodcastNotifierProvider);
    return SafeArea(
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: Column(
          children: [
            if (recentlyPlayedPodcasts.isNotEmpty)
              SizedBox(
                height: 300.h,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w)
                      .copyWith(top: 20.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 200.w / 60.h,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                  ),
                  itemCount: recentlyPlayedPodcasts.length,
                  itemBuilder: (context, index) {
                    PodcastModel podcast = recentlyPlayedPodcasts[index];
                    return Container(
                      padding: EdgeInsets.only(right: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Pallete.cardColor,
                      ),
                      child: Row(
                        children: [
                          ImageLoader(
                            imageUrl: podcast.thumbnailURL,
                            width: 60.h,
                          ),
                          6.sbW,
                          Flexible(
                            child: podcast.podcastName.txt(
                              size: 13.sp,
                              fontWeight: FontWeight.w600,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ).tap(onTap: () {
                      ref
                          .read(currentPodcastNotifierProvider.notifier)
                          .updatePodcast(podcast: podcast);
                    });
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 16.w),
              child: 'Lastest'
                  .txt24(
                    fontWeight: FontWeight.w700,
                  )
                  .alignCenterLeft(),
            ),
            ref.watch(getAllPodcastsProvider).when(
              data: (List<PodcastModel> podcasts) {
                if (podcasts.isEmpty) {
                  return 'There are no podcasts'.txt18();
                }

                podcasts.log();
                return SizedBox(
                  height: 300.h,
                  child: ListView.separated(
                    itemCount: podcasts.length,
                    padding: 16.padH,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => 16.sbW,
                    itemBuilder: (context, index) {
                      PodcastModel podcast = podcasts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageLoader(
                            imageUrl: podcast.thumbnailURL,
                            height: 180.h,
                            width: 180.w,
                          ),
                          5.sbH,
                          SizedBox(
                            width: 180.h,
                            child: podcast.podcastName.txt16(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: 180.h,
                            child: podcast.creatorName.txt14(
                              color: Pallete.subtitleText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ).tap(onTap: () {
                        ref
                            .read(currentPodcastNotifierProvider.notifier)
                            .updatePodcast(podcast: podcast);
                      });
                    },
                  ),
                );
              },
              error: (error, stacktrace) {
                return Center(
                  child: error.toString().txt16(),
                );
              },
              loading: () {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              },
            ),
          ],
        ),
      ),
    );
  }
}
