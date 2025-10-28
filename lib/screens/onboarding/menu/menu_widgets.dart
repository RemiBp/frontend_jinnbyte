import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';

class MenuGroupWidget extends StatelessWidget {
  final MenuGroup menuGroup;
  final Function onAddDish;
  final Function(int, Dish)? onEditDish;
  final Function(int)? onDeleteDish;
  final Function()? onDeleteCategory;
  final bool? showOption;
  final bool? hideBorder;
  final String? optionText;
  final String? header;

  const MenuGroupWidget({
    super.key, 
    required this.menuGroup, 
    required this.onAddDish, 
    this.onEditDish,
    this.onDeleteDish,
    this.onDeleteCategory,
    this.hideBorder, 
    this.showOption, 
    this.optionText, 
    this.header
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: showOption??false?EdgeInsets.symmetric(horizontal: getWidth() * 0.05):EdgeInsets.zero,
          child: Row(
            children: [
              CustomText(
                text: header??'${menuGroup.title} (${menuGroup.dishes.length})',
                fontSize: sizes?.fontSize16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              const Spacer(),
              if(showOption??false)
              const Icon(Icons.add, color: AppColors.restaurantPrimaryColor),
              SizedBox(width: getWidth() * 0.01),
              GestureDetector(
                onTap: ()=> onAddDish(),
                child: CustomText(
                  text: optionText??al.addDish,
                  fontSize: sizes?.fontSize14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.getPrimaryColorFromContext(context),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: getHeight() * 0.02),
        ...menuGroup.dishes.asMap().entries.map((entry) {
          final index = entry.key;
          final dish = entry.value;
          return DishItemWidget(
            dish: dish, 
            showOption: showOption,
            onEdit: onEditDish != null ? () => onEditDish!(index, dish) : null,
            onDelete: onDeleteDish != null ? () => onDeleteDish!(index) : null,
          );
        }),
        hideBorder??false?SizedBox():
        Divider(height: getHeight() * 0.03),
      ],
    );
  }
}


class MenuGroupWithoutOptionWidget extends StatelessWidget {
  final MenuGroup menuGroup;
  final Function onAddDish;
  final bool? showOption;
  final bool? hideBorder;
  final String? optionText;
  final String? header;

  const MenuGroupWithoutOptionWidget({super.key, required this.menuGroup, required this.onAddDish, this.hideBorder, this.showOption, this.optionText, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: header??'${menuGroup.title} (${menuGroup.dishes.length})',
          fontSize: sizes?.fontSize16,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
        // SizedBox(height: getHeight() * 0.02),
        ...menuGroup.dishes.map((dish) => DishItemWidget(dish: dish, showOption: showOption,)),
        Divider(height: getHeight() * 0.03),
      ],
    );
  }
}



class DishItemWidget extends StatelessWidget {
  final Dish dish;
  final bool? showOption;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DishItemWidget({
    super.key, 
    required this.dish, 
    this.showOption,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: showOption??false? EdgeInsets.only(left: getWidth() * 0.05):EdgeInsets.zero,
      title: CustomText(
        text: dish.name,
        fontSize: sizes?.fontSize14,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      ),
      subtitle: CustomText(
        text: dish.description,
        fontSize: sizes?.fontSize12,
        fontWeight: FontWeight.w400,
        color: AppColors.primarySlateColor,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: '\$${dish.price}',
            fontSize: sizes?.fontSize14,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          if(showOption??false)
          SizedBox(width: sizes!.pagePadding),
          if(showOption??false)
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.more_vert),
            color: AppColors.whiteColor,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: al.edit,
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    CustomText(
                      text: al.edit,
                      fontSize: sizes?.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: al.delete,
                child: Row(
                  children: [
                    const Icon(Icons.delete, size: 18, color: Colors.red),
                    const SizedBox(width: 8),
                    CustomText(
                      text: al.delete,
                      fontSize: sizes?.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor,
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == al.edit && onEdit != null) {
                onEdit!();
              } else if (value == al.delete && onDelete != null) {
                onDelete!();
              }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryBottomSheet extends StatefulWidget {
  final Function(String) onAddCategory;
  
  const CategoryBottomSheet({super.key, required this.onAddCategory});
  
  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.pagePadding,
            vertical: getHeight() * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap height to content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: getWidth() * 0.25,
                    height: getHeight() * 0.006,
                    decoration: BoxDecoration(
                      color: AppColors.greyBordersColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: getHeight() * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: al.addCategoryTitle,
                      fontSize: sizes?.fontSize18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColors.primarySlateColor),
                    ),
                  ],
                ),
                SizedBox(height: getHeight() * 0.03),
                CustomField(
                  textEditingController: titleController,
                  borderColor: AppColors.greyBordersColor,
                  hint: "E.g: Eat Day, Main Menu, Specials...",
                  label: al.categoryTitle,
                ),
                SizedBox(height: getHeight() * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonText: al.cancel,
                      onTap: () => Navigator.pop(context),
                      buttonWidth: getWidth() * .42,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.blackColor,
                      textColor: AppColors.blackColor,
                      textFontWeight: FontWeight.w700,
                    ),
                    CustomButton(
                      buttonText: al.save,
                      onTap: () {
                        if (titleController.text.trim().isNotEmpty) {
                          widget.onAddCategory(titleController.text.trim());
                          Navigator.pop(context);
                        }
                      },
                      buttonWidth: getWidth() * .42,
                      backgroundColor: AppColors.getPrimaryColorFromContext(context),
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
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}

class AddDishBottomSheet extends StatefulWidget {
  final BuildContext context;
  final Function(Dish) onAddDish;
  final Dish? dish; // For editing existing dish
  
  const AddDishBottomSheet({
    super.key, 
    required this.context,
    required this.onAddDish,
    this.dish,
  });
  
  @override
  State<AddDishBottomSheet> createState() => _AddDishBottomSheetState();
}

class _AddDishBottomSheetState extends State<AddDishBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If editing existing dish, populate fields
    if (widget.dish != null) {
      nameController.text = widget.dish!.name;
      priceController.text = widget.dish!.price.toString();
      descriptionController.text = widget.dish!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding,
          vertical: getHeight() * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap height to content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: getWidth() * 0.25,
                  height: getHeight() * 0.006,
                  decoration: BoxDecoration(
                    color: AppColors.greyBordersColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: getHeight() * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: widget.dish != null ? al.editDish: al.addDish,
                      fontSize: sizes?.fontSize18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColors.primarySlateColor),
                    ),
                  ],
                ),
                SizedBox(height: getHeight() * 0.03),
                CustomField(
                  textEditingController: nameController,
                  borderColor: AppColors.greyBordersColor,
                  hint: "E.g: Brochette boeuf...",
                  label: al.dishName,
                ),
                SizedBox(height: getHeight() * 0.02),
                CustomField(
                  textEditingController: priceController,
                  borderColor: AppColors.greyBordersColor,
                  hint: "E.g: \$0.00",
                  label: al.price,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: getHeight() * 0.02),
                CustomField(
                  textEditingController: descriptionController,
                  height: getHeight() * .1,
                  borderColor: AppColors.greyBordersColor,
                  hint: al.briefDescriptionDish,
                  label: al.descriptionOptional,
                ),
                SizedBox(height: getHeight() * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonText: al.cancel,
                      onTap: () => Navigator.pop(context),
                      buttonWidth: getWidth() * .42,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.blackColor,
                      textColor: AppColors.blackColor,
                      textFontWeight: FontWeight.w700,
                    ),
                    CustomButton(
                      buttonText: al.save,
                      onTap: () {
                        if (nameController.text.trim().isNotEmpty && 
                            priceController.text.trim().isNotEmpty) {
                          final price = double.tryParse(priceController.text.trim()) ?? 0.0;
                          final dish = Dish(
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim(),
                            price: price,
                          );
                          widget.onAddDish(dish);
                          Navigator.pop(context);
                        }
                      },
                      buttonWidth: getWidth() * .42,
                      backgroundColor: AppColors.getPrimaryColorFromContext(context),
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

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}



class MenuGroup {
  final String title;
  final List<Dish> dishes;

  MenuGroup({required this.title, required this.dishes});
}

class Dish {
  final String name;
  final String description;
  final double price;

  Dish({required this.name, required this.description, required this.price});
}