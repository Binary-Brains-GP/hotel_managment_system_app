import 'package:design_pattern/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class AppTextBtn extends StatelessWidget {
  final double? borderRadius;
  final Color? backGroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle? textStyle;

  const AppTextBtn(
      {this.borderRadius,
        this.backGroundColor,
        this.horizontalPadding,
        this.verticalPadding,
        this.buttonWidth,
        this.buttonHeight,
        required this.buttonText,
        this.textStyle,
        required this.onPressed,
        super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
          ),
        ),
        backgroundColor:
        WidgetStatePropertyAll(backGroundColor ?? MyColors.mainBrown),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 12.w,
              vertical: verticalPadding ?? 14.h),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth ?? 341.w, buttonHeight ?? 56.h),
        ),
      ),
      child: Text(
        buttonText,
        style: textStyle ?? MyTextStyle.font18WhiteSemiBold,
      ),
    );
  }
}
