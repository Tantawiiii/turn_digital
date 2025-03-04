import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turn_digital/core/constant/strings_text.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

import '../../../core/constant/assets_path.dart';
import '../../../core/constant/colors_code.dart';
import '../../../core/helper/validation_utils.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      print("Login Successful");
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: ListView(
              children: [
                verticalSpace(30),
                Image.asset(AssetsPATH.pLogo_app, width: 300.w, height: 62.h),
                verticalSpace(30),
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
                        Text(AppTexts.tRememberMe, style: AppTextStyles.font12DarkLight,),
                      ],
                    ),
                    Text(AppTexts.tForgotPassword, style: AppTextStyles.font12DarkLight,),

                  ],
                ),
                verticalSpace(20),
                CustomButton(text:AppTexts.tSignIn,width: 240.w ,onPressed: _login),
                verticalSpace(20),
                const Text("OR"),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
