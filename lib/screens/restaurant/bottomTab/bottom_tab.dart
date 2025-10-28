import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:choice_app/screens/bookings/bookings_view.dart';
import 'package:choice_app/screens/customer/home/customer_home.dart';
import 'package:choice_app/screens/customer/maps/customer_maps/customer_maps_view.dart';
import 'package:choice_app/screens/leisure/leisure_profile/leisure_profile_view.dart';
import 'package:choice_app/screens/restaurant/dashboard/home_view.dart';
import 'package:choice_app/screens/restaurant/event/events.dart';
import 'package:choice_app/screens/restaurant/home/restaurant_home.dart';
import 'package:choice_app/screens/wellness/home/welness_home.dart';
import 'package:choice_app/userRole/role_provider.dart';
import 'package:choice_app/userRole/user_role.dart';
import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../customer/explore/customer_explore/explore_view.dart';
import '../../customer/profile/customer_profile/customer_profile_view.dart';
import '../../wellness/wellness_profile/wellness_profile_view.dart';

class RestaurantBottomTab extends StatefulWidget {
  const RestaurantBottomTab({super.key});

  @override
  State<RestaurantBottomTab> createState() => _RestaurantBottomTabState();
}

class _RestaurantBottomTabState extends State<RestaurantBottomTab>
    with TickerProviderStateMixin {
  var _bottomNavIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;
  UserRole role = UserRole.restaurant;

  late List<String> labels;
  late List<String> iconList;
  late List<String> activeIconList;

  List<Widget> widgets = [

  ];

  @override
  void initState() {
    super.initState();
    final roleProvider = Provider.of<RoleProvider>(context, listen: false);
    role = roleProvider.role;
    labels = [
      al.home,
      role == UserRole.user ?al.map:al.dashboard,
      role == UserRole.user ? al.explore : al.events,
      al.bookings,
      al.profile
    ];
    iconList = [
      Assets.homeIcon,
      role == UserRole.user ?Assets.mapIcon: Assets.dashboardIcon,
      role == UserRole.user ? Assets.exploreIcon : Assets.eventsIcon,
      Assets.bookingIcon,
      Assets.profileIcon,
    ];

    activeIconList = [
      Assets.homeActiveIcon,
      role == UserRole.user ?Assets.mapIcon:  Assets.dashboardActiveIcon,
      role == UserRole.user ? Assets.exploreActiveIcon : Assets.eventActiveIcon,
      Assets.bookingActiveIcon,
      Assets.profileActiveIcon,
    ];

    widgets = [
      role == UserRole.wellness ? WellnessHome() : role == UserRole.user
          ? CustomerHome()
          : RestaurantHome(),
      role == UserRole.user?CustomerMapsView(): HomeView(),
      role == UserRole.user?ExploreView():Events(),
      BookingsView(),
      if (role == UserRole.user) CustomerProfileView(),
      if (role == UserRole.wellness) WellnessProfileView(),
      if (role == UserRole.leisure) LeisureProfileView(),
      if (role == UserRole.restaurant) LeisureProfileView(),
    ];
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(borderRadiusCurve);

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      body: NavigationScreen(widgets[_bottomNavIndex]),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isActive ? activeIconList[index] : iconList[index],
                color: isActive
                    ? AppColors.getPrimaryColorFromContext(context)
                    : null,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(
                  child: Text(
                    labels[index],
                    maxLines: 1,
                    style: TextStyle(
                      color:
                          isActive
                              ? AppColors.getPrimaryColorFromContext(context)
                              : HexColor.fromHex("#818397"),
                      fontSize: sizes?.fontSize12,
                      fontFamily: Assets.onsetMedium,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        backgroundColor: AppColors.whiteColor,
        height: getHeight() * .1,
        activeIndex: _bottomNavIndex,
        splashColor: AppColors.getPrimaryColorFromContext(context),
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        // shadow: BoxShadow(
        //   offset: const Offset(0, 1),
        //   blurRadius: 12,
        //   spreadRadius: 0.5,
        //   color: colors.activeNavigationBarColor,
        // ),
      ),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  final Widget widget;

  const NavigationScreen(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: widget);
  }
}
