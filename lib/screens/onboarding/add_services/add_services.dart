import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/multiple_selection_dropdown.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../res/res.dart';
import '../add_cuisine/add_cuisine.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  List<CuisineType> selectedServices = [];

  final List<CuisineType> serviceOptions = [
    CuisineType(id: 1, name: 'Aesthetic Care & Well-Being'),
    CuisineType(id: 2, name: 'Hair Care & Hair Services'),
    CuisineType(id: 3, name: 'Nail Care & Body Modifications'),
    CuisineType(id: 4, name: 'Massage & Relaxation'),
    CuisineType(id: 5, name: 'Skin Treatments & Facials'),
    CuisineType(id: 6, name: 'Makeup & Beauty Services'),
    CuisineType(id: 7, name: 'Waxing & Hair Removal'),
    CuisineType(id: 8, name: 'Spa & Wellness Packages'),
    CuisineType(id: 9, name: 'Laser Treatments'),
    CuisineType(id: 10, name: 'Tattoo & Piercing Services'),
    CuisineType(id: 11, name: 'Eyebrow & Eyelash Treatments'),
    CuisineType(id: 12, name: 'Bridal & Event Packages'),
    CuisineType(id: 13, name: 'Dermatology & Skin Care Consultation'),
    CuisineType(id: 14, name: 'Foot & Hand Care'),
    CuisineType(id: 15, name: 'Hair Transplant & Scalp Services'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Services",
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.pagePadding,
            vertical: getHeight() * .02,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight() * 0.01),
                const TextFieldLabel(
                  label: "Services Type",
                ),
                MultiSelectDropdown(
                  options: serviceOptions,
                  selectedItems: selectedServices,
                  hintText: 'Select services type',
                  onSelectionChanged: (updatedList) {
                    setState(() {
                      selectedServices = updatedList;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Wrap(
                        spacing: getWidth() * 0.02,
                        runSpacing: 0,
                        children: selectedServices.map((service) {
                          return Chip(
                            deleteIcon: const Icon(Icons.close),
                            deleteIconColor: AppColors.blackColor,
                            backgroundColor: AppColors.greyBordersColor,
                            label: CustomText(
                              text: service.name,
                              fontWeight: FontWeight.w400,
                              fontSize: sizes?.fontSize12,
                              color: AppColors.blackColor,
                            ),
                            onDeleted: () {
                              setState(() {
                                selectedServices.remove(service);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonText: 'Back',
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
                      buttonText: 'Continue',
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
              ]
          )
      ),
    );
  }
}


// class AddServices extends StatefulWidget {
//   const AddServices({super.key});
//
//   @override
//   State<AddServices> createState() => _AddServicesState();
// }
//
// class _AddServicesState extends State<AddServices> {
//   int? selectedCuisineId;
//   CuisineType? selectedCuisine;
//
//   final List<CuisineType> dummyCuisineTypes = [
//     CuisineType(id: 1, name: 'Italian'),
//     CuisineType(id: 2, name: 'Chinese'),
//     CuisineType(id: 3, name: 'Mexican'),
//     CuisineType(id: 4, name: 'Indian'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: CommonAppBar(
//         title: "Services",
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: sizes!.pagePadding,
//           vertical: getHeight() * .02,
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: getHeight() * 0.01),
//               const TextFieldLabel(
//                 label: "Service Type",
//               ),
//               CustomDropdown(
//                 items: [
//                   CuisineType(id: 1, name: 'Italian'),
//                   CuisineType(id: 2, name: 'Chinese'),
//                   CuisineType(id: 3, name: 'Mexican'),
//                 ].map((c) {
//                   return DropdownMenuItem<int>(
//                     value: c.id,
//                     child: CustomText(
//                       text: c.name,
//                       fontWeight: FontWeight.w400,
//                       fontSize: sizes?.fontSize16,
//                       lines: 1,
//                       textOverflow: TextOverflow.ellipsis,
//                     ),
//                   );
//                 }).toList(),
//                 selectedValue: selectedCuisineId,
//                 hintText: 'Select Service type',
//                 onChanged: (id) {
//                   setState(() {
//                     selectedCuisineId = id!;
//                     selectedCuisine = [
//                       CuisineType(id: 1, name: 'Italian'),
//                       CuisineType(id: 2, name: 'Chinese'),
//                       CuisineType(id: 3, name: 'Mexican'),
//                     ].firstWhere((c) => c.id == id);
//                   });
//                 },
//                 validator: (id) => id == null ? 'Please select cuisine type' : null,
//               ),
//
//               // Show list of Service type selection here
//
//               Spacer(),
//               CustomButton(buttonText: "Add Services")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
