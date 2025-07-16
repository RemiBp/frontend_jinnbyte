import 'package:choice_app/screens/authentication/authentication.dart';
import 'package:choice_app/screens/authentication/otpVerification/otp_verification.dart';
import 'package:choice_app/screens/authentication/signup.dart';
import 'package:choice_app/screens/authentication/upload_docs.dart';
import 'package:choice_app/screens/languageSelection/language_selection.dart';
import 'package:go_router/go_router.dart';

import '../screens/authentication/login.dart';
import '../screens/authentication/passwordManagement/forgot_password.dart';
import '../screens/authentication/passwordManagement/reset_password.dart';
import '../screens/restaurant/profile/profile.dart';
import '../screens/splash/splash.dart';

class Routes {
  static const String initialRoute = '/';
  static const String languageSelectionRoute = '/language_selection';
  static const String authRoute = '/auth';
  static const String signupRoute = '/signup';
  static const String otpVerificationRoute = '/otp_verification';
  static const String uploadDocsRoute = '/upload_docs';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgot_password';
  static const String resetPasswordRoute = '/reset_password';
  static const String restaurantProfileRoute = '/restaurant_profile';

}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Splash()),
    GoRoute(path: '/language_selection', builder: (context, state) => const LanguageSelection()),
    GoRoute(path: '/auth', builder: (context, state) => const Authentication()),
    GoRoute(path: '/signup', builder: (context, state) => const Signup()),
    GoRoute(
      path: '/otp_verification',
      builder: (context, state) => const OtpVerification(),
    ),
    GoRoute(
      path: '/upload_docs',
      builder: (context, state) => const UploadDocs(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(
      path: '/reset_password',
      builder: (context, state) => const ResetPassword(),
    ),
    GoRoute(
      path: '/restaurant_profile',
      builder: (context, state) => const Profile(),
    ),
  ],
);
