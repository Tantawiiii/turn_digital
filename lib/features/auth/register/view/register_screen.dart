import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_digital/core/constant/strings_text.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import 'package:turn_digital/core/widgets/custom_button_media.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/validation_utils.dart';
import 'package:turn_digital/core/widgets/custom_button.dart';
import 'package:turn_digital/core/widgets/custom_text_field.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsPATH.pSplashBack),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
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
                    AppTexts.tSignUp,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.font24BlackMedium,
                  ),
                  verticalSpace(20),
                  CustomTextField(
                    controller: _nameController,
                    hintText: AppTexts.tFullName,
                    prefixIconPath: AssetsPATH.iProfile,
                    validator: ValidationUtils.validateFullName,
                  ),
                  verticalSpace(15),
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
                  verticalSpace(15),
                  CustomTextField(
                    controller: _confirmController,
                    hintText: AppTexts.tConfirmPass,
                    prefixIconPath: AssetsPATH.iLock,
                    obscureText: true,
                    validator:
                        (value) => ValidationUtils.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                  ),

                  verticalSpace(40),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        CustomToast.showToast(
                          message: "Registration Successful!",
                          backgroundColor: Colors.green,
                        );
                        Navigator.pushNamed(context, RRoutes.rOtp);
                      } else if (state is RegisterFailure) {

                        CustomToast.showToast(
                          message: "Registration Failed!",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is RegisterLoading
                          ? Center(child: SpinKitWave(
                        color: AppColors.CPrimary,
                        size: 40.0,
                      ))
                          : CustomButton(
                        text: AppTexts.tSIGNup,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  verticalSpace(20),
                  Text(
                    AppTexts.tOr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font14LightMedium,
                  ),
                  verticalSpace(20),
                  CustomButtonMedia(
                    text: AppTexts.tLoginGoogle,
                    AssetsPATH: AssetsPATH.iGoogle,
                  ),
                  verticalSpace(10),
                  CustomButtonMedia(
                    text: AppTexts.tLoginFacebook,
                    AssetsPATH: AssetsPATH.iFacebook,
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(AppTexts.tAlreadyAccount),
                      Bounce(
                        onTap: () {
                          Navigator.pushNamed(context, RRoutes.rLogin);
                        },
                        child: const Text(
                          AppTexts.tSignIn,
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
