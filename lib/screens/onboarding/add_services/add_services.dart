import 'package:choice_app/models/get_all_service_types_response.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/multiple_selection_dropdown.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../add_cuisine/add_cuisine.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  List<CuisineType> selectedServices = [];
  List<CuisineType> serviceOptions = [];

  List<CuisineType> _getServiceOptionsFromApi(
    GetAllServiceTypesResponse? apiResponse,
  ) {
    if (apiResponse != null && apiResponse.eventTypes.isNotEmpty) {
      return apiResponse.eventTypes
          .map(
            (eventType) => CuisineType(id: eventType.id, name: eventType.name),
          )
          .toList();
    }

    // Fallback to hardcoded data if API data is not available
    return [
      CuisineType(id: 1, name: al.aestheticCareAndWellBeing),
      CuisineType(id: 2, name: al.hairCareAndHairServices),
      CuisineType(id: 3, name: al.nailCareAndBodyModifications),
      CuisineType(id: 4, name: al.massageRelaxation),
      CuisineType(id: 5, name: al.skinTreatmentsFacials),
      CuisineType(id: 6, name: al.makeupBeautyServices),
      CuisineType(id: 7, name: al.waxingHairRemoval),
      CuisineType(id: 8, name: al.spaWellnessPackages),
      CuisineType(id: 9, name: al.laserTreatments),
      CuisineType(id: 10, name: al.tattooPiercingServices),
      CuisineType(id: 11, name: al.eyebrowEyelashTreatments),
      CuisineType(id: 12, name: al.bridalEventPackages),
      CuisineType(id: 13, name: al.dermatologyConsultation),
      CuisineType(id: 14, name: al.footHandCare),
      CuisineType(id: 15, name: al.hairTransplantScalpServices),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadServiceTypes();
    });
  }

  void _loadServiceTypes() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.init(context);
    await provider.getAllServiceTypes();
    _updateServiceOptions(provider);
  }

  void _updateServiceOptions(ProfileProvider provider) {
    setState(() {
      serviceOptions = _getServiceOptionsFromApi(
        provider.getAllServiceTypesResponse,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        // Update service options when API data is available
        if (provider.getAllServiceTypesResponse != null &&
            serviceOptions.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateServiceOptions(provider);
          });
        }

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CommonAppBar(title: al.services, showEditButton: true,),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: sizes!.pagePadding,
              vertical: getHeight() * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight() * 0.01),
                 TextFieldLabel(label: al.servicesType),
                MultiSelectDropdown(
                  options: serviceOptions,
                  selectedItems: selectedServices,
                  hintText: al.selectServicesType,
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
                        children:
                            selectedServices.map((service) {
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
                        if (selectedServices.isEmpty) {
                          Toasts.getErrorToast(
                            text: al.selectAtLeastOneServiceType,
                          );
                          return;
                        }

                        final serviceTypeIds =
                            selectedServices
                                .map((service) => service.id)
                                .toList();
                        final success = await provider.setServiceTypes(
                          serviceTypeIds: serviceTypeIds,
                        );
                        if(success) {
                          context.push(Routes.editOperationHoursRoute);
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
        );
      },
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
