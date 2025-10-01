import 'package:choice_app/screens/restaurant/dashboard/rating_by_theme_card.dart';
import 'package:choice_app/screens/restaurant/dashboard/repeat_customers_card.dart';
import 'package:choice_app/screens/restaurant/dashboard/user_origin_map_card.dart';
import 'package:choice_app/screens/restaurant/dashboard/weekly_rating_card.dart';
import 'package:choice_app/screens/restaurant/notifications/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../appColors/colors.dart';
import '../../../res/res.dart';
import '../../../userRole/role_provider.dart';
import '../../../userRole/user_role.dart';
import 'booking_chart_card.dart';
import 'customers_chart_card.dart';
import 'dashboard_card.dart';
import 'dish_drop_alert_cart.dart';
import 'home_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late ProfileProvider profileProvider;
  // late NotificationProvider notificationProvider;

  // @override
  // void initState() {
  //   super.initState();
  //   profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  //   notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
  //
  //   profileProvider.init(context: context);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notificationProvider.getNotificationAPI(page: 1, limit: 50);
  //     profileProvider.getProfileEndPointAPI();
  //     profileProvider.getOnBoardingDetailAPI();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Provider.of<NotificationProvider>(context, listen: true);
    final role = context.read<RoleProvider>().role;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                // isSeen: !(notificationProvider.hasUnreadNotifications ?? true),
                isSeen: false,
                onNotificationTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsView()),
                  );
                  // Navigator.push(context, Transitions(page: const NotificationsView())).then((onValue){
                  //   notificationProvider.getNotificationAPI(page: 1, limit: 50);
                  // });
                },
              ),
              SizedBox(height: getHeightRatio() * 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    width: getWidth() * 0.42,
                  ),
                  DashboardCard(
                    width: getWidth() * 0.42,
                    header: "Bookmark",
                    price: "348",
                  ),
                ],
              ),
              SizedBox(height: getHeightRatio() * 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard(
                    width: getWidth() * 0.42,
                    header: "Choices Made",
                    price: "348",
                  ),
                  DashboardCard(
                    width: getWidth() * 0.42,
                    header: "Conversion Rate",
                    price: "348",
                  ),
                ],
              ),
              SizedBox(height: getHeightRatio() * 16),
              DashboardCard(
                width: getWidth() * 0.9,
                header: "Post Conversion Rate",
                price: "18%",
              ),
              SizedBox(height: getHeightRatio() * 16),
              DashboardCard(
                width: getWidth() * 0.9,
                header: "Favorite choice of the month",
                price: "18%",
                duration: "This Week",
              ),
              SizedBox(height: getHeightRatio() * 16),
              UserOriginMapCard(),
              SizedBox(height: getHeightRatio() * 16),
              /// Role-based chart
              if (role == UserRole.restaurant) ...[
                const CustomersChartCard(), // monthly
              ] else if (role == UserRole.wellness || role == UserRole.leisure) ...[
                WeeklyRatingsChartCard(), // weekly 0–5 chart
              ],
              SizedBox(height: getHeightRatio() * 16),
              const BookingChartCard(),
              SizedBox(height: getHeightRatio() * 16),
              const RepeatCustomersCard(),
              SizedBox(height: getHeightRatio() * 16),
              if (role == UserRole.restaurant) ...[
                MostChosenDishCard(
                  header: "Most Chosen Dish",
                  price: "Crème Brûlée",
                ),
              ] else if (role == UserRole.wellness) ...[
                MostChosenDishCard(
                  header: "Waiting Time Complaints",
                  price: "23%",
                  bottomText: "choices flagged long wait times",
                ),
              ] else if (role == UserRole.leisure) ...[
                MostChosenDishCard(
                  header: "Top Performing Event Type",
                  price: "Drag Show",
                  bottomText: "2x more than live music",
                ),
              ],



              SizedBox(height: getHeightRatio() * 16),
              if (role == UserRole.restaurant) ...[
                const DishDropAlertsCard(), // monthly
              ] else if (role == UserRole.wellness || role == UserRole.leisure) ...[
                WeeklyRatingsChartCard(), // weekly 0–5 chart
              ],
              SizedBox(height: getHeightRatio() * 16),
              const RatingsByThemeCard(),
              SizedBox(height: getHeight() * 0.025),
            ],
          ),
        ),
      ),
    );
  }

}
