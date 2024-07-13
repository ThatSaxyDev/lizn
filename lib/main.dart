import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/theme.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/auth/view/pages/signup_view.dart';
import 'package:lizn/features/auth/viewmodel/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ProviderContainer container = ProviderContainer();
  UserModel? userModel =
      await container.read(authViewModelProvider.notifier).getUserData();
  print(userModel.toString());
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          home: const SignupPage(),
        );
      },
    );
  }
}
