import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import '../../l18n.dart';
import 'offer_widgets.dart';

class HeatmapScreen extends StatefulWidget {
  const HeatmapScreen({super.key});

  @override
  State<HeatmapScreen> createState() => _HeatmapScreenState();
}

class _HeatmapScreenState extends State<HeatmapScreen> {
  String selectedTime = al.allDay;
  String selectedFrequency = al.everyday;

  final List<String> timeFilters = [
    al.allDay,
    al.morning,
    al.afternoon,
    al.evening,
    al.night,
  ];

  final List<String> frequencyFilters = [
    al.everyday,
    al.monday,
    al.tuesday,
    al.wednesday,
    al.thursday,
    al.friday,
    al.saturday,
    al.sunday,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getHeight() * 0.15),
        child: SafeArea(
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(
              horizontal: getWidth() * 0.05,
              vertical: getHeight() * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    SizedBox(width: getWidth() * 0.03),
                    CustomText(
                      text: al.heatmap,
                      fontSize: getWidth() * 0.05,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),

                // More spacing between Heatmap and dropdowns
                SizedBox(height: getHeight() * 0.025),

                // Filters Row (All day / Everyday)
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        value: selectedTime,
                        items: timeFilters,
                        onChanged: (v) => setState(() => selectedTime = v!),
                      ),
                    ),
                    SizedBox(width: getWidth() * 0.03),
                    Expanded(
                      child: _buildDropdown(
                        value: selectedFrequency,
                        items: frequencyFilters,
                        onChanged: (v) => setState(() => selectedFrequency = v!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Divider below the entire AppBar (outside it)
      body: Column(
        children: [
          const Divider(
            color: Color(0xFFE0E0E0),
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: Stack(
              children: [
                // Heatmap background
                Positioned.fill(
                  child: Image.asset(
                    Assets.heatmapImage,
                    fit: BoxFit.cover,
                  ),
                ),

                // + / - buttons at top-right of map
                Positioned(
                  top: getHeight() * 0.03,
                  right: getWidth() * 0.04,
                  child: Column(
                    children: [
                      _buildSideButton(Icons.add, () {
                        // zoom in
                      }),
                      SizedBox(height: getHeight() * 0.01),
                      _buildSideButton(Icons.remove, () {
                        // zoom out
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Floating Create Offer button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.getPrimaryColorFromContext(context),
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: CustomText(
          text: al.createOffer,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: getWidth() * 0.035,
        ),
        onPressed: () {

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const OfferTemplateBottomSheet(),
          );

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Rectangular side buttons (+, -)
  Widget _buildSideButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.black87, size: 22),
        ),
      ),
    );
  }

  // Custom dropdown (All day / Everyday)
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: getHeight() * 0.045,
      padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.03),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.greyBordersColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: CustomText(
                text: e,
                fontSize: getWidth() * 0.03,
                color: AppColors.blackColor,
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
