import 'dart:async';

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turn_digital/core/widgets/custom_button.dart';
import '../../../../core/constant/assets_path.dart';
import '../../../../core/constant/colors_code.dart';
import '../../../../core/constant/strings_text.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/texts_styles.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../cubit/otp_cubit.dart';

class OtpScreen extends StatefulWidget {

  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {


  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  int _start = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _start = 30;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    int seconds = _start % 60;

    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPATH.pSplashBack),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Bounce(
                  onTap: () {
                    Navigator.pushNamed(context, RRoutes.rLogin);
                  },
                  child: SvgPicture.asset(AssetsPATH.iArrowLeft),
                ),
              ),
              verticalSpace(20),
              Text(
                AppTexts.tVerificationCode,
                textAlign: TextAlign.start,
                style: AppTextStyles.font24BlackMedium,
              ),
              verticalSpace(20),
              Text(
                AppTexts.tVerificationCodeSent,
                textAlign: TextAlign.start,
                style: AppTextStyles.font14DarkLight,
              ),
              verticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 55.w,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: "-",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.BORDER),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.CPrimary,width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 3) {
                            FocusScope.of(
                              context,
                            ).requestFocus(focusNodes[index + 1]);
                          } else {
                            String otp = controllers.map((e) => e.text).join();
                            context.read<OtpCubit>().verifyOtp(otp);
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              verticalSpace(40),
              BlocConsumer<OtpCubit, OtpState>(
                listener: (context, state) {
                  if (state.isValid) {
                    CustomToast.showToast(
                      message: "OTP Code Successful!",
                      backgroundColor: Colors.green,
                    );
                    Navigator.pushNamed(context, RRoutes.rMain);
                  } else if (!state.isValid){
                    CustomToast.showToast(
                      message: "OTP Code Failed!",
                      backgroundColor: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      String otp = controllers.map((e) => e.text).join();
                      context.read<OtpCubit>().verifyOtp(otp);
                    },
                    text: AppTexts.tContinue,
                  );
                },
              ),
              verticalSpace(24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppTexts.tReSentCode,
                    style: AppTextStyles.font14DarkLight,
                    children: [
                      TextSpan(
                        text:"0:${seconds.toString().padLeft(2, '0')}",
                        style: AppTextStyles.font15Primer,
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
  }
}
