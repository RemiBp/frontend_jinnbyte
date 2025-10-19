import 'dart:io';

import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/network/network_provider.dart';
import 'package:choice_app/screens/customer/home/choice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../res/toasts.dart';
import '../../../utilities/extensions.dart';

class CreateChoice extends StatefulWidget {
  const CreateChoice({super.key});

  @override
  _CreateChoiceState createState() => _CreateChoiceState();
}

class _CreateChoiceState extends State<CreateChoice> {
  String selectedDish = '';
  String visibility = 'Public';
  String? selectedEvent; // <-- NEW for Wellness/Leisure dropdown
  Map<String, double> ratings = {};

  List<XFile> images = [];
  List<String> imageUrls = [];
  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  Future<void> _pickImages() async {
    if (images.length >= 5) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(pickedFile);
      });
    }

  }

  // Remove image
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }







  /// Returns the appropriate rating categories based on `title`
  List<Map<String, dynamic>> getRatingCategories(String? title) {
    if (title == "Leisure") {
      return [
        {"label": "Stage Direction", "rating": 3.0},
        {"label": "Actor Performance", "rating": 4.0},
        {"label": "Text Quality", "rating": 2.0},
        {"label": "Scenography", "rating": 5.0},
      ];
    } else if (title == "Wellness") {
      return [
        {"label": "Care Quality", "rating": 4.0},
        {"label": "Cleanliness", "rating": 3.0},
        {"label": "Welcome", "rating": 5.0},
        {"label": "Value For Money", "rating": 2.0},
        {"label": "Atmosphere", "rating": 4.0},
        {"label": "Staff Experience", "rating": 3.0},
      ];
    } else {
      // Restaurant
      return [
        {"label": al.service, "rating": 1.0},
        {"label": al.place, "rating": 1.0},
        {"label": al.portions, "rating": 1.0},
        {"label": al.ambiance, "rating": 1.0},
      ];
    }
  }

  // --- Helper to show event picker (bottom sheet) ---
  void _showEventPicker(String categoryTitle) {
    final events = categoryTitle == "Leisure"
        ? ["Theatre Play", "Concert Night", "Comedy Show"]
        : ["Yoga Retreat", "Spa Session", "Meditation Class"];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index]),
            onTap: () {
              setState(() => selectedEvent = events[index]);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final categoryTitle = data?["title"];
    final placeId = data?["placeId"];
    final ratingCategories = getRatingCategories(categoryTitle);
    for (var item in ratingCategories) {
      ratings.putIfAbsent(item["label"], () => item["rating"]);
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Create Choice'),
        leading: BackButton(),
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: categoryTitle == "Leisure"
                    ? HexColor.fromHex("#F4E9F6")
                    : categoryTitle == "Wellness"
                    ? HexColor.fromHex("#EDF7EE")
                    : HexColor.fromHex("#FEF5E7"),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: categoryTitle == "Leisure"
                          ? HexColor.fromHex("#E9D5EC")
                          : categoryTitle == "Wellness"
                          ? HexColor.fromHex("#DCEEDC")
                          : HexColor.fromHex("#FDECCF"),
                    ),
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(data?["icon"]),
                  ),
                  SizedBox(width: getWidth() * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Olivia",
                        fontSize: sizes?.fontSize14,
                        fontFamily: Assets.onsetMedium,
                        giveLinesAsText: true,
                      ),
                      SizedBox(height: getHeight() * .005),
                      CustomText(
                        text: "58 Rue de Tilloy, Beauvais, Oise, France",
                        fontSize: sizes?.fontSize12,
                        giveLinesAsText: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: getHeight() * .02),
            CustomText(
              text: al.yourExperience,
              fontFamily: Assets.onsetSemiBold,
              fontSize: sizes?.fontSize18,
            ),
            SizedBox(height: 16),

            // --- Overall Rating Card ---
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: categoryTitle == "Wellness"
                        ? "Overall Wellness Rating"
                        : categoryTitle == "Leisure"
                        ? "Overall Leisure Rating"
                        : al.overallRestaurantRating,
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: getHeight() * .01),
                  Column(
                    children: List.generate(ratingCategories.length, (index) {
                      final item = ratingCategories[index];
                      return buildRatingRow(
                        item["label"],
                        item["rating"],
                        isLast: index == ratingCategories.length - 1,
                      );
                    }),
                  ),
                ],
              ),
            ),

            // --- Event Dropdown for Wellness/Leisure ---
            if (categoryTitle == "Wellness" || categoryTitle == "Leisure") ...[
              SizedBox(height: getHeight() * .02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 4),
                      blurRadius: 2,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Select ${categoryTitle} Event",
                      fontSize: sizes?.fontSize16,
                      fontFamily: Assets.onsetMedium,
                    ),
                    SizedBox(height: getHeight() * .01),
                    DropdownButtonFormField<String>(
                      value: selectedEvent,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getWidth() * .04,
                          vertical: getHeight() * .014,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.greyBordersColor),
                        ),
                      ),
                      hint: CustomText(
                        text: "Tap to select an event",
                        fontSize: sizes?.fontSize14,
                        color: AppColors.inputHintColor,
                      ),
                      items: (categoryTitle == "Leisure"
                          ? ["Theatre Play", "Concert Night", "Comedy Show"]
                          : ["Yoga Retreat", "Spa Session", "Meditation Class"])
                          .map((event) => DropdownMenuItem(
                        value: event,
                        child: CustomText(
                          text: event,
                          fontSize: sizes?.fontSize14,
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedEvent = value);
                      },
                    ),                    SizedBox(height: getHeight() * .02),

                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          SizeTransition(sizeFactor: animation, child: child),
                      child: selectedEvent == null
                          ? SizedBox.shrink(key: ValueKey('empty'))
                          : Container(
                        key: ValueKey('ratings_${selectedEvent!}'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: selectedEvent!,
                              fontFamily: Assets.onsetSemiBold,
                              fontSize: sizes?.fontSize16,
                            ),
                            SizedBox(height: getHeight() * .015),
                            Column(
                              children: List.generate(
                                getRatingCategories(categoryTitle).length,
                                    (index) {
                                  final item = getRatingCategories(
                                      categoryTitle)[index];
                                  return buildRatingRow(
                                    item["label"],
                                    item["rating"],
                                    isLast: index ==
                                        getRatingCategories(categoryTitle)
                                            .length -
                                            1,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getHeight() * .02), //  spacing after dropdown card
            ],

            // --- Restaurant: Dishes Section ---
            if (categoryTitle == "Restaurant") ...[
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 4),
                      blurRadius: 2,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: al.dishesAndMenusConsumed,
                      fontFamily: Assets.onsetMedium,
                      fontSize: sizes?.fontSize16,
                    ),
                    SizedBox(height: getHeight() * .01),
                    Column(
                      children: [
                        dishRadio(
                          menuName: "Brochettes (3)",
                          dishDetails: "Sauce blanche, saumon fume ",
                          "Al Salmone",
                          "\$20",
                        ),
                        dishRadio(
                          menuName: "Maki (3)",
                          dishDetails: "Sauce blanche, saumon fume",
                          "Maki (3)",
                          "\$20",
                          isLast: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ], Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Photos",
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  CustomText(
                    text: al.fileSupport,
                    fontSize: sizes?.fontSize12,
                  ),
                  SizedBox(height: getHeight() * .01),
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      height: getHeight() * 0.237,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.greyBordersColor),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: al.chooseAFile,
                              fontFamily: Assets.onsetMedium,
                              fontSize: sizes?.fontSize14,
                            ),
                            SizedBox(height: getHeight() * .005),
                            CustomText(
                              text: al.upTo5Images,
                              fontSize: sizes?.fontSize12,
                              color: HexColor.fromHex("#686A82"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(images.length, (index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(images[index].path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => _removeImage(index),
                        child: CircleAvatar(
                          radius: getHeight() * .018,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            size: getHeight() * .022,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            SizedBox(height: getHeight() * .02),

            // --- Tags ---
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset(0, 4),
                    blurRadius: 2,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: CustomField(
                textEditingController: tagsController,
                borderColor: AppColors.greyBordersColor,
                hint: "e.g: #cozy, #outdoor_seating",
                label: al.tags,
              ),
            ),

            SizedBox(height: getHeight() * .02),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Share Your Experience",
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize16,
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: shareExpController,
                      maxLines: 4,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Share your experience...',
                        hintStyle: TextStyle(color: Color(0xFF6B6C90)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  buildRadio('Public', 'Anyone can see the feed', 'Public'),
                  buildRadio(
                      'Friends Only', 'Your friends on Choice', 'Friends'),
                  buildRadio('Private', 'Only Me', 'Private'),
                ],
              ),
            ),

            SizedBox(height: getHeight() * .02),

            // --- Buttons ---
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getHeight() * .02,
                horizontal: getWidth() * .05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      buttonText: al.cancel,
                      backgroundColor: Colors.transparent,
                      textColor: AppColors.blackColor,
                      borderColor: AppColors.blackColor,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      buttonWidth: getWidth() * 0.43,
                      height: getHeight() * 0.055,
                      borderColor: AppColors.getPrimaryColorFromContext(
                          context),
                      backgroundColor: AppColors.userPrimaryColor,
                      buttonText: al.publish,
                      textColor: AppColors.whiteColor,
                      onTap: () {
                        debugPrint("rating is : $ratings, place id : $placeId, date time : ${DateTime.now().toUtc().toIso8601String()}");
                        onPublishTap(placeId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _selectedOption = 'Public';
  final TextEditingController shareExpController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();


  Future<void> onPublishTap(int placeId) async {
    final provider = context.read<NetworkProvider>();
    final choiceProvider = context.read<CustomerChoiceProvider>();
    provider.context = context;
    final description = shareExpController.text.trim();
    final tags = tagsController.text.trim();
    if (images.isEmpty) {
      Toasts.getErrorToast(
        text: al.errorSelectImage,);
    } else if (description.isEmpty) {
      Toasts.getErrorToast(
        text: al.errorEnterDescription,);
    } else if (tags.isEmpty) {
      Toasts.getErrorToast(
        text: al.errorEnterTags,);
    } else {

      for (var i in images) {
        final bytes = await i.readAsBytes();
        final fileUrl = await provider.getUrlForFileUpload(bytes);
        debugPrint("file url is : $fileUrl");
        if (fileUrl != null) {
          imageUrls.add(fileUrl);
        }
      }
      debugPrint("selected images are : $imageUrls");
    }
    if (imageUrls.isNotEmpty) {
      await choiceProvider.createChoice(
        placeId: placeId,
        status: _selectedOption.toLowerCase(),
        description: description,
        tags: tags.split(","),
        imageUrls: imageUrls,
        rating: ratings,
      );
    }
  }

  Widget buildRadio(String title, String subtitle, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: CustomText(
        text: title,
        fontSize: sizes?.fontSize14,
      ),
      subtitle: CustomText(
        text: subtitle,
        fontSize: sizes?.fontSize12,
      ),
      trailing: Radio(
        value: value,
        groupValue: _selectedOption,
        activeColor: AppColors.getPrimaryColorFromContext(context), // Blue ring
        onChanged: (val) {
          setState(() {
            _selectedOption = val!;
          });
        },
      ),
    );
  }

  // --- Dish Radio Helper ---
  Widget dishRadio(String title, String price,
      {required String menuName, required String dishDetails, bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: getHeight() * 0.008),
          child: CustomText(
            text: menuName,
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetSemiBold,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            final itemValue = '$menuName|$title|$index';
            final bool isSelected = selectedDish == itemValue;

            return InkWell(
              onTap: () {
                setState(() {
                  selectedDish = itemValue;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: getHeight() * 0.012),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: sizes?.fontSize14,
                            fontFamily: Assets.onsetMedium,
                          ),
                          SizedBox(height: getHeight() * 0.004),
                          CustomText(
                            text: dishDetails,
                            fontSize: sizes?.fontSize12,
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                      text: price,
                      fontSize: sizes?.fontSize14,
                      fontFamily: Assets.onsetMedium,
                    ),
                    Radio<String>(
                      value: itemValue,
                      groupValue: selectedDish,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          selectedDish = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (!isLast) Divider(height: 1, color: AppColors.greyBordersColor),
      ],
    );
  }

  Widget buildRatingRow(String title,
      double rating, {
        String? review,
        bool isLast = false,
      }) {
    final bool isZero = rating == 0;
    final Color activeColor =
    isZero ? AppColors.inputHintColor : Colors.orange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (review != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: sizes?.fontSize16,
                fontFamily: Assets.onsetMedium,
              ),
              InkWell(
                onTap: () {},
                child: CustomText(
                  text: al.remove,
                  fontSize: sizes?.fontSize14,
                  fontFamily: Assets.onsetMedium,
                  color: Colors.red,
                  decorationColor: Colors.red,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(height: getHeight() * .005),
          CustomText(
            text: review,
            fontSize: sizes?.fontSize12,
          ),
        ] else
          ...[
            CustomText(
              text: title,
              fontSize: sizes?.fontSize16,
              fontFamily: Assets.onsetMedium,
            ),
          ],
        SizedBox(height: getHeight() * .01),

        // 🔥 MODIFIED PART – clickable stars
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                5,
                    (index) =>
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          ratings[title] = (index + 1).toDouble();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.star,
                          size: 28,
                          color: index < (ratings[title] ?? rating)
                              ? Colors.amber
                              : AppColors.greyColor,
                        ),
                      ),
                    ),
              ),
            ),
            Container(
              width: getWidth() * 0.12,
              height: getHeight() * 0.045,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: activeColor, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                text: (ratings[title] ?? rating).toStringAsFixed(1),
                fontSize: sizes?.fontSize14,
                fontFamily: Assets.onsetMedium,
                color: activeColor,
              ),
            ),
          ],
        ),

        if (!isLast) ...[
          SizedBox(height: getHeight() * .015),
          Divider(height: 1, color: AppColors.greyBordersColor),
          SizedBox(height: getHeight() * .015),
        ],
      ],
    );
  }
}
