import 'package:choice_app/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../appAssets/app_assets.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../l18n.dart';
import '../../../../res/res.dart';

class EventInfoSection extends StatelessWidget {
  const EventInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            label: CustomText(
              text: al.event,
              fontSize: sizes?.fontSize12,
              fontFamily: Assets.onsetMedium,
              color: HexColor.fromHex("#FF5655"),
            ),
          ),
          SizedBox(height: 8),
          CustomText(
            text: "Wine & Dine Evening",
            fontSize: sizes?.fontSize20,
            fontFamily: Assets.onsetSemiBold,
          ),
          SizedBox(height: 12),
          IconTextRow(
            text: "Monday, June 28, 2025",
            svgString: Assets.calenderCircleSvg,
            subText: "08:00 PM - 11:00 PM",
          ),
          SizedBox(height: getHeight() * .02),
          IconTextRow(
            text: "Gustave Eiffel, Paris, France",
            svgString: Assets.locationCircleSvg,
            subText: " Av. Gustave Eiffel, 75007 Paris, France",
          ),
          SizedBox(height: getHeight() * .02),
          IconTextRow(
            text: "\$30.00/per person",
            svgString: Assets.ticketCircleSvg,
            subText: "Ticket price",
          ),

        ],
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  const IconTextRow({
    super.key,
    required this.text,
    required this.svgString,
    required this.subText,
  });

  final String text;
  final String subText;
  final String svgString;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svgString),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: text,
              fontSize: sizes?.fontSize14,
              fontFamily: Assets.onsetMedium,
            ),
            CustomText(text: subText, fontSize: sizes?.fontSize12),
          ],
        ),
      ],
    );
  }
}
