import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';
import 'customers_chart_card.dart';

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
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HomeAppBar(
              //   isSeen: !(notificationProvider.hasUnreadNotifications ?? true),
              //   onNotificationTap: (){
              //     Navigator.push(context, Transitions(page: const NotificationsView())).then((onValue){
              //       notificationProvider.getNotificationAPI(page: 1, limit: 50);
              //     });
              //   },
              // ),

              SizedBox(height: getHeightRatio() * 16),
              CustomText(
                text: "Customer Trends",
                fontSize: sizes?.fontSize18,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeightRatio() * 6),
              const CustomersChartCard(),
              SizedBox(height: getHeightRatio() * 16),
              CustomText(
                text: "Booking Trends",
                fontSize: sizes?.fontSize18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getHeightRatio() * 6),
              // const BookingChartCard(),
              // SizedBox(height: getHeightRatio() * 16),
              // CustomText(
              //   text: "Returning Guests",
              //   fontSize: sizes.fontSize18,
              //   color: AppColors.homeHeaderColor,
              //   fontWeight: FontWeight.w600,
              // ),
              // SizedBox(height: getHeightRatio() * 6),
              // const RepeatCustomersCard(),
              // SizedBox(height: getHeight() * 0.025),
            ],
          ),
        ),
      ),
    );
  }

}
