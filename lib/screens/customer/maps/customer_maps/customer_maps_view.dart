import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../userRole/role_provider.dart';
import '../../../../userRole/user_role.dart';
import '../../../restaurant/profile_menu/profile_menu_widgets.dart';
import 'filters_bottom_sheet.dart';

class CustomerMapsView extends StatefulWidget {
  const CustomerMapsView({super.key});

  @override
  State<CustomerMapsView> createState() => _CustomerMapsViewState();
}

class _CustomerMapsViewState extends State<CustomerMapsView> {
  bool showHeatmap = false;
  final List<Map<String, dynamic>> filters = [
    {"title": "All", "icon": Assets.leisureIcon},
    {"title": "Friends", "icon": Assets.profileIcon},
    {"title": "Restaurant", "icon": Assets.knifeForkIcon},
    {"title": "Wellness", "icon": Assets.wellnessIcon},
    {"title": "Leisure", "icon": Assets.leisureIcon},
  ];

  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final roleProvider = context.read<RoleProvider>();
    return Scaffold(
      appBar: CommonAppBar(title: "Map & Location"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // Map image placeholder + optional heatmap overlay
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand, // 👈 ensures full area fill
                children: [
                  // Base map
                  Image.asset(
                    Assets.mapImage2,
                    fit: BoxFit.cover,
                  ),

                  //if role is not user then show heatmap.

                  if (roleProvider.role != UserRole.user && showHeatmap)
                    AnimatedOpacity(
                      opacity: showHeatmap ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Image.asset(
                        Assets.heatmapImage, // your heatmap image asset
                        fit: BoxFit.cover,
                        color: Colors.white.withValues(alpha: 0.7),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                ],
              ),
            ),


            /// Top filter chips (horizontal)
            SafeArea(
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => SizedBox(width: getWidth() * 0.02),
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return ChoiceChip(
                      avatar: SvgPicture.asset(
                        filter["icon"],
                        width: getWidthRatio() * 18,
                        height: getHeightRatio() * 18,
                        colorFilter: ColorFilter.mode(index == selectedFilterIndex
                            ? AppColors.whiteColor
                            : AppColors.primarySlateColor,BlendMode.srcIn),
                      ),
                      label: CustomText(
                        text: filter["title"],
                        fontSize: sizes?.fontSize12,
                        color: index == selectedFilterIndex
                            ? AppColors.whiteColor
                            : AppColors.primarySlateColor,
                        fontWeight: FontWeight.w500,
                      ),
                      selected: index == selectedFilterIndex,
                      selectedColor: AppColors.userPrimaryColor,
                      backgroundColor: AppColors.whiteColor,
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide.none,
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                    );

                  },
                ),
              ),
            ),


            /// Side control buttons (rectangular with rounded corners)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              right: 10,
              child: Column(
                children: [
                  _buildSideButton(Icons.filter_list_sharp, () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // allows 90% height (since you used 0.9 of screen height)
                      backgroundColor: Colors.transparent, // keeps your rounded corners visible
                      builder: (context) => const FiltersBottomSheet(),
                    );
                  }),

                  const SizedBox(height: 16),
                  _buildSideButton(Icons.public, () {
                    setState(() {
                      showHeatmap = !showHeatmap; // toggle heat map overlay
                    });                  }),
                  const SizedBox(height: 16),
                  _buildSideButton(Icons.add, () {

                  }),
                  const SizedBox(height: 8),
                  _buildSideButton(Icons.remove, () {
                    // zoom out
                  }),

                ],
              ),
            ),

            Positioned(
              bottom: getHeight() * 0.03,
              left: 0,
              right: 0,
              child: SizedBox(
                height: getHeightRatio() * 230,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: getWidth() * 0.06, right: getWidth() * 0.03),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: getWidthRatio() * 280,
                      child: BookmarkRestaurantCard(
                        imageUrl: "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
                        address: "123 Main Street, City",
                        rating: 4.2,
                        tag: "Wellness", // ← shows in top-left chip
                        isBookmarked: true,
                        margin: EdgeInsets.only(
                          top: getHeightRatio() * 8,
                          bottom: getHeightRatio() * 8,
                          right: getWidth() * 0.03,
                        ),
                        onBookmarkTap: () {
                          // handle bookmark toggle
                        },
                        onCardTap: () {
                          // handle navigation
                        },
                      ),

                    );
                  },
                ),
              ),
            ),



            /// Floating filter button (bottom right)
            // Positioned(
            //   bottom: 30,
            //   right: 20,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       // TODO: open FiltersBottomSheet
            //     },
            //     backgroundColor: Colors.white,
            //     child: const Icon(Icons.filter_alt, color: Colors.black87),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Rectangular side buttons (like in screenshot)
  Widget _buildSideButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
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
}


