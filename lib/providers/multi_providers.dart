import 'package:choice_app/screens/authentication/accountReclaim/reclaim_account_provider.dart';
import 'package:choice_app/screens/authentication/auth_provider.dart';
import 'package:choice_app/screens/authentication/otpVerification/otp_provider.dart';
import 'package:choice_app/screens/authentication/passwordManagement/password_provider.dart';
import 'package:choice_app/screens/languageSelection/language_selection_provider.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:provider/provider.dart';

import '../userRole/role_provider.dart';

final multiProviders = [
  ChangeNotifierProvider<LanguageSelectionProvider>(
    create: (_) => LanguageSelectionProvider(),
    lazy: true,
  ), ChangeNotifierProvider<ProfileProvider>(
    create: (_) => ProfileProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PasswordProvider>(
    create: (_) => PasswordProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<RoleProvider>(
    create: (_) => RoleProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<OtpProvider>(
    create: (_) => OtpProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ReclaimAccountProvider>(
    create: (_) => ReclaimAccountProvider(),
    lazy: true,
  ),
];