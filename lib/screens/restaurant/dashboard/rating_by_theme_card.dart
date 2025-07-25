import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class RatingsByThemeCard extends StatelessWidget {
  const RatingsByThemeCard({super.key});

  final List<Map<String, dynamic>> data = const [
    {'label': 'Service', 'value': 4.2},
    {'label': 'Place', 'value': 3.5},
    {'label': 'Ambiance', 'value': 3.8},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getHeightRatio() * 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Ratings by Experience Theme',
              fontSize: sizes?.fontSize14,
              fontWeight: FontWeight.w500,
              color: AppColors.primarySlateColor,
            ),
          ),
          SizedBox(height: getHeightRatio() * 16),
          ...data.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: getHeightRatio() * 12),
              child: Row(
                children: [
                  SizedBox(
                    width: getWidthRatio() * 80,
                    // child: Text(item['label'],),
                    child: CustomText(
                      text: item['label'],
                      fontWeight: FontWeight.w500,
                      fontSize: sizes?.fontSize12,
                      color: AppColors.blackColor,
                    )
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: getHeight() * 0.02,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: item['value'] / 5.0,
                          child: Container(
                            height: getHeight() * 0.02,
                            decoration: BoxDecoration(
                              color: AppColors.vibrantBlue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: getWidthRatio() * 12),
                  CustomText(
                    text: item['value'].toString(),
                    fontWeight: FontWeight.w500,
                    fontSize: sizes?.fontSize12,
                    color: AppColors.blackColor,
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
