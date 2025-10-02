import 'package:choice_app/screens/authentication/accountReclaim/review.dart';
import 'package:choice_app/screens/authentication/authentication.dart';
import 'package:choice_app/screens/authentication/otpVerification/otp_verification.dart';
import 'package:choice_app/screens/authentication/accountReclaim/reclaim_account.dart';
import 'package:choice_app/screens/authentication/signup.dart';
import 'package:choice_app/screens/authentication/upload_docs.dart';
import 'package:choice_app/screens/customer/home/choiceWidgets/choice_selection.dart';
import 'package:choice_app/screens/customer/home/create_choice.dart';
import 'package:choice_app/screens/customer/home/customer_home.dart';
import 'package:choice_app/screens/languageSelection/language_selection.dart';
import 'package:choice_app/screens/onboarding/add_cuisine/add_cuisine.dart';
import 'package:choice_app/screens/onboarding/business_hours/edit_business_hours/edit_operational_hours.dart';
import 'package:choice_app/screens/onboarding/gallery/gallery_view.dart';
import 'package:choice_app/screens/onboarding/menu/menu_view.dart';
import 'package:choice_app/screens/onboarding/slot_management/slot_management_view.dart';
import 'package:choice_app/screens/restaurant/event/create_event.dart';
import 'package:choice_app/screens/restaurant/event/event_details.dart';
import 'package:choice_app/screens/restaurant/home/create_post.dart';
import 'package:go_router/go_router.dart';

import '../screens/authentication/accountReclaim/upload_reclaim_docs.dart';
import '../screens/authentication/login.dart';
import '../screens/authentication/passwordManagement/forgot_password.dart';
import '../screens/authentication/passwordManagement/reset_password.dart';
import '../screens/authentication/user_Signup.dart';
import '../screens/customer/home/choiceWidgets/sub_choice_selection.dart';
import '../screens/restaurant/bottomTab/bottom_tab.dart';
import '../screens/restaurant/event/events.dart';
import '../screens/restaurant/profile/profile.dart';
import '../screens/splash/splash.dart';
import '../screens/wellness/home/welness_home.dart';

class Routes {
  static const String initialRoute = '/';
  static const String languageSelectionRoute = '/language_selection';
  static const String authRoute = '/auth';
  static const String reClaimAccountRoute = '/re_claim_account';
  static const String uploadReclaimDocsRoute = '/upload_reclaim_docs';
  static const String reviewRoute = '/review';
  static const String signupRoute = '/signup';
  static const String userSignupRoute = '/userSignup';
  static const String otpVerificationRoute = '/otp_verification';
  static const String uploadDocsRoute = '/upload_docs';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgot_password';
  static const String resetPasswordRoute = '/reset_password';
  static const String editOperationHoursRoute = '/edit_operation_hours';
  static const String galleryViewRoute = '/gallery_view';
  static const String slotManagementViewRoute = '/slot_management_view';

  // restaurant
  static const String restaurantProfileRoute = '/restaurant_profile';
  static const String restaurantEventsRoute = '/restaurant_events';
  static const String restaurantCreateEventRoute = '/restaurant_create_events';
  static const String restaurantEventDetailsRoute = '/restaurant_event_details';
  static const String restaurantBottomTabRoute = '/restaurant_bottom_tab';
  static const String restaurantCreatePostRoute = '/restaurant_create_post';
  static const String restaurantAddCuisineRoute = '/restaurant_add_cuisine';
  static const String restaurantMenuViewRoute = '/restaurant_menu_view';

  //Customer
  static const String customerHomeRoute = '/customer_home';
  static const String choiceSelectionRoute = '/choice_selection';
  static const String subChoiceSelectionRoute = '/sub_choice_selection';
  static const String createChoiceRoute = '/create_choice';

  //wellness
  static const String wellnessHomeRoute = '/wellness_home';

}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Splash()),
    GoRoute(path: '/language_selection', builder: (context, state) => const LanguageSelection()),
    GoRoute(path: '/re_claim_account', builder: (context, state) => const ReclaimAccount()),
    GoRoute(path: '/auth', builder: (context, state) => const Authentication()),
    GoRoute(path: '/signup', builder: (context, state) => const Signup()),
    GoRoute(path: '/userSignup', builder: (context, state) => const UserSignup()),
    GoRoute(
      path: '/otp_verification',
      builder: (context, state) => const OtpVerification(),
    ),
    GoRoute(
      path: '/upload_docs',
      builder: (context, state) => const UploadDocs(),
    ),
    GoRoute(
      path: '/upload_reclaim_docs',
      builder: (context, state) => const UploadReclaimDocs(),
    ),
    GoRoute(
      path: '/review',
      builder: (context, state) => const Review(),
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
      path: Routes.editOperationHoursRoute,
      builder: (context, state) => const EditOperationalHours(),
    ),
    GoRoute(
      path: Routes.galleryViewRoute,
      builder: (context, state) => const GalleryView(),
    ),
    GoRoute(
      path: Routes.slotManagementViewRoute,
      builder: (context, state) => const SlotManagementView(),
    ),

    // restaurant
    GoRoute(
      path: Routes.restaurantProfileRoute,
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: '/restaurant_events',
      builder: (context, state) => const Events(),
    ),
    GoRoute(
      path: '/restaurant_create_events',
      builder: (context, state) => const CreateEvent(),
    ),
    GoRoute(
      path: '/restaurant_event_details',
      builder: (context, state) => const EventDetails(),
    ),
    GoRoute(
      path: '/restaurant_bottom_tab',
      builder: (context, state) => const RestaurantBottomTab(),
    ),
    GoRoute(
      path: '/restaurant_create_post',
      builder: (context, state) => const CreatePost(),
    ),
    GoRoute(
      path: Routes.restaurantAddCuisineRoute,
      builder: (context, state) => const AddCuisine(),
    ),
    GoRoute(
      path: Routes.restaurantMenuViewRoute,
      builder: (context, state) => const MenuView(),
    ),

    //Customer
    GoRoute(
      path: '/customer_home',
      builder: (context, state) => const CustomerHome(),
    ),
    GoRoute(
      path: '/choice_selection',
      builder: (context, state) => const ChoiceSelection(),
    ),
    // GoRoute(
    //   path: '/sub_choice_selection',
    //   builder: (context, state) => const SubChoiceSelection(),
    // ),
    GoRoute(
      path: '/sub_choice_selection',
      builder: (context, state) {
        final selectedChoice = state.uri.queryParameters['selectedChoice'] ?? 'Default';
        return SubChoiceSelection(selectedChoice: selectedChoice);
      },
    ),
    GoRoute(
      path: '/create_choice',
      builder: (context, state) => const CreateChoice(),
    ),

    //wellness
    GoRoute(
      path: '/wellness_home',
      builder: (context, state) => const WellnessHome(),
    ),

  ],
);
