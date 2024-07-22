import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/providers/current_podcast_notifier.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/nav.dart';
import 'package:lizn/core/utils/utils.dart';
import 'package:lizn/core/widgets/image_loader.dart';
import 'package:lizn/features/home/model/podcast_model.dart';
import 'package:lizn/features/home/views/widgets/podcast_player.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CurrentPodcastBar extends ConsumerStatefulWidget {
  const CurrentPodcastBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CurrentPodcastBarState();
}

class _CurrentPodcastBarState extends ConsumerState<CurrentPodcastBar> {
  @override
  Widget build(BuildContext context) {
    PodcastModel? currentPodcast = ref.watch(currentPodcastNotifierProvider);
    CurrentPodcastNotifier currentPodcastNotifier =
        ref.read(currentPodcastNotifierProvider.notifier);
    if (currentPodcast == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        ColoredBox(
          color: Pallete.backgroundColor,
          child: AnimatedContainer(
            duration: 300.ms,
            height: 80.h,
            width: width(context),
            margin: 10.padH,
            padding: EdgeInsets.symmetric(vertical: 8.h).copyWith(left: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: hexToColor(hex: currentPodcast.hexCode),
                width: 2,
              ),
              gradient: LinearGradient(
                colors: [
                  hexToColor(hex: currentPodcast.hexCode).withOpacity(0.7),
                  hexToColor(hex: currentPodcast.hexCode).withOpacity(0.5),
                ],
              ),
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'thumbnail',
                  child: ImageLoader(
                    imageUrl: currentPodcast.thumbnailURL,
                    height: double.infinity,
                    width: 60.h,
                  ),
                ),
                8.sbW,
                SizedBox(
                  width: 170.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentPodcast.podcastName.txt16(
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      currentPodcast.creatorName.txt14(
                        fontWeight: FontWeight.w500,
                        color: Pallete.subtitleText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(PhosphorIconsBold.heart),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    currentPodcastNotifier.playPause();
                  },
                  icon: Icon(
                    currentPodcastNotifier.isPlaying
                        ? PhosphorIconsFill.pause
                        : PhosphorIconsFill.play,
                  ),
                ),
              ],
            ),
          ).fadeInFromBottom(delay: 0.ms, animatiomDuration: 100.ms),
        ),

        //! progress bar
        Positioned(
          bottom: 0,
          left: 18.w,
          child: Container(
            height: 2.5,
            width: width(context) - 40.w,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
        ),
        StreamBuilder(
            stream: currentPodcastNotifier.audioPlayer?.positionStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              }

              final position = snapshot.data;
              final duration = currentPodcastNotifier.audioPlayer!.duration;
              double value = 0.0;

              if (position != null && duration != null) {
                value = position.inMilliseconds / duration.inMilliseconds;
              }

              return Positioned(
                bottom: 0,
                child: Container(
                  height: 2.5,
                  width: value * (width(context) - 40.w),
                  margin: 18.padH,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              );
            }),
      ],
    ).tap(onTap: () {
      slideTo(
        context: context,
        view: const PodcastPlayer(),
      );
    });
  }
}
