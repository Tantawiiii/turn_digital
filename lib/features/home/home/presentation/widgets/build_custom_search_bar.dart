import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'build_category_btn.dart';

class BuildCustomSearchBar extends StatelessWidget {
  const BuildCustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.CPrimary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(AssetsPATH.iSearch, width: 20, height: 20),
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.CPrimary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(14),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.CWhite,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AssetsPATH.iFilterCircle),
                        const SizedBox(width: 3),
                        Text("Filters", style: TextStyle(color: AppColors.CPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
            ],
          ),
        ),
        Positioned(
          bottom: -19,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCategoryButton("Sports", AssetsPATH.iSports, AppColors.CardSports),
              horizontalSpace(10),
              buildCategoryButton("Music", AssetsPATH.iMusic, AppColors.CardMusic),
              horizontalSpace(10),
              buildCategoryButton("Food", AssetsPATH.iFood, AppColors.CardFOOD),
            ],
          ),
        ),
      ],
    );
  }
}
