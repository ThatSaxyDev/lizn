import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/providers/current_podcast_notifier.dart';
import 'package:lizn/core/providers/current_user_notifier.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/nav.dart';
import 'package:lizn/core/utils/snack_bar.dart';
import 'package:lizn/core/utils/utils.dart';
import 'package:lizn/core/widgets/image_loader.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/viewmodel/home_viewmodel.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PodcastPlayer extends ConsumerWidget {
  const PodcastPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PodcastModel? currentPodcast = ref.watch(currentPodcastNotifierProvider);
    CurrentPodcastNotifier currentPodcastNotifier =
        ref.read(currentPodcastNotifierProvider.notifier);

    final userFavouritePodcasts = ref.watch(
        currentUserNotifierProvider.select((data) => data!.favouritePodcasts));

    if (currentPodcast == null) {
      return const Scaffold();
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          height: height(context),
          width: width(context),
          padding: 24.padH,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexToColor(hex: currentPodcast.hexCode).withOpacity(0.6),
                hexToColor(hex: currentPodcast.hexCode).withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                child: Icon(
                  PhosphorIconsBold.caretDown,
                  size: 30.sp,
                ).alignCenterLeft(),
              ).tap(onTap: () => goBack(context)),
              Hero(
                tag: 'thumbnail',
                child: ImageLoader(
                  imageUrl: currentPodcast.thumbnailURL,
                  height: width(context) - 48.w,
                  width: width(context),
                ),
              ),
              30.sbH,

              //! podcast name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      currentPodcast.podcastName.txt24(
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      //! name
                      currentPodcast.creatorName.txt18(
                        fontWeight: FontWeight.w500,
                        color: Pallete.subtitleText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  //! favourite
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Icon(
                      userFavouritePodcasts
                              .where(
                                  (fav) => fav.podcastId == currentPodcast.id)
                              .toList()
                              .isNotEmpty
                          ? PhosphorIconsFill.heart
                          : PhosphorIconsBold.heart,
                      size: 30.sp,
                    ).alignCenterLeft(),
                  ).tap(onTap: () {
                    ref.read(homeViewModelProvider.notifier).favouritePodcast(
                          podcastId: currentPodcast.id,
                          onSuccess: (message) {
                            showBanner(
                              context: context,
                              theMessage: message,
                              theType: NotificationType.info,
                            );
                          },
                        );
                  }),
                ],
              ),
              20.sbH,

              //! PROGRESS INDICATOR
              StreamBuilder(
                  stream: currentPodcastNotifier.audioPlayer?.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }

                    final position = snapshot.data;
                    final duration =
                        currentPodcastNotifier.audioPlayer!.duration;
                    double value = 0.0;

                    if (position != null && duration != null) {
                      value = position.inMilliseconds / duration.inMilliseconds;
                    }

                    return Column(
                      children: [
                        StatefulBuilder(
                          builder: (context, setState) {
                            return SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTickMarkColor:
                                    Colors.white.withOpacity(0.12),
                                thumbColor: Colors.white,
                                trackHeight: 3.5,
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: value,
                                min: 0,
                                max: 1,
                                onChanged: (val) {
                                  value = val;
                                  setState(() {});
                                },
                                onChangeEnd: (val) {
                                  currentPodcastNotifier.seekTrack(value: val);
                                },
                              ),
                            );
                          },
                        ),

                        2.sbH,

                        //! duration
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            '${position?.inMinutes.toString()}:${(position?.inSeconds.remainder(60)).toString().padLeft(2, '0')}'
                                .txt14(
                              color: Pallete.subtitleText,
                            ),
                            '${duration?.inMinutes.toString()}:${(duration?.inSeconds.remainder(60)).toString().padLeft(2, '0')}'
                                .txt14(
                              color: Pallete.subtitleText,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),

              10.sbH,

              //! controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    iconSize: 40.sp,
                    icon: const Icon(
                      PhosphorIconsFill.skipBack,
                      color: Colors.white,
                    ),
                  ),
                  15.sbW,
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      currentPodcastNotifier.playPause();
                    },
                    iconSize: 90.sp,
                    icon: Icon(
                      currentPodcastNotifier.isPlaying
                          ? PhosphorIconsFill.pauseCircle
                          : PhosphorIconsFill.playCircle,
                      color: Colors.white,
                    ),
                  ),
                  15.sbW,
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    iconSize: 40.sp,
                    icon: const Icon(
                      PhosphorIconsFill.skipForward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
