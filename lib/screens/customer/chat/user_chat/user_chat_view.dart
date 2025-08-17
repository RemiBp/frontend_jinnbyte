import 'package:choice_app/screens/customer/chat/user_new_chat/user_new_chat_view.dart';
import 'package:flutter/material.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../customWidgets/custom_textfield.dart';
import '../../../../res/res.dart';
import '../../../restaurant/profile_menu/profile_menu_widgets.dart';
import '../custom_category_tabs.dart';

class UserChatView extends StatefulWidget {
  const UserChatView({super.key});

  @override
  State<UserChatView> createState() => _UserChatViewState();
}

class _UserChatViewState extends State<UserChatView> {
  final List<Map<String, String>> users = const [
    {
      'name': 'Emelie',
      'username': 'emelie645',
      'image':
      'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?fit=crop&w=200&q=80'
    },
    {
      'name': 'Olivia',
      'username': 'olivia223',
      'image':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=200&q=80'
    },
    {
      'name': 'Sophia',
      'username': 'sophia007',
      'image':
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?fit=crop&w=200&q=80'
    },
    // ... remaining users
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Chat",
        showBackArrow: false,
        hideBottomBorder: true,
      ),
      body: CustomCategoryTabs(
        categories: [
          {'id': 1, 'label': 'Friends'},
          {'id': 2, 'label': 'Restaurants'},
          {'id': 3, 'label': 'Leisure'},
          {'id': 4, 'label': 'Wellness'},
        ],
        builder: (category) {
          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                child: CustomField(
                  borderColor: AppColors.greyBordersColor,
                  hint: "Search by name...",
                  label: "",
                  prefixIconSvg: Assets.searchIcon,
                ),
              ),
              SizedBox(height: getHeight() * 0.02),
              Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  padding:  EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                  separatorBuilder: (_, __) => Divider(height: getHeight() * 0.025),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ChatTile(
                      name: user['name']!,
                      username: user['username']!,
                      imageUrl: user['image']!,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          ),
          backgroundColor: AppColors.userPrimaryColor,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserNewChatView()),
            );
          }, label: Row(
        children: [
          Icon(Icons.add, color: Colors.white,),
          CustomText(
            text: "New Chat",
            fontSize: sizes?.fontSize12,
            fontFamily: Assets.onsetMedium,
            color: Colors.white,
          ),
        ],
      )),
    );
  }
}
