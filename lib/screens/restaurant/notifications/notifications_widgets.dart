import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/icon_svg.dart';
import '../../../res/res.dart';

class NotificationsCard extends StatelessWidget {
  final String avatarUrl;
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationsCard({
    super.key,
    required this.avatarUrl,
    required this.title,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    // String formatDuration(String date) {
    //   DateTime now = DateTime.now();
    //   Duration difference = now.difference(DateTime.parse(date));
    //   if (difference.inDays > 7) {
    //     int weeks = (difference.inDays / 7).floor();
    //     return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    //   } else if (difference.inDays > 0) {
    //     return difference.inDays == 1 ? '1 day ago' : '${difference.inDays} days ago';
    //   } else if (difference.inHours > 0) {
    //     return difference.inHours == 1 ? '1 hour ago' : '${difference.inHours} hours ago';
    //   } else if (difference.inMinutes > 0) {
    //     return difference.inMinutes == 1 ? '1 minute ago' : '${difference.inMinutes} minutes ago';
    //   } else {
    //     return 'just now';
    //   }
    // }

    return InkWell(
      onTap: onTap,
      child: Container(
        // decoration: BoxDecoration(
        //   color:AppColors.whiteColor,
        //   borderRadius: BorderRadius.circular(8),
        // ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              blurRadius: 24,
              offset: Offset(0, 4),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: getHeight() * 0.01),
        padding: EdgeInsets.symmetric(vertical: getHeight() * 0.02),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child:  avatarUrl==""?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidthRatio() * 9, vertical: getHeightRatio() * 9),
                    decoration: BoxDecoration(
                      color: AppColors.getPrimaryColorFromContext(context).withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                    child: SvgIcon(
                      Assets.reviewsIcon,
                      color: AppColors.getPrimaryColorFromContext(context),
                      // color: iconColor,
                    ),
                  ):
                  ClipOval(
                    child: Image.network(
                      avatarUrl,
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return  const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: getWidth() * 0.025),
                Expanded(
                  child: CustomText(
                    text: title,
                    fontSize: sizes?.fontSize14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primarySlateColor,
                    lines: 2,
                  ),
                ),
                if (!isRead) ...[
                  // const SizedBox(width: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.redColor,
                    ),
                  ),
                ],
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Expanded(
                //       child: CustomText(
                //         text: title,
                //         fontSize: sizes?.fontSize14,
                //         fontWeight: FontWeight.w400,
                //         lines: 2,
                //       ),
                //     ),
                //     if (!isRead) ...[
                //       const SizedBox(width: 12),
                //       Container(
                //         width: 8,
                //         height: 8,
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: AppColors.redColor,
                //         ),
                //       ),
                //     ],
                //     // Expanded(
                //     //   child: Column(
                //     //     crossAxisAlignment: CrossAxisAlignment.start,
                //     //     children: [
                //     //       CustomText(
                //     //         text: title,
                //     //         fontSize: sizes?.fontSize14,
                //     //         fontWeight: FontWeight.w400,
                //     //         lines: 2,
                //     //       ),
                //     //       SizedBox(height: getHeight() * 0.005),
                //     //       Row(
                //     //         children: [
                //     //           SvgIcon(
                //     //             Assets.businessHourIcon,
                //     //             color: AppColors.redColor,
                //     //             // color: iconColor,
                //     //           ),
                //     //           SizedBox(width: getWidth() * 0.02),
                //     //           CustomText(
                //     //             text: time,
                //     //             fontSize: sizes?.fontSize12,
                //     //             fontWeight: FontWeight.w400,
                //     //             color: AppColors.greyColor,
                //     //           ),
                //     //         ],
                //     //       ),
                //     //     ],
                //     //   ),
                //     // ),
                //     // if (!isRead) ...[
                //     //   const SizedBox(width: 12),
                //     //   Container(
                //     //     width: 8,
                //     //     height: 8,
                //     //     decoration: const BoxDecoration(
                //     //       shape: BoxShape.circle,
                //     //       color: AppColors.redColor,
                //     //     ),
                //     //   ),
                //     // ],
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}