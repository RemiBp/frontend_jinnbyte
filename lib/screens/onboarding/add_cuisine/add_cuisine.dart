import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_drop_down.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../res/res.dart';
import '../business_hours/edit_business_hours/edit_operational_hours.dart';

class CuisineType {
  final int id;
  final String name;

  CuisineType({required this.id, required this.name});
}

class AddCuisine extends StatefulWidget {
  const AddCuisine({super.key});

  @override
  State<AddCuisine> createState() => _AddCuisineState();
}

class _AddCuisineState extends State<AddCuisine> {
  int? selectedCuisineId;
  CuisineType? selectedCuisine;

  final List<CuisineType> dummyCuisineTypes = [
    CuisineType(id: 1, name: 'Italian'),
    CuisineType(id: 2, name: 'Chinese'),
    CuisineType(id: 3, name: 'Mexican'),
    CuisineType(id: 4, name: 'Indian'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Cuisine",
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.pagePadding,
            vertical: getHeight() * .02,
          ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(
              //   text: "Cuisine",
              //   fontSize: sizes?.fontSize28,
              //   fontFamily: Assets.onsetSemiBold,
              // ),
              SizedBox(height: getHeight() * 0.01),
              const TextFieldLabel(
                label: "Cuisine Type",
              ),
              CustomDropdown(
                items: [
                  CuisineType(id: 1, name: 'Italian'),
                  CuisineType(id: 2, name: 'Chinese'),
                  CuisineType(id: 3, name: 'Mexican'),
                ].map((c) {
                  return DropdownMenuItem<int>(
                    value: c.id,
                    child: CustomText(
                      text: c.name,
                      fontWeight: FontWeight.w400,
                      fontSize: sizes?.fontSize16,
                      lines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                selectedValue: selectedCuisineId,
                hintText: 'Select cuisine type',
                onChanged: (id) {
                  setState(() {
                    selectedCuisineId = id!;
                    selectedCuisine = [
                      CuisineType(id: 1, name: 'Italian'),
                      CuisineType(id: 2, name: 'Chinese'),
                      CuisineType(id: 3, name: 'Mexican'),
                    ].firstWhere((c) => c.id == id);
                  });
                },
                validator: (id) => id == null ? 'Please select cuisine type' : null,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: 'Cancel',
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonWidth: getWidth() * .42,
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.blackColor,
                    textColor: AppColors.blackColor,
                    textFontWeight: FontWeight.w700,
                  ),
                  CustomButton(
                    buttonText: 'Save Changes',
                    onTap: () {
                    },
                    buttonWidth: getWidth() * .42,
                    backgroundColor: AppColors.getPrimaryColorFromContext(context),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
