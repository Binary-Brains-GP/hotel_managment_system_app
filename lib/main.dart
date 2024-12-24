import 'package:design_pattern/core/networking/room_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/networking/income_provider.dart';
import 'core/networking/resident_payment_provider.dart';
import 'core/networking/worker_payment_provider.dart';
import 'core/routing/app_router.dart';
import 'design_pattern_app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDcBJQIyWYsTEIwmj15ylAqqdlGEijUD88",
          appId: "1:513779075288:android:36239ce00d4c4affc0afad",
          messagingSenderId: "513779075288",
          projectId: "desingproject-63b1e"));
  await ScreenUtil.ensureScreenSize();
 // final prefs = await SharedPreferences.getInstance();
  //final showHome = prefs.getBool("showHome") ?? false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RoomProvider()),
      ChangeNotifierProvider(create: (context) => WorkerPaymentProvider()),
      ChangeNotifierProvider(create: (context) => ResidentPaymentProvider()),
      ChangeNotifierProvider(
        create: (context) => IncomeProvider(
          workerPaymentProvider: Provider.of<WorkerPaymentProvider>(context, listen: false),
          residentPaymentProvider: Provider.of<ResidentPaymentProvider>(context, listen: false),
        ),
      ),
    ],
    child: DesignPatternApp(
      appRouter: AppRouter(),
    ),
  ));

}
