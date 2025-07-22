import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../userRole/role_provider.dart';
import '../userRole/user_role.dart';

class AppColors{
  AppColors._();
  static  const Color primaryColor = Color(0xffF49E10);
  static  const Color customerPrimaryColor = Color(0xff009ED4);
  static  const Color inputHintColor = Color(0xff818397);
  static  const Color greyBordersColor = Color(0xffCDCDD5);
  static  const Color primarySlateColor = Color(0xff4F516D);
  static  const Color greyColor = Color(0xffE6E6EA);
  static  const Color textGreyColor = Color(0xff9A9BAB);


  static  const Color userSlateColor = Color(0xff4F516D);
  static  const Color leisureSlateColor = Color(0xFF8F2DA3);
  static  const Color wellnessSlateColor = Color(0xFF4FAD53);
  static const Color whiteColor = Color(0xFFFFFFFF);


  static Color getPrimaryColorFromContext(BuildContext context) {
    final role = context.read<RoleProvider>().role;

    switch (role) {
      case UserRole.user:
        return userSlateColor;
      case UserRole.restaurant:
        return primarySlateColor;
      case UserRole.wellness:
        return wellnessSlateColor;
      case UserRole.leisure:
        return leisureSlateColor;
    }
  }

}