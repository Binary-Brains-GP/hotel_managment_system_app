import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routing/app_router.dart';
import 'design_pattern_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  runApp(DesignPatternApp(
    appRouter: AppRouter(),
  ));
}
