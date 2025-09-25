import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../appAssets/app_assets.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../res/res.dart';

class ShareExperienceWidget extends StatefulWidget {
  const ShareExperienceWidget({super.key});

  @override
  _ShareExperienceWidgetState createState() => _ShareExperienceWidgetState();
}

class _ShareExperienceWidgetState extends State<ShareExperienceWidget> {
  String _selectedOption = 'Public';
  final TextEditingController _controller = TextEditingController();

  Widget buildRadio(String title, String subtitle, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title:  CustomText(
        text: title,
        fontSize: sizes?.fontSize14,
      ),
      subtitle:CustomText(
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

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
          color: Colors.grey.shade300,
          offset: Offset(0, 4),
          blurRadius: 2,
          spreadRadius: 4,
         ),
        ],
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
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration.collapsed(
                hintText: 'Share your experience...',
                hintStyle: TextStyle(color: Color(0xFF6B6C90)),
              ),
            ),
          ),
          SizedBox(height: 24),
          buildRadio('Public', 'Anyone can see the feed', 'Public'),
          buildRadio('Friends Only', 'Your friends on Choice', 'Friends'),
          buildRadio('Private', 'Only Me', 'Private'),
        ],
      ),
    );
  }
}
