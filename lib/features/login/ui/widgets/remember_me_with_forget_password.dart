import 'package:design_pattern/core/theming/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
class RememberMeWithForgetPassword extends StatefulWidget {

  const RememberMeWithForgetPassword({Key? key}) : super(key: key);

  @override
  State<RememberMeWithForgetPassword> createState() =>
      _RememberMeWithForgetPasswordState();
}

class _RememberMeWithForgetPasswordState
    extends State<RememberMeWithForgetPassword> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          activeColor: MyColors.mainBrown,
        ),
        const Text("Remember me",style: TextStyle(color: MyColors.mainBrown,fontSize: 15),),
        const Spacer(),
        RichText(
          text: TextSpan(
            text: 'Forget Password?',
            style: const TextStyle(color: MyColors.myRed, decoration: TextDecoration.underline,fontSize: 16),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
               Navigator.pushNamed(context, Routes.forgotPasswordScreen);
              },
          ),
        ),
      ],
    );
  }
}