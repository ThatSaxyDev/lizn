import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lizn/core/failure/failure.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/nav.dart';
import 'package:lizn/core/utils/snack_bar.dart';
import 'package:lizn/core/widgets/button.dart';
import 'package:lizn/features/auth/model/user_model.dart';
import 'package:lizn/features/auth/repositories/auth_remote_repository.dart';
import 'package:lizn/features/auth/view/pages/signup_view.dart';
import 'package:lizn/features/auth/view/widgets/custom_text_field.dart';
import 'package:lizn/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lizn/features/home/views/home_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> passwordVisible = false.notifier;

  void passwordVisibility() => passwordVisible.value = !passwordVisible.value;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    passwordVisible.dispose();
    super.dispose();
  }

  void nav() {
    goTo(context: context, view: const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          goToAndClearStack(context: context, view: const HomeView());
        },
        error: (error, s) {
          showSnackBar(
            context: context,
            theMessage: error.toString(),
            theType: NotificationType.failure,
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: 16.padH,
          child: Column(
            children: [
              180.sbH,
              'Login'.txt(
                size: 40.sp,
                fontWeight: FontWeight.bold,
              ),
              20.sbH,

              //! email input
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              12.sbH,

              //! password
              passwordVisible.sync(
                builder: (context, value, child) => CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscuretext: !passwordVisible.value,
                  maxLines: 1,
                  suffixIcon: Padding(
                    padding: 16.padH,
                    child: Icon(
                      passwordVisible.value
                          ? PhosphorIconsBold.eye
                          : PhosphorIconsRegular.eyeClosed,
                      color: passwordVisible.value
                          ? Pallete.gradient2
                          : Pallete.borderColor,
                    ),
                  ).tap(onTap: passwordVisibility),
                ),
              ),

              20.sbH,
              [
                _emailController,
                _passwordController,
              ].multiSync(
                builder: (context, child) {
                  bool validated = _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty;

                  return AnimatedButton(
                    isLoading: isLoading,
                    content: 'Log in'.txt16(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    color: switch (validated) {
                      true => null,
                      false => Pallete.gradient2.withOpacity(0.5)
                    },
                    onTap: () {
                      if (validated && !isLoading) {
                        ref.read(authViewModelProvider.notifier).loginUser(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                      }
                    },
                  );
                },
              ),
              15.sbH,
              //! already have an account
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 15.5.sp,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goTo(context: context, view: const SignupPage());
                        },
                      text: 'Sign up',
                      style: TextStyle(
                          fontSize: 15.5.sp,
                          color: Pallete.gradient2,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              16.sbH,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'By proceeding, you agree to our',
                      style: TextStyle(
                        color: const Color(0xFF667084),
                        fontSize: 15.sp,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: ' terms of service ',
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontSize: 15.sp,
                      ),
                    ),
                    const TextSpan(
                      text: 'and ',
                      style: TextStyle(
                        color: Color(0xFF667084),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: 'privacy policy',
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
