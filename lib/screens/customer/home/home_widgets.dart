import 'package:carousel_slider/carousel_slider.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:flutter/material.dart';

import '../../../appAssets/app_assets.dart';

class PostCard extends StatelessWidget {
  final List<String> images = [
    'https://www.imagelato.com/images/article-image-ample-service-area-34a39db5.jpg',
    // Replace with real image URLs
    'https://i.pinimg.com/736x/90/0c/fc/900cfc673204b6debbacd5c63e074565.jpg',
    'https://content.fortune.com/wp-content/uploads/2019/05/tak-room-rendering-web.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top bar with user info
        ListTile(
          leading: CircleAvatar(
            radius: getHeight() * .03,
            backgroundImage: NetworkImage(
              'https://www.imagelato.com/images/article-image-ample-service-area-34a39db5.jpg',
            ),
          ),
          title: CustomText(
            text: 'Liberty Bite Bistro',
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetSemiBold,
            giveLinesAsText: true,
          ),
          subtitle: CustomText(
            text: '3 days ago',
            fontSize: sizes?.fontSize12,
            giveLinesAsText: true,
          ),
          trailing: Icon(Icons.more_vert),
        ),

        // Post description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomText(
            text:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',
            fontSize: sizes?.fontSize14,
            giveLinesAsText: true,
          ),
        ),

        // Hashtags
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Wrap(
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
        ),

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
              _buildIconText(Icons.reply, '1.2k'),
              Icon(Icons.star, color: AppColors.textGreyColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textGreyColor),
        SizedBox(width: 4),
        CustomText(
          text: text,
          fontSize: sizes?.fontSize12,
          fontFamily: Assets.onsetMedium,
          color: AppColors.textGreyColor,
        ),
      ],
    );
  }
}
