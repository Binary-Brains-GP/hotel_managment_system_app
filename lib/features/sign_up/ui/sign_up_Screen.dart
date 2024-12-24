import 'package:design_pattern/core/networking/provider.dart';
import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/theming/styles.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:design_pattern/core/widgets/app_text_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_btn_social.dart';
import '../../../core/widgets/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Use the Singleton instance of UserProvider
        final signProvider = UserProvider();
        await signProvider.signUp(
          nameController.text,
          emailController.text,
          passwordController.text,
        );
        homeNavigate();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void homeNavigate() {
    Navigator.pushReplacementNamed(context, Routes.homeStateScreen);
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logoBrown.png', // Replace with your logo asset
                        width: 100.h,
                        height: 100.w,
                      ),
                      SizedBox(height: 20.h),
                      // Name Field
                      AppTextField(
                        controller: nameController,
                        hintText: 'Your Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email Field
                      AppTextField(
                        controller: emailController,
                        hintText: 'example@gmail.com',
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email cannot be empty';
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Password Field
                      AppTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      // Sign-Up Button
                      AppTextBtn(
                        buttonText: "Sign up",
                        onPressed: signUp,
                        textStyle: MyTextStyle.font18WhiteSemiBold,
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.loginScreen);
                        },
                        child: const Text(
                          'Have an account? Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: MyColors.mainBrown,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // OR Divider
                      const DividerWithText(text: "OR"),
                      SizedBox(height: 20.h),
                      SocialLoginButton(
                        icon: Icons.apple,
                        text: 'Continue with Apple',
                        onPressed: () {
                          // Add Apple login action
                        },
                      ),
                      const SizedBox(height: 10),
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
            ),
          ),
          if (signProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
