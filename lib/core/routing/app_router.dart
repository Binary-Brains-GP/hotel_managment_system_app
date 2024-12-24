
import 'package:design_pattern/core/routing/routes.dart';
import 'package:design_pattern/features/residents/residents_screen.dart';
import 'package:design_pattern/features/room_details/ui/room_details_screen.dart';
import 'package:design_pattern/features/workers/workers_screen.dart';
import 'package:flutter/material.dart';

import '../../features/forgot_password/ui/forgot_password_screen.dart';
import '../../features/forgot_password/ui/new_password_screen.dart';
import '../../features/forgot_password/ui/verify_screen.dart';
import '../../features/home/ui/home_state_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/sign_up/ui/sign_up_Screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../../features/statistics/statistics_screen.dart';
import '../model/room_model.dart';

class AppRouter {
  // final bool showHome;
  //
  // const AppRouter({
  //   required this.showHome,
  // });
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    //final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.newPasswordScreen:
        return MaterialPageRoute(builder: (_) => NewPasswordScreen());
      case Routes.verifyScreen:
        return MaterialPageRoute(builder: (_) => VerifyScreen());
      case Routes.homeStateScreen:
        return MaterialPageRoute(builder: (_) => HomeScreenState());
      case Routes.workersScreen:
        return MaterialPageRoute(builder: (_) => WorkersScreen());
      case Routes.residentsScreen:
        return MaterialPageRoute(builder: (_) => ResidentsScreen());
      case Routes.statisticsScreen:
        return MaterialPageRoute(builder: (_) => StatisticsScreen());
      case Routes.roomDetailsScreen:
        final hotelRoom = settings.arguments as HotelRoom; // Get the room from arguments
        return MaterialPageRoute(
          builder: (_) => RoomDetailsScreen(hotelRoom: hotelRoom),
        );
      default:
        return null;
    }
  }
}
