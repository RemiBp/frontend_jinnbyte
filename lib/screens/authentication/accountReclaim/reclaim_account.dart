import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../res/toasts.dart';
import '../../../userRole/role_provider.dart';
import '../../../userRole/user_role.dart';
import 'reclaim_account_provider.dart';

class ReclaimAccount extends StatefulWidget {
  const ReclaimAccount({super.key});

  @override
  State<ReclaimAccount> createState() => _ReclaimAccountState();
}

class _ReclaimAccountState extends State<ReclaimAccount> {
  int _selected = -1;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Restore previously selected type if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restorePreviousSelection();
    });
  }

  void _restorePreviousSelection() {
    final provider = context.read<ReclaimAccountProvider>();
    final role = context.read<RoleProvider>().role;
    switch (role) {
      case UserRole.restaurant:
        provider.setType("restaurant");
        setState(() => _selected = 0);
        break;
      case UserRole.leisure:
        provider.setType("leisure");
        setState(() => _selected = 1);
        break;
      case UserRole.wellness:
        provider.setType("wellness");
        setState(() => _selected = 2);
        break;
      case UserRole.user:
        setState(() => _selected = -1);
        provider.setType(""); // clear just in case
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).size.width * 0.06;

    return Consumer<ReclaimAccountProvider>(
      builder: (context, provider, _) {
        final roleProvider = context.read<RoleProvider>();

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(backgroundColor: AppColors.whiteColor),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(pad, 0, pad, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight() * .02),
                    CustomText(
                      text: al.reclaimAccount,
                      fontSize: sizes?.fontSize26,
                      fontFamily: Assets.onsetSemiBold,
                    ),
                    CustomText(
                      text: al.retrieveAccess,
                      fontSize: sizes?.fontSize16,
                      color: AppColors.primarySlateColor,
                    ),
                    SizedBox(height: getHeight() * .01),
                    CustomText(
                      text: al.chooseOption,
                      fontSize: sizes?.fontSize14,
                      fontFamily: Assets.onsetMedium,
                      color: AppColors.primarySlateColor,
                    ),
                    const SizedBox(height: 12),

                    // Category chips
                    Row(
                      children: [
                        CategoryChip(
                          label: al.categoryRestaurant,
                          svgString: Assets.restaurantIcon,
                          selected: _selected == 0,
                          selectedColor: AppColors.restaurantPrimaryColor,
                          iconColor: AppColors.restaurantPrimaryColor,
                          onTap: () {
                            roleProvider.setRole(UserRole.restaurant);
                            provider.setType("restaurant");
                            setState(() => _selected = 0);
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: al.categoryLeisure,
                          svgString: Assets.leisureIcon,
                          selected: _selected == 1,
                          selectedColor: AppColors.leisurePrimaryColor,
                          iconColor: AppColors.leisurePrimaryColor,
                          onTap: () {
                            roleProvider.setRole(UserRole.leisure);
                            provider.setType("leisure");
                            setState(() => _selected = 1);
                          },
                        ),
                        const SizedBox(width: 12),
                        CategoryChip(
                          label: al.categoryWellness,
                          svgString: Assets.wellnessIcon,
                          selected: _selected == 2,
                          selectedColor: AppColors.wellnessPrimaryColor,
                          iconColor: AppColors.wellnessPrimaryColor,
                          onTap: () {
                            roleProvider.setRole(UserRole.wellness);
                            provider.setType("wellness");
                            setState(() => _selected = 2);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search Field
                    CustomField(
                      textEditingController: _searchCtrl,
                      borderColor: AppColors.greyBordersColor,
                      hint: al.searchPlaceholder,
                      prefixIconSvg: Assets.searchIcon,
                      onChanged: (value) {
                        provider.getProducerPlaces(query: value.trim());
                      },
                    ),

                    SizedBox(height: getHeight() * .03),

                    // Claim Button
                    CustomButton(
                      buttonText: al.claimAccount,
                      backgroundColor: _selected == 0
                          ? AppColors.restaurantPrimaryColor
                          : _selected == 1
                          ? AppColors.leisurePrimaryColor
                          : _selected == 2
                          ? AppColors.wellnessPrimaryColor
                          : AppColors.greyBordersColor,
                      onTap: () {
                        //  Validation checks
                        if (_selected == -1) {
                          Toasts.getErrorToast(text: al.selectType);
                          return;
                        }

                        if (_searchCtrl.text.trim().isEmpty ||
                            provider.selectedPlace == null) {
                          Toasts.getErrorToast(text: al.searchAPlace);
                          return;
                        }

                        //  Navigate if all good
                        context.push(
                          Routes.registrationRoute,
                          extra: {
                            "claimProducerId": provider.claimProducerId,
                          },
                        );
                      },
                    ),

                    SizedBox(height: getHeight() * .02),

                    // Divider line with "or"
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.greyBordersColor,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: CustomText(
                            text: al.orText,
                            fontSize: sizes?.fontSize14,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.greyBordersColor,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: getHeight() * .02),

                    // Signup Button
                    CustomButton(
                      buttonText: al.signupTitle,
                      backgroundColor: AppColors.blackColor,
                      onTap: () => context.push(Routes.signupRoute),
                    ),
                  ],
                ),
              ),

              // Search Results Dropdown
              if (provider.isSearching)
                const Center(child: CircularProgressIndicator())
              else if (provider.searchedPlaces.isNotEmpty)
                Positioned(
                  left: pad,
                  right: pad,
                  top: getHeight() * 0.38,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(maxHeight: getHeight() * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.searchedPlaces.length,
                      itemBuilder: (context, index) {
                        final place = provider.searchedPlaces[index];
                        return InkWell(
                          onTap: () {
                            provider.selectPlace(place);
                            _searchCtrl.text = place.name ?? "";
                            provider.searchedPlaces.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: CustomText(
                              text: place.name ?? "",
                              fontSize: sizes?.fontSize15,
                              fontFamily: Assets.onsetMedium,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String svgString;
  final bool selected;
  final Color selectedColor;
  final Color iconColor;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.svgString,
    required this.selected,
    required this.selectedColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? selectedColor : AppColors.greyBordersColor,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(getHeight() * .02),
            child: SvgPicture.asset(
              svgString,
              height: getHeight() * .035,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            text: label,
            fontSize: sizes?.fontSize12,
            fontFamily: Assets.onsetMedium,
            color: AppColors.primarySlateColor,
          ),
        ],
      ),
    );
  }
}
