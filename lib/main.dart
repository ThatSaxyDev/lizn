import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/providers/current_user_notifier.dart';
import 'package:lizn/core/theme/theme.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/auth/view/pages/signup_view.dart';
import 'package:lizn/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lizn/features/base_nav/views/pages/base_nav_view.dart';
import 'package:lizn/features/home/views/pages/upload_podcast_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getUserData();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          title: 'Lizn',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkThemeMode,
          home: currentUser == null ? const SignupPage() : const BaseNavView(),
        );
      },
    );
  }
}
