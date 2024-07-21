import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/providers/current_user_notifier.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/base_nav/viewmodel/base_nav_viewmodel.dart';
import 'package:lizn/features/base_nav/views/widgets/nav_bar_widget.dart';
import 'package:lizn/features/home/views/widgets/current_podcast_bar.dart';

class BaseNavView extends ConsumerWidget {
  const BaseNavView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavStateNotifierProvider);
    return Scaffold(
      // pages
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            pages[indexFromController],
            const CurrentPodcastBar().alignBottomCenter(),
          ],
        ),
      ),

      // nav bar
      bottomNavigationBar: Material(
        elevation: 5,
        child: Container(
          color: Pallete.backgroundColor,
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          height: 80.h,
          width: width(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              nav.length,
              (index) => NavBarWidget(nav: nav[index]),
            ),
          ),
        ),
      ),
    );
  }
}
