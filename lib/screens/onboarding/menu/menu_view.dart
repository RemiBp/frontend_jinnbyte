import 'package:choice_app/res/res.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../l18n.dart';
import '../../../screens/restaurant/profile/profile_provider.dart';
import 'menu_widgets.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List<MenuGroup> menuGroups = [];

  void addCategory(String title) {
    setState(() {
      menuGroups.add(MenuGroup(title: title, dishes: []));
    });
  }

  void addDishToCategory(int categoryIndex, Dish dish) {
    setState(() {
      menuGroups[categoryIndex].dishes.add(dish);
    });
  }

  void editDish(int categoryIndex, int dishIndex, Dish updatedDish) {
    setState(() {
      menuGroups[categoryIndex].dishes[dishIndex] = updatedDish;
    });
  }

  void deleteDish(int categoryIndex, int dishIndex) {
    setState(() {
      menuGroups[categoryIndex].dishes.removeAt(dishIndex);
    });
  }

  void deleteCategory(int categoryIndex) {
    setState(() {
      menuGroups.removeAt(categoryIndex);
    });
  }

  Future<void> _saveMenuData() async {
    if (menuGroups.isEmpty) {
      debugPrint('No menu data to save');
      // Navigator.pop(context);
      return;
    }

    final provider = Provider.of<ProfileProvider>(context, listen: false);

    try {
      // Step 1: Add all categories one by one
      debugPrint('Step 1: Adding categories...');
      for (var menuGroup in menuGroups) {
        final success = await provider.addMenuCategory(
          menuCategory: menuGroup.title,
        );
        if (!success) {
          debugPrint('Failed to add category: ${menuGroup.title}');
          return;
        }
      }
      debugPrint('All categories added successfully');

      // Step 2: Get all categories with their IDs
      debugPrint('Step 2: Fetching categories with IDs...');
      final categoriesResponse = await provider.getMenuCategories();
      if (categoriesResponse == null ||
          categoriesResponse.menuCategories == null) {
        debugPrint('Failed to fetch categories');
        return;
      }
      debugPrint(
        'Categories fetched: ${categoriesResponse.menuCategories!.length}',
      );

      // Step 3: Add all dishes for each category
      debugPrint('Step 3: Adding dishes...');
      for (int i = 0; i < menuGroups.length; i++) {
        final menuGroup = menuGroups[i];

        // Find the corresponding category ID from the response
        final categoryId = _findCategoryId(
          categoriesResponse.menuCategories!,
          menuGroup.title,
        );
        if (categoryId == null) {
          debugPrint('Category ID not found for: ${menuGroup.title}');
          continue;
        }

        // Add all dishes for this category
        for (var dish in menuGroup.dishes) {
          final success = await provider.addMenuDish(
            name: dish.name,
            price: dish.price,
            description: dish.description,
            categoryId: categoryId,
          );
          if (!success) {
            debugPrint('Failed to add dish: ${dish.name}');
            return;
          }
        }
      }
      debugPrint('All dishes added successfully');
      Toasts.getSuccessToast(text: al.allDishesAddedSuccessfully);

      if (mounted) {
        context.push(
          Routes.slotManagementViewRoute,
          extra: {'isHomeFlow': false, 'isEdit': false},
        );
      }
    } catch (e) {
      debugPrint('Error saving menu data: $e');
    }
  }

  int? _findCategoryId(List<dynamic> categories, String categoryName) {
    for (var category in categories) {
      if (category.name == categoryName) {
        return category.id;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.menu, showEditButton: true),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: getHeight() * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
            //   child: CustomText(
            //     text: "Set Up Your Menu",
            //     fontSize: sizes?.fontSize28,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.blackColor,
            //   ),
            // ),
            SizedBox(height: getHeight() * 0.02),
            Expanded(
              child:
                  menuGroups.isEmpty
                      ? Center(
                        child: CustomText(
                          text:
                              "${al.noCategoriesAddedYet}\n${al.tapAddCategoryTitle}",
                          fontSize: sizes?.fontSize16,
                          color: AppColors.primarySlateColor,
                          textAlign: TextAlign.center,
                        ),
                      )
                      : ListView.builder(
                        itemCount: menuGroups.length,
                        itemBuilder: (context, index) {
                          return MenuGroupWidget(
                            menuGroup: menuGroups[index],
                            showOption: true,
                            onAddDish: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return AddDishBottomSheet(
                                    context: context,
                                    onAddDish: (dish) {
                                      addDishToCategory(index, dish);
                                    },
                                  );
                                },
                              );
                            },
                            onEditDish: (dishIndex, dish) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return AddDishBottomSheet(
                                    context: context,
                                    dish: dish,
                                    onAddDish: (updatedDish) {
                                      editDish(index, dishIndex, updatedDish);
                                    },
                                  );
                                },
                              );
                            },
                            onDeleteDish: (dishIndex) {
                              deleteDish(index, dishIndex);
                            },
                            onDeleteCategory: () {
                              deleteCategory(index);
                            },
                          );
                        },
                      ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth() * 0.05,
                vertical: getHeight() * 0.02,
              ),
              child: CustomButton(
                buttonText: "+ ${al.addCategoryTitle}",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return CategoryBottomSheet(
                        onAddCategory: (title) {
                          addCategory(title);
                        },
                      );
                    },
                  );
                },
                backgroundColor: Colors.transparent,
                borderColor: AppColors.getPrimaryColorFromContext(context),
                textColor: AppColors.getPrimaryColorFromContext(context),
                textFontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
              child: Row(
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
                      await _saveMenuData();
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
            ),
          ],
        ),
      ),
    );
  }
}
