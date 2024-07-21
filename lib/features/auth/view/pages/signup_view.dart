import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/typedefs/type_defs.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/nav.dart';
import 'package:lizn/core/utils/regex.dart';
import 'package:lizn/core/utils/snack_bar.dart';
import 'package:lizn/core/widgets/button.dart';
import 'package:lizn/features/auth/view/pages/login_view.dart';
import 'package:lizn/features/auth/view/widgets/custom_text_field.dart';
import 'package:lizn/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lizn/features/base_nav/views/pages/base_nav_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> passwordVisible = false.notifier;
  final ValueNotifier<bool> confirmPasswordVisible = false.notifier;

  void passwordVisibility() => passwordVisible.value = !passwordVisible.value;

  void confirmPasswordVisibility() =>
      confirmPasswordVisible.value = !confirmPasswordVisible.value;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    passwordVisible.dispose();
    confirmPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(
            context: context,
            theMessage: 'Account created',
            theType: NotificationType.success,
          );

          goToAndClearStack(context: context, view: const BaseNavView());
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
              'Sign Up'.txt(
                size: 40.sp,
                fontWeight: FontWeight.bold,
              ),
              20.sbH,

              //! name input
              CustomTextField(
                controller: _nameController,
                hintText: 'Name',
              ),
              12.sbH,

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

              12.sbH,

              //! confirm password
              confirmPasswordVisible.sync(
                builder: (context, value, child) => CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscuretext: !confirmPasswordVisible.value,
                  maxLines: 1,
                  suffixIcon: Padding(
                    padding: 16.padH,
                    child: Icon(
                      confirmPasswordVisible.value
                          ? PhosphorIconsBold.eye
                          : PhosphorIconsRegular.eyeClosed,
                      color: confirmPasswordVisible.value
                          ? Pallete.gradient2
                          : Pallete.borderColor,
                    ),
                  ).tap(onTap: confirmPasswordVisibility),
                ),
              ),

              20.sbH,

              [
                _nameController,
                _emailController,
                _passwordController,
                _confirmPasswordController,
              ].multiSync(
                builder: (context, child) {
                  bool validated = _emailController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      AppRegEx.regexPassword
                          .hasMatch(_passwordController.text) &&
                      _passwordController.text ==
                          _confirmPasswordController.text;
                  return AnimatedButton(
                    isLoading: isLoading,
                    color: switch (validated) {
                      true => null,
                      false => Pallete.gradient2.withOpacity(0.5)
                    },
                    content: 'Get Started'.txt16(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      if (validated && !isLoading) {
                        ref.read(authViewModelProvider.notifier).signUpUser(
                              name: _nameController.text.trim(),
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
                  text: 'Already have an account? ',
                  style: TextStyle(
                    fontSize: 15.5.sp,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goTo(context: context, view: const LoginView());
                        },
                      text: 'Log in',
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
