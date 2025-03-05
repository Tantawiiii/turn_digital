import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turn_digital/core/constant/strings_text.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import 'package:turn_digital/core/widgets/custom_button_media.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/validation_utils.dart';
import 'package:turn_digital/core/widgets/custom_button.dart';
import 'package:turn_digital/core/widgets/custom_text_field.dart';

import '../../../core/routing/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, RRoutes.rMain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPATH.pSplashBack),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  verticalSpace(20),
                  Image.asset(AssetsPATH.pLogo_app, width: 300.w, height: 62.h),
                  verticalSpace(60),
                  Text(
                    AppTexts.tSignIn,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.font24BlackMedium,
                  ),
                  verticalSpace(20),
                  CustomTextField(
                    controller: _emailController,
                    hintText: AppTexts.tEmailHint,
                    prefixIconPath: AssetsPATH.iEmail,
                    validator: ValidationUtils.validateEmail,
                  ),
                  verticalSpace(15),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: AppTexts.tPasswordHint,
                    prefixIconPath: AssetsPATH.iLock,
                    obscureText: true,
                    validator: ValidationUtils.validatePassword,
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              activeColor: AppColors.CWhite,
                              activeTrackColor: AppColors.CPrimary,
                              value: true,
                              onChanged: (val) {},
                            ),
                          ),
                          Text(AppTexts.tRememberMe, style: AppTextStyles.font12DarkLight),
                        ],
                      ),
                      Text(AppTexts.tForgotPassword, style: AppTextStyles.font12DarkLight),
                    ],
                  ),
                  verticalSpace(20),
                  CustomButton(text: AppTexts.tSIGN, onPressed: _login),
                  verticalSpace(20),
                  Text(AppTexts.tOr, textAlign: TextAlign.center, style: AppTextStyles.font14LightMedium),
                  verticalSpace(20),
                  CustomButtonMedia(text: AppTexts.tLoginGoogle, AssetsPATH: AssetsPATH.iGoogle),
                  verticalSpace(10),
                  CustomButtonMedia(text: AppTexts.tLoginFacebook, AssetsPATH: AssetsPATH.iFacebook),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTexts.tLoginDontAccount),
                      Bounce(
                        onTap: () {
                          Navigator.pushNamed(context, RRoutes.rRegister);
                        },
                        child: const Text(
                          AppTexts.tSignUp,
                          style: TextStyle(color: AppColors.CPrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
