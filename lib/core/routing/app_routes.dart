import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turn_digital/core/routing/routes.dart';
import 'package:turn_digital/features/auth/otp/cubit/otp_cubit.dart';
import 'package:turn_digital/features/auth/otp/view/otp_screen.dart';
import 'package:turn_digital/features/auth/register/view/register_screen.dart';
import 'package:turn_digital/features/onboarding/view/on_boarding_screen.dart';

import '../../features/auth/login/login_screen.dart';
import '../../features/onboarding/cubit/onboarding_cubit.dart';
import '../../features/onboarding/view/splash_screen.dart';



class AppRouter {
  Route generateRoute(RouteSettings setting) {
    final arguments = setting.arguments;

    switch (setting.name) {
      case RRoutes.rSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RRoutes.rOnBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnBoardingCubit>(
                create: (context) => OnBoardingCubit(),
                child: OnBoardingScreen(),
              ),
        );
      case RRoutes.rLogin:
        return MaterialPageRoute(builder: (_) => LoginScreen());

        case RRoutes.rRegister:
        return MaterialPageRoute(
            builder: (_) => RegisterScreen()
        );
    case RRoutes.rOtp:
    return MaterialPageRoute(
      builder: (_) => BlocProvider<OtpCubit>(
        create: (context) => OtpCubit(),
        child: OtpScreen(),
      ),
    );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(child: Text("No Routes Find ${setting.name}")),
              ),
        );
    }
  }
}
