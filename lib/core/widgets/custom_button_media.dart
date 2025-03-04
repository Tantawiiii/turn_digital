import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

class CustomButtonMedia extends StatelessWidget {
  final String text;
  final String  AssetsPATH;



  const CustomButtonMedia({
    super.key,
    required this.text, required this.AssetsPATH,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Bounce(
        onTap: (){},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.CWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SvgPicture.asset(
                AssetsPATH,
                width: 28.w,
                height: 28.h,
              ),
              horizontalSpace(20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14DarkLight,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
