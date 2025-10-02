import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../appAssets/app_assets.dart';
import '../../appColors/colors.dart';
import '../../customWidgets/common_app_bar.dart';
import '../../customWidgets/custom_text.dart';
import '../../l18n.dart';
import '../../res/res.dart';
import 'bookings_widgets.dart';
import '../../userRole/role_provider.dart';
import '../../userRole/user_role.dart';

class UserBookingDetails extends StatefulWidget {
  final bool? isCancelled;
  const UserBookingDetails({super.key, this.isCancelled});

  @override
  State<UserBookingDetails> createState() => _UserBookingDetailsState();
}

class _UserBookingDetailsState extends State<UserBookingDetails> {
  @override
  Widget build(BuildContext context) {
    final role = context.watch<RoleProvider>().role;
    final isWellness = role == UserRole.wellness;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.bookingDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: ListView(
          children: [
            //  Booking Information Heading
            CustomText(
              text: al.bookingInformation,
              fontSize: sizes?.fontSize16,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getHeight() * 0.02),

            //  Image Placeholder (replace with your asset later)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Assets.restaurantImage, // replace with your actual asset
                height: getHeight() * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: getHeight() * 0.02),

            //  Restaurant/Wellness Name + Address
            CustomText(
              text: isWellness ? "Serene Bloom Spa" : "Flavors of the Season",
              fontSize: sizes?.fontSize16,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 4),
            CustomText(
              text: "12 Rue de Rivoli, 75001 Paris, France",
              fontSize: sizes?.fontSize14,
              color: AppColors.primarySlateColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: getHeight() * 0.02),

            //  Booking Details
            BookingInfoRow(label: "Booking ID", value: "#3956839"),
            SizedBox(height: getHeight() * 0.01),
            BookingInfoRow(label: "No. of Persons", value: "2 Person"),
            SizedBox(height: getHeight() * 0.01),
            BookingInfoRow(label: "Date", value: "Aug 28, 2025"),
            SizedBox(height: getHeight() * 0.01),
            BookingInfoRow(label: "Time", value: "10:00 AM - 11:00 AM"),
            SizedBox(height: getHeight() * 0.01),
            isWellness
                ? BookingInfoRow(
              label: "Services",
              value:
              "Hair Care & Hair Services, Aesthetic Care & Well-Being",
            )
                : BookingInfoRow(label: "Amount", value: "\$90"),

            Divider(
              color: AppColors.greyBordersColor,
              height: getHeight() * 0.03,
            ),

            // 🔹 Internal Notes
            CustomText(
              text: al.internalNotes,
              fontSize: sizes?.fontSize16,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getHeight() * 0.02),
            CustomText(
              text: isWellness
                  ? "Lorem ipsum dolor sit amet consectetur."
                  : "Allergic to peanuts. Request outdoor seating.",
              fontSize: sizes?.fontSize14,
              color: AppColors.primarySlateColor,
              fontWeight: FontWeight.w500,
              giveLinesAsText: true,
            ),
          ],
        ),
      ),
    );
  }
}
