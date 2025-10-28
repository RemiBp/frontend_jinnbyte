import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_drop_down.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../l18n.dart';
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

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    profileProvider.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.getCuisineTypes();
    });
  }

  final List<CuisineType> dummyCuisineTypes = [
    CuisineType(id: 1, name: al.italian),
    CuisineType(id: 2, name: al.chinese),
    CuisineType(id: 3, name: al.mexican),
    CuisineType(id: 4, name: al.indian),
  ];

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.cuisine),
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
               TextFieldLabel(label: al.cuisineType),
              if (profileProvider.getCuisineTypesResponse != null)
                CustomDropdown(
                  items:
                      profileProvider.getCuisineTypesResponse!.cuisineTypes!
                          .map((c) {
                            return DropdownMenuItem<int>(
                              value: c.id,
                              child: CustomText(
                                text: c.name ?? '',
                                fontWeight: FontWeight.w400,
                                fontSize: sizes?.fontSize16,
                                lines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            );
                          })
                          .toList(),
                  selectedValue: selectedCuisineId,
                  hintText: al.selectCuisineType,
                  onChanged: (id) {
                    setState(() {
                      selectedCuisineId = id!;
                      selectedCuisine = [
                        CuisineType(id: 1, name: al.italian),
                        CuisineType(id: 2, name: al.chinese),
                        CuisineType(id: 3, name: al.mexican),
                      ].firstWhere((c) => c.id == id);
                    });
                  },
                  validator:
                      (id) => id == null ? al.selectCuisineType : null,
                ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    buttonText: al.cancel,
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
                    buttonText: al.saveChanges,
                    onTap: () async {
                      if (selectedCuisineId != null) {
                        final success = await profileProvider.setCuisineType(
                          cuisineTypeId: selectedCuisineId!,
                        );
                        if(success) {
                          context.push(Routes.editOperationHoursRoute);
                        }
                      } else {
                        Toasts.getErrorToast(text: al.selectCuisineType);
                      }
                    },
                    buttonWidth: getWidth() * .42,
                    backgroundColor: AppColors.getPrimaryColorFromContext(
                      context,
                    ),
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    textFontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
