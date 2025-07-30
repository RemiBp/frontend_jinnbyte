import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../userRole/role_provider.dart';
import '../userRole/user_role.dart';

class AppColors{
  AppColors._();

  static  const Color userPrimaryColor = Color(0xff009ED4);
  static  const Color restaurantPrimaryColor = Color(0xffF49E10);
  static  const Color leisurePrimaryColor = Color(0xFF8F2DA3);
  static  const Color wellnessPrimaryColor = Color(0xFF4FAD53);

  static  const Color inputHintColor = Color(0xff818397);
  static  const Color greyBordersColor = Color(0xffCDCDD5);
  static  const Color primarySlateColor = Color(0xff4F516D);
  static  const Color greyColor = Color(0xffE6E6EA);
  static  const Color textGreyColor = Color(0xff9A9BAB);

  static const Color blueColor = Color(0xFF148FFF);
  static const Color blackColor = Color(0xFF000116);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color softBlue = Color(0xFF8EC8DB);
  static const Color vibrantBlue = Color(0xFF3453FD);
  static const Color redColor = Color(0xFFFF5655);




  static const Color orangeWithOpacity = Color(0x96F49E10);
  static const Color orangeTransparent = Color(0x00F49E10);




  static Color getPrimaryColorFromContext(BuildContext context) {
    final role = context.read<RoleProvider>().role;

    switch (role) {
      case UserRole.user:
        return userPrimaryColor;
      case UserRole.restaurant:
        return restaurantPrimaryColor;
      case UserRole.wellness:
        return wellnessPrimaryColor;
      case UserRole.leisure:
        return leisurePrimaryColor;
    }
  }

}