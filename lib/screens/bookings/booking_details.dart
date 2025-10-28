import 'package:flutter/material.dart';
import '../../appColors/colors.dart';
import '../../customWidgets/common_app_bar.dart';
import '../../customWidgets/custom_text.dart';
import '../../l18n.dart';
import '../../res/res.dart';
import 'bookings_widgets.dart';

class BookingDetails extends StatefulWidget {
  final bool? isCancelled;
  const BookingDetails({super.key, this.isCancelled});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: al.bookingDetails,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding, vertical: getHeight() * 0.02),
        child: Column(
          children: [
            widget.isCancelled??false?
            Expanded(
              child: ListView(
                children: [
                  CustomText(
                    text: al.reason,
                    fontSize: sizes?.fontSize16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  CustomText(
                    text: al.reservationCanceledMessage,
                    fontSize: sizes?.fontSize14,
                    color: AppColors.primarySlateColor,
                    fontWeight: FontWeight.w500,
                    giveLinesAsText: true,
                  ),
                ],
              ),
            ):
            Expanded(
              child: ListView(
                children: [
                  CustomText(
                    text: al.bookingInformation,
                    fontSize: sizes?.fontSize16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  BookingInfoRow(label: al.bookingId, value: "A123456"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.numberOfPersons, value: "2 ${al.person}(s)"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.date, value: "Aug 28, 2025"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.time, value: "10:00 AM - 11:00 AM"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.amount, value: "\$90"),
                  Divider(color: AppColors.greyBordersColor, height: getHeight() * 0.03),
              
                  CustomText(
                    text: al.customerInformation,
                    fontSize: sizes?.fontSize16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  BookingInfoRow(label: al.customerName, value: "Mark Jones"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.emailLabel1, value: "example@email.com"),
                  SizedBox(height: getHeight() * 0.01),
                  BookingInfoRow(label: al.phoneLabel, value: "+33 (555) 000-0000"),
                  Divider(color: AppColors.greyBordersColor, height: getHeight() * 0.03),
              
                  CustomText(
                    text: al.internalNotes,
                    fontSize: sizes?.fontSize16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  CustomText(
                    text: "\"${al.allergyNote}\"",
                    fontSize: sizes?.fontSize14,
                    color: AppColors.primarySlateColor,
                    fontWeight: FontWeight.w500,
                    giveLinesAsText: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
