import 'package:flutter/material.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_btn.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(  // Centers the entire Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextBtn(
                buttonText: "To login",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginScreen);
                },
              ),
              SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Sign UP",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signUpScreen);
                },
              ),
              SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Home",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.homeScreen);
                },
              ),
              SizedBox(height: 20),
              AppTextBtn(
                buttonText: "To Forget password",
                textStyle: MyTextStyle.font18WhiteSemiBold,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.forgotPasswordScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
