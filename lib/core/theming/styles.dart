import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class MyTextStyle {
  //her we add out custom fonts even if we gonna use it once (:
  static TextStyle font24LightPurpleBold = TextStyle(
    fontSize: 24.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.bold,
    color: MyColors.myLightPurple,
  );
  static TextStyle font48LightPurpleBold =TextStyle(
    fontSize: 48.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.bold,
    color: MyColors.myLightPurple,
  );
  static TextStyle font18MainPurpleSemiBold = TextStyle(
      fontSize: 18.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.w600,
      color: MyColors.mainPurple);
  static TextStyle font18WhiteSemiBold = TextStyle(
      fontSize: 18.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.w600,
      color: Colors.white);
  static TextStyle font18BlackSemiBold = TextStyle(
      fontSize: 18.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.w600,
      color: Colors.black);
  static TextStyle font22BlackSemiBold = TextStyle(
    fontSize: 22.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: MyColors.myBlack,
  );
  static TextStyle font16LightGrayRegular = TextStyle(
      fontSize: 16.sp,
      fontFamily: "poppins",
      color: MyColors.myLightGray
  );
  static TextStyle font32BlackBold = TextStyle(
      fontSize: 32.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.bold,
      color: Colors.black
  );
  static TextStyle font16GrayRegular = TextStyle(
    fontSize: 16.sp,
    fontFamily: "poppins",
    color: MyColors.myGray,
  );
  static TextStyle font18LightBlackRegular = TextStyle(
    fontSize: 18.sp,
    fontFamily: "poppins",
    color: MyColors.myLightBlack,
  );
  static TextStyle font26BlackBold = TextStyle(
      fontSize: 26.sp,
      fontFamily: "poppins",
      fontWeight: FontWeight.bold,
      color: Colors.black
  );
  static TextStyle font26MainPurpleBold = TextStyle(
    fontSize: 26.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.bold,
    color: MyColors.mainPurple,
  );
  static TextStyle font22MainPurpleSemiBold = TextStyle(
    fontSize: 22.sp,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: MyColors.mainPurple,
  );

}