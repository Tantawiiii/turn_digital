import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turn_digital/core/constant/colors_code.dart';

import 'core/constant/strings_text.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/routes.dart';

void main() {
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});


  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppTexts.TAppName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.CPrimary),
          useMaterial3: true,
        ),
        onGenerateRoute: appRouter.generateRoute,
       // initialRoute: RRoutes.rSplash,
        initialRoute: RRoutes.rMain,
      ),
    );
  }
}
