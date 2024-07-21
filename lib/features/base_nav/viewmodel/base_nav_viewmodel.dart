import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lizn/features/home/views/pages/upload_podcast_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

final baseNavStateNotifierProvider =
    NotifierProvider<BaseNavStateNotifier, int>(() {
  return BaseNavStateNotifier();
});

class BaseNavStateNotifier extends Notifier<int> {
  @override
  int build() => 0;

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavStateNotifierProvider.notifier).moveToPage(index: index);
}

List<Widget> pages = [
  const SizedBox(),
  const SizedBox(),
  const UploadSongView(),
];

//! nav widget enums
enum Nav {
  home(PhosphorIconsRegular.houseSimple, PhosphorIconsFill.houseSimple, 'Home'),
  search(PhosphorIconsRegular.magnifyingGlass,
      PhosphorIconsFill.magnifyingGlass, 'Search'),
  library(PhosphorIconsRegular.upload, PhosphorIconsFill.upload, 'My Library');

  const Nav(
    this.icon,
    this.selectedIcon,
    this.name,
  );
  final IconData icon;
  final IconData selectedIcon;
  final String name;
}

List<Nav> nav = [
  Nav.home,
  Nav.search,
  Nav.library,
];
