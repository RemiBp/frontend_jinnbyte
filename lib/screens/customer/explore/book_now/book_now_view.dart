import 'package:flutter/material.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  int persons = 2;
  final double pricePerPerson = 30.0;

  @override
  Widget build(BuildContext context) {
    double totalPrice = persons * pricePerPerson;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Book Now"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Number of Persons",
              fontSize: sizes?.fontSize14,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: getHeight() * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyBordersColor),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 20),
                    color: AppColors.blackColor,
                    onPressed: persons > 1
                        ? () => setState(() => persons--)
                        : null,
                  ),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: persons.toString(),
                        fontSize: sizes?.fontSize16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    color: AppColors.blackColor,
                    onPressed: () => setState(() => persons++),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding, vertical: getHeight() * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withAlpha(20),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomText(
                  text: "$persons Persons",
                  fontSize: sizes?.fontSize12,
                  color: AppColors.primarySlateColor,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                CustomText(
                  text: "\$${totalPrice.toStringAsFixed(2)}",
                  fontSize: sizes?.fontSize16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                CustomText(
                  text: "\$${pricePerPerson.toStringAsFixed(2)}",
                  fontSize: sizes?.fontSize16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "/per person",
                  fontSize: sizes?.fontSize12,
                  color: AppColors.primarySlateColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: getHeight() * 0.02),
            CustomButton(
              buttonText: "Continue",
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
