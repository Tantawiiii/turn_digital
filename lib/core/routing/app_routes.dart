import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/routing/routes.dart';
import 'package:marketi/featuers/auth/login/view/login_screen.dart';

import '../../featuers/onboarding/cubit/onboarding_cubit.dart';
import '../../featuers/onboarding/view/on_boarding_screen.dart';
import '../../featuers/onboarding/view/splash_screen.dart';

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
