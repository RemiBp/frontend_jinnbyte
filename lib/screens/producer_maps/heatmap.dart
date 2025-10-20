import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';

class HeatmapScreen extends StatefulWidget {
  const HeatmapScreen({super.key});

  @override
  State<HeatmapScreen> createState() => _HeatmapScreenState();
}

class _HeatmapScreenState extends State<HeatmapScreen> {
  String selectedTime = "All day";
  String selectedFrequency = "Everyday";

  final List<String> timeFilters = [
    "All day",
    "Morning (6am–12pm)",
    "Afternoon (12pm–6pm)",
    "Evening (6pm–12am)",
    "Night (12am–6am)",
  ];

  final List<String> frequencyFilters = [
    "Everyday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getHeight() * 0.13),
        child: SafeArea(
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
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
                      text: "Heatmap",
                      fontSize: getWidth() * 0.05,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),

                SizedBox(height: getHeight() * 0.015),

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

                SizedBox(height: getHeight() * 0.015),

                // Divider at bottom of AppBar
                const Divider(
                  color: Color(0xFFE0E0E0),
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      /// Main Body (heatmap background)
      body: Stack(
        children: [
          // Heatmap image
          Positioned.fill(
            child: Image.asset(
              Assets.heatmapImage,
              fit: BoxFit.cover,
            ),
          ),

          // Side + / - buttons at TOP RIGHT
          Positioned(
            top: getHeight() * 0.13,
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

      // Floating create offer button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.getPrimaryColorFromContext(context),
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: CustomText(
          text: "Create Offer",
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: getWidth() * 0.035,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  /// Rectangular side buttons (+, -)
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

  /// Custom dropdown (All day / Everyday)
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
