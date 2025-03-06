import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bounce/bounce.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/constant/strings_text.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? onMenuPressed;

  const CustomAppBar({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.CPrimary,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Bounce(
          onTap: () {
            if (onMenuPressed != null) {
              onMenuPressed!();
            }
          },
          child: SvgPicture.asset(
            AssetsPATH.iNavMenu,
            width: 28.w,
            height: 28.h,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: SvgPicture.asset(
            AssetsPATH.iNotfiyCircle,
            width: 36.w,
            height: 36.h,
          ),
        ),
      ],
      centerTitle: true,
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppTexts.tCurrentLocation,
                style: AppTextStyles.font12WhiteMedium,
              ),
              Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
            ],
          ),
          Text(AppTexts.tNewYork, style: AppTextStyles.font14WhiteMedium),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
