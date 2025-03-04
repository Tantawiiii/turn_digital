import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turn_digital/core/constant/strings_text.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

import '../../../core/constant/colors_code.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/onBoarding_list_model.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OnBoardingCubit.get(context);

        return Scaffold(
          backgroundColor: AppColors.CWhite,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      onPageChanged: (index) {
                        cubit.changeCurrentIndex(index);
                      },
                      itemCount: onBoardingList.length,
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 62.w,vertical: 44.h),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(0.2),
                                    ],
                                    stops: [0.3, 5.0],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.darken,
                                child: Image.asset(
                                  onBoardingList[index].image!,
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),


                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                color: AppColors.CPrimary ,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  verticalSpace(40),
                                  Text(
                                    onBoardingList[index].title!,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.font20WhiteMedium
                                  ),
                                  verticalSpace(16),
                                  Text(
                                    onBoardingList[index].description!,
                                    textAlign: TextAlign.center,
                                      style: AppTextStyles.font15WhiteRegular
                                  ),
                                 verticalSpace(30),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Bounce(
                                        onTap: (){
                                          Navigator.pushReplacementNamed(context, RRoutes.rLogin);
                                        },
                                        child: Text(
                                            AppTexts.TSkip,
                                          style: AppTextStyles.font16WhiteMedium
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: List.generate(
                                          onBoardingList.length,
                                              (i) => AnimatedContainer(
                                            duration:
                                            Duration(milliseconds: 200),
                                            margin: EdgeInsets.only(right: 5.w),
                                            height: 10.h,
                                            width: cubit.currentIndex == i
                                                ? 22.w
                                                : 12.w,
                                            decoration: BoxDecoration(
                                              color: cubit.currentIndex == i
                                                  ? AppColors.CWhite
                                                  : Colors.white.withOpacity(0.5),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Bounce(
                                        onTap: (){
                                          if (cubit.currentIndex <
                                              onBoardingList.length - 1) {
                                            cubit.nextPage();
                                          } else {
                                            Navigator.pushReplacementNamed(context, RRoutes.rLogin);
                                          }
                                        },
                                        child: Text(
                                          cubit.currentIndex <
                                              onBoardingList.length - 1
                                              ? AppTexts.TNext
                                              : AppTexts.TGetStarted,
                                          textAlign: TextAlign.center,
                                            style: AppTextStyles.font16WhiteMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(40),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
