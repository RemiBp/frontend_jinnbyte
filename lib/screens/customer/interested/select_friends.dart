import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_button.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:go_router/go_router.dart';

class SelectFriendsScreen extends StatefulWidget {
  const SelectFriendsScreen({super.key});

  @override
  State<SelectFriendsScreen> createState() => _SelectFriendsScreenState();
}

class _SelectFriendsScreenState extends State<SelectFriendsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> friends = [
    {"name": "Emelie", "image": "https://i.pravatar.cc/150?img=1"},
    {"name": "Abigail", "image": "https://i.pravatar.cc/150?img=2"},
    {"name": "Penelope", "image": "https://i.pravatar.cc/150?img=3"},
    {"name": "Dominick Balistrei", "image": "https://i.pravatar.cc/150?img=4"},
    {"name": "Group Name", "image": "https://i.pravatar.cc/150?img=5"},
  ];

  final Set<int> selectedFriends = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      // Custom AppBar section
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getHeight() * 0.14), // slightly taller for spacing
        child: SafeArea(
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight() * 0.015), // 👈 extra space from top

                // 🔙 Back button + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: getHeight() * 0.022,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: getWidth() * 0.02),
                    CustomText(
                      text: "Select Friends",
                      fontSize: sizes!.fontSize18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),

                SizedBox(height: getHeight() * 0.018),

                // 🔤 “To:” label + Search field row
                Row(
                  children: [
                    CustomText(
                      text: "To:",
                      fontSize: sizes!.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                    Expanded(
                      child: Container(
                        height: getHeight() * 0.048,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.greyColor.withValues(alpha: 0.2),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.035),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            fontSize: sizes!.fontSize14,
                            color: AppColors.blackColor,
                          ),
                          decoration: InputDecoration(
                            hintText: "Type a username or name",
                            hintStyle: TextStyle(
                              color: AppColors.inputHintColor,
                              fontSize: sizes!.fontSize14,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Divider under search bar
                Padding(
                  padding: EdgeInsets.only(top: getHeight() * 0.008),
                  child: Divider(
                    color: AppColors.greyBordersColor,
                    thickness: 1,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Main Content Scrollable
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedFriends.isNotEmpty) ...[
                    SizedBox(height: getHeight() * 0.012),
                    CustomText(
                      text: "Members: ${selectedFriends.length} out of ${friends.length}",
                      fontSize: sizes!.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: getHeight() * 0.012),

                    // ✅ Horizontally scrollable avatars
                    SizedBox(
                      height: getHeight() * 0.11,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedFriends.length,
                        itemBuilder: (context, index) {
                          final friendIndex = selectedFriends.elementAt(index);
                          final friend = friends[friendIndex];
                          return Padding(
                            padding: EdgeInsets.only(right: getWidth() * 0.03),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: getHeight() * 0.032,
                                  backgroundImage: NetworkImage(friend["image"] ?? ""),
                                ),
                                SizedBox(height: getHeight() * 0.006),
                                SizedBox(
                                  width: getWidth() * 0.14,
                                  child: CustomText(
                                    text: friend["name"]!,
                                    fontSize: sizes!.fontSize10,
                                    color: AppColors.blackColor,
                                    textAlign: TextAlign.center,
                                    lines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(color: AppColors.greyBordersColor, thickness: 1, height: 1),
                  ],

                  // ✅ Friends list: no extra padding at top
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero, // 🔥 Removes all top spacing
                      itemCount: friends.length,
                      separatorBuilder: (_, __) => Divider(
                        color: AppColors.greyBordersColor,
                        thickness: 1,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final friend = friends[index];
                        final isSelected = selectedFriends.contains(index);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedFriends.remove(index);
                              } else {
                                selectedFriends.add(index);
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getHeight() * 0.012,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: getHeight() * 0.027,
                                  backgroundImage: NetworkImage(friend["image"] ?? ""),
                                ),
                                SizedBox(width: getWidth() * 0.04),
                                Expanded(
                                  child: CustomText(
                                    text: friend["name"] ?? "",
                                    fontSize: sizes!.fontSize14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackColor,
                                    lines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: isSelected
                                      ? AppColors.getPrimaryColorFromContext(context)
                                      : AppColors.greyBordersColor,
                                ),
                              ],
                            ),
                          ),
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

      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(sizes!.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 👈 so it wraps content tightly
          children: [
            Divider(
              color: AppColors.greyBordersColor,
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: getHeight() * 0.012), // small space after divider
            CustomButton(
              buttonText: "Send Invite",
              onTap: () {
                context.push(Routes.chatbotHomeRoute);
              },
              buttonWidth: double.infinity,
              backgroundColor: AppColors.getPrimaryColorFromContext(context),
              borderColor: Colors.transparent,
              textColor: AppColors.whiteColor,
              textFontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
