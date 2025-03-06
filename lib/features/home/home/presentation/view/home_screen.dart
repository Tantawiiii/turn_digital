import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:turn_digital/core/constant/assets_path.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/features/home/home/presentation/widgets/custom_app_bar.dart';

import '../../cubit/event_cubit.dart';

import '../widgets/build_home_body.dart';


class HomeScreen extends KFDrawerContent {
  HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.CWhite,
      appBar: CustomAppBar(
        onMenuPressed: () {
          widget.onMenuPressed?.call();
        },
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarStyle: NavBarStyle.style15,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeBody(),
      Center(child: Text("Search")),
      Center(child: Text("Events")),
      Center(child: Text("Notifications")),
      Center(child: Text("Profile")),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AssetsPATH.iExplore,width: 23,height: 23,),
        title: ("Explore"),
        activeColorPrimary: AppColors.CPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AssetsPATH.iCalendar,width: 23,height: 23,),
        title: ("Events"),
        activeColorPrimary: AppColors.CPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_box, color: AppColors.CWhite,),
        title: "",
        activeColorPrimary: AppColors.CPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AssetsPATH.iLocation,width: 23,height: 23,),
        title: ("Map"),
        activeColorPrimary:AppColors.CPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
    
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AssetsPATH.iProfile,width: 23,height: 23,),
        title: ("Profile"),
        activeColorPrimary: AppColors.CPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}


