import 'package:carousel_slider/carousel_slider.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/screens/restaurant/home/choice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../appAssets/app_assets.dart';
import '../../../l18n.dart';
import '../../../routes/routes.dart';

class PostCard extends StatelessWidget {


   const PostCard({super.key,  this.index = 0});
   final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChoiceProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top bar with user info
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: getHeight() * .03,
            backgroundImage: NetworkImage(
              provider.postsResponse.data![index].coverImage??"",
            ),
          ),
          title: CustomText(
            text: 'Liberty Bite Bistro',
            fontSize: sizes?.fontSize16,
            fontFamily: Assets.onsetSemiBold,
            giveLinesAsText: true,
          ),
          subtitle: CustomText(
            text: provider.postsResponse.data![index].createdAt != null
                ? timeago.format(
              DateTime.parse(provider.postsResponse.data![index].createdAt!),
            )
                : 'nil',
            fontSize: sizes?.fontSize12,
            giveLinesAsText: true,
          ),
          trailing: Icon(Icons.more_vert),
        ),
        // Post description
        CustomText(
          text: provider.postsResponse.data?[index].description ?? "",
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
              provider.postsResponse.data?[index].images!.map((imageData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageData.url!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, obj, error) {
                          return Icon(
                            Icons.broken_image, size: getHeight() * .2,
                            color: Colors.grey,);
                        },
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
