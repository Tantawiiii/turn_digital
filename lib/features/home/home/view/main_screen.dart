import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/helper/spacing.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomeScreen(),
      items: _buildDrawerItems(),
    );
  }

  List<KFDrawerItem> _buildDrawerItems() {
    final menuItems = [
      {'title': 'My Profile', 'icon': AssetsPATH.iProfile},
      {'title': 'Message', 'icon': AssetsPATH.iMassages},
      {'title': 'Calendar', 'icon': AssetsPATH.iCalendar},
      {'title': 'Bookmark', 'icon': AssetsPATH.iBookmark},
      {'title': 'Contact Us', 'icon': AssetsPATH.iEmail},
      {'title': 'Settings', 'icon': AssetsPATH.iSettings},
      {'title': 'Helps & FAQs', 'icon': AssetsPATH.iHelp},
      {'title': 'SignOut', 'icon': AssetsPATH.iLogOut},
    ];

    return menuItems.map((item) => _buildDrawerItem(item['title']!, item['icon']!)).toList();
  }

  KFDrawerItem _buildDrawerItem(String title, String iconPath) {
    return KFDrawerItem(
      text: Text(title, style: AppTextStyles.font14DarkLight),
      icon: SvgPicture.asset(iconPath),
      onPressed: () => _drawerController.close!(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: _buildHeader(),
        footer: _buildFooterItem(),
        decoration: const BoxDecoration(color: AppColors.CWhite),
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 14,
          children: [
            CircleAvatar(
              radius: 40,
              child: ClipOval(
                child: Image.asset(AssetsPATH.pLogo_app, fit: BoxFit.cover),
              ),
            ),
            Text('Ahmed Tantawy', style: AppTextStyles.font18BlackMedium),
            verticalSpace(30),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterItem() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity /2,
        height: 48,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.CPrimary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsPATH.iUpgrade),
            horizontalSpace(10),
            Text("Upgrade Pro", style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

}
