import 'package:carousel_slider/carousel_slider.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../l18n.dart';
import '../../../routes/routes.dart';
import '../profile/customer_profile/customer_profile_provider.dart';

class PostCard extends StatelessWidget {
  final List<String> images = const [
    'https://www.imagelato.com/images/article-image-ample-service-area-34a39db5.jpg',
    // Replace with real image URLs
    'https://i.pinimg.com/736x/90/0c/fc/900cfc673204b6debbacd5c63e074565.jpg',
    'https://content.fortune.com/wp-content/uploads/2019/05/tak-room-rendering-web.jpg',
  ];

   const PostCard({super.key,  this.index = 0});
   final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProfileProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top bar with user info
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: getHeight() * .03,
            backgroundImage: NetworkImage(
              provider.userPosts?[index].coverImage??"",
            ),
          ),
          title: CustomText(
            text: 'Liberty Bite Bistro',
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetSemiBold,
            giveLinesAsText: true,
          ),
          subtitle: CustomText(
            text: '3 ${al.daysAgo}',
            fontSize: sizes?.fontSize12,
            giveLinesAsText: true,
          ),
          trailing: Icon(Icons.more_vert),
        ),
        // Post description
        CustomText(
          text:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
          fontSize: sizes?.fontSize14,
          giveLinesAsText: true,
        ),
        SizedBox(height: getHeight() * 0.01),
        // Hashtags
        Wrap(
          spacing: 8,
          children:
              [
                    '#cozy',
                    '#outdoor_seating',
                    '#live_music',
                    '#family_friendly',
                    '#budget_friendly',
                  ]
                  .map(
                    (tag) => Text(tag, style: TextStyle(color: Colors.blue)),
                  )
                  .toList(),
        ),
        SizedBox(height: getHeight() * 0.01),
        // Image carousel with indicator
        Stack(
          children: [
            CarouselSlider(
              items:
                  images.map((url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
              options: CarouselOptions(
                height: getHeight() * .4,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                autoPlay: false,
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: Colors.black54,
                child: Text('1/3', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        SizedBox(height: getHeight() * .03),
        // Divider
        const Divider(),

        // Like, comment, share, bookmark
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconText(Icons.favorite_outlined, '2.2k'),
              _buildIconText(Icons.chat_bubble, '3.2k'),
              _buildIconText(Assets.shareIcon, '1.2k'),
              _buildInterestedTag("${al.interested} (0)",context),
            ],
          ),
        ),
      ],
    );
  }

  // Icon + Text with border
  Widget _buildIconText(dynamic icon, String text) {
    Widget iconWidget;

    if (icon is IconData) {
      // Normal material icon
      iconWidget = Icon(
        icon,
        size: getHeight() * 0.016,
        color: AppColors.textGreyColor,
      );
    } else if (icon is String) {
      // SVG asset path
      iconWidget = SvgPicture.asset(
        icon,
        height: getHeight() * 0.016,
        colorFilter: ColorFilter.mode(AppColors.textGreyColor,BlendMode.srcIn),
      );
    } else {
      throw ArgumentError("icon must be IconData or String (SVG path)");
    }

    return Container(
      height: getHeight() * 0.035, // 28px
      width: getWidth() * 0.14,    // 55px
      margin: EdgeInsets.only(right: getWidth() * 0.01),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textGreyColor, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          SizedBox(width: getWidth() * 0.008),
          Flexible(
            child: CustomText(
              text: text,
              fontSize: sizes?.fontSize10,
              fontFamily: Assets.onsetMedium,
              color: AppColors.textGreyColor,
            ),
          ),
        ],
      ),
    );
  }


  // Interested Tag (wider now)
  Widget _buildInterestedTag(String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  Navigate wherever you want
        context.push(Routes.suggestTimeSlotRoute);
        // Navigator.pushNamed(context, Routes.suggestTimeSlotRoute);
      },
      child: Container(
        height: getHeight() * 0.035,
        width: getWidth() * 0.28,
        margin: EdgeInsets.only(left: getWidth() * 0.017),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF964DFF),
              Color(0xFFFC5D4A),
            ],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.white, size: getHeight() * 0.016),
            SizedBox(width: getWidth() * 0.01),
            Flexible(
              child: CustomText(
                text: label,
                fontSize: sizes?.fontSize10,
                fontFamily: Assets.onsetMedium,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
