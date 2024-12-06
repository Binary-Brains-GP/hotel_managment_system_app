import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
//--------------------------------------Password properties--------------------------------------------------
  final bool isSecuredField;  //--------is this field a secure field or not???-------------
  final IconData? suffixIconVisible;
  final IconData? suffixIconHidden;
  final bool? obscureText;
  final Function()? onSuffixIconPressed;
  //---------------------Constants-----------------------
  final Color prefixIconColor;
  final Color suffixIconColor;
  final BorderRadius borderRadius;
  final double blurRadius;
  final double spreadRadius;
  final double elevationOffset;
  final double contentPadding;
  final double blurOpacity;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    required this.isSecuredField,
    this.obscureText,
    this.suffixIconVisible,
    this.suffixIconHidden,
    this.onSuffixIconPressed,
    this.prefixIconColor = Colors.grey,
    this.suffixIconColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.blurRadius = 10.0,
    this.spreadRadius = 5,
    this.elevationOffset = 10,
    this.contentPadding = 15,
    this.blurOpacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(blurOpacity),
            spreadRadius:spreadRadius,
            blurRadius: blurRadius,
            offset: Offset(0, elevationOffset),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isSecuredField? obscureText!: false,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: prefixIconColor),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w, // Customize or calculate as needed
            minHeight: 40.h,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 201, 200, 200),
            fontFamily: "Poppins",

          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(contentPadding),
          suffixIcon: isSecuredField? IconButton(
            onPressed: onSuffixIconPressed,
            icon: Icon(
              obscureText! ? suffixIconHidden : suffixIconVisible,
              color: suffixIconColor,
            ),
          ): null,
        ),
      ),
    );
  }
}
