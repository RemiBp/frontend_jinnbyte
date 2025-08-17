import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';
import '../chat_widgets.dart';

class NewGroupView extends StatefulWidget {
  const NewGroupView({super.key});

  @override
  State<NewGroupView> createState() => _NewGroupViewState();
}

class _NewGroupViewState extends State<NewGroupView> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> users = [
    {
      "name": "Emelie",
      "username": "emelie645",
      "image": "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?fit=crop&w=200&q=80"
    },
    {
      "name": "Abigail",
      "username": "abigail645",
      "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?fit=crop&w=200&q=80"
    },
    {
      "name": "Penelope",
      "username": "penelope645",
      "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?fit=crop&w=200&q=80"
    },
    {
      "name": "Doreen Bayer",
      "username": "doreenbayer645",
      "image": "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?fit=crop&w=200&q=80"
    },
  ];

  List<Map<String, String>> selectedUsers = [];

  void toggleUser(Map<String, String> user) {
    setState(() {
      if (selectedUsers.contains(user)) {
        selectedUsers.remove(user);
      } else {
        selectedUsers.add(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: ChatAppBar(
        title: 'New Group',
        onNext: () {
          // handle next
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedUsers.isEmpty)
          SizedBox(height: getHeight() * 0.02),
          if (selectedUsers.isNotEmpty)
            SelectedMembersRow(selectedUsers: selectedUsers),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
            child: CustomText(
              text: "Suggested",
              fontWeight: FontWeight.w600,
              fontSize: sizes?.fontSize16,
            ),
          ),
          SizedBox(height: getHeight() * 0.015),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
              itemCount: users.length,
              separatorBuilder: (_, __) => Divider(height: getHeight() * 0.025),
              itemBuilder: (context, index) {
                final user = users[index];
                return ChatGroupTile(
                  name: user['name']!,
                  username: user['username']!,
                  imageUrl: user['image']!,
                  isSelected: selectedUsers.contains(user),
                  onTap: () => toggleUser(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
