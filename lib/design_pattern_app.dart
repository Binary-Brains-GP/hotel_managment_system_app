import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';


class DesignPatternApp extends StatelessWidget {
  const DesignPatternApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'BinaryBrains',
        theme: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
