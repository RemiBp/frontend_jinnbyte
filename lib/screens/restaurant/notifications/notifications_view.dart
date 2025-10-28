import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../common/formatter.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/no_item_found.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import 'notifications_widgets.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool isLoaded = false;
  ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   PreferenceUtils.setBool(AppStrings.notificationKey, false);
  //   notificationEnabled.value = false;
  //   NotificationProvider notificationProvider =
  //   Provider.of<NotificationProvider>(context, listen: false);
  //   notificationProvider.getNotifications = GetNotificationsResponse();
  //   notificationProvider.isDataFetched = false;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notificationProvider.init(page: 1);
  //   });
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels >=
  //         scrollController.position.maxScrollExtent - 200 &&
  //         !notificationProvider.isLoadingMore &&
  //         (notificationProvider.getNotifications.currentPage ?? 0) <
  //             (notificationProvider.getNotifications.totalPages ?? 0)) {
  //       LoggerHelper.debug("Loading more Notifications...");
  //       notificationProvider.getNotificationAPI(
  //           page: (notificationProvider.getNotifications.currentPage?.toInt() ?? 0) + 1);
  //     }
  //   });
  // }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: al.notifications,
      ),
      body:
      // Consumer<NotificationProvider>(
      //     builder: (context, notificationProvider, _) {
      //       return notificationProvider.isDataFetched ?
            isLoaded
                ?
            ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: getHeight() * 0.025, left: sizes!.pagePadding, right: sizes!.pagePadding),
              itemCount: 10,
              itemBuilder: (context, index) {
                return  NotificationsCard(
                  title: al.shareExperienceReview + " The Wholesome Fork.",
                  time: Formatter.formatDateFromString(
                      "2025-01-10T16:41:00.799Z",
                  ),
                  isRead: false,
                  avatarUrl: "",
                  onTap: () async{
                    // final notification = notificationProvider.getNotifications.notifications?[index];
                    // if (notification != null) {
                    //   notificationProvider.readNotificationAPI(
                    //       notificationId: notification.id.toString(),
                    //   );
                    //   await notificationProvider.getNotificationAPI(page: 1);
                    // }
                  },
                );
              },
            )
                :
            GestureDetector(
              onTap: (){
                setState(() {
                  isLoaded = true;
                });
              },
              child: NoItemFound(
                image: Assets.noNotificationIcon,
                title: al.noNotificationsYet,
                subTitle: al.notificationsDescription,
                margin: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
              ),
            )
            //     :
            // const Center(
            //   child: CircularProgressIndicator(),
            // );
          // }),

    );
  }
}
