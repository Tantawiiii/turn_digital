import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/assets_path.dart';
import '../../../core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RRoutes.rOnBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetsPATH.pSplashBack,
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _opacity,
              child: AnimatedScale(
                duration: Duration(seconds: 1),
                scale: _scale,
                curve: Curves.easeOutBack,
                child: Image.asset(AssetsPATH.pLogo_app, width: 330.w, height: 70.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
