import 'package:design_pattern/core/networking/provider.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:design_pattern/features/login/ui/widgets/remember_me_with_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_btn_social.dart';
import '../../../core/widgets/app_text_divider.dart';
import '../../../core/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final loginProvider = UserProvider(); // Singleton instance
    try {
      await loginProvider.login(emailController.text, passwordController.text);
      homeNavigate();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void homeNavigate() {
    Navigator.pushReplacementNamed(context, Routes.homeStateScreen);
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),
                  // Logo Section
                  Image.asset(
                    'assets/images/logoBrown.png',
                    height: 100.h,
                    width: 100.w,
                  ),
                  SizedBox(height: 40.h),
                  // Email TextField
                  AppTextField(
                    prefixIcon: Icons.email_outlined,
                    controller: emailController,
                    hintText: "example@gmail.com",
                    isPassword: false,
                  ),
                  SizedBox(height: 20.h),
                  // Password TextField
                  AppTextField(
                    isPassword: true,
                    controller: passwordController,
                    hintText: "password",
                    prefixIcon: Icons.lock_outline,
                  ),
                  // Forgot Password
                  const RememberMeWithForgetPassword(),
                  SizedBox(height: 20.h),
                  // Sign-In Button
                  AppTextBtn(
                    buttonText: "Sign in",
                    textStyle: MyTextStyle.font18WhiteSemiBold,
                    onPressed: login,
                  ),
                  SizedBox(height: 10),
                  // Register Now Link
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.signUpScreen);
                    },
                    child: const Text(
                      "Don't have an account? Register now",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // OR Divider
                  const DividerWithText(text: "OR"),
                  SizedBox(height: 20.h),
                  // Social Login Buttons
                  SocialLoginButton(
                    icon: Icons.apple,
                    text: 'Continue with Apple',
                    onPressed: () {
                      // Add Apple login action
                    },
                  ),
                  SizedBox(height: 10.h),
                  SocialLoginButton(
                    icon: Icons.g_mobiledata,
                    text: 'Continue with Google',
                    onPressed: () {
                      // Add Google login action
                    },
                  ),
                ],
              ),
            ),
          ),
          if (loginProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

