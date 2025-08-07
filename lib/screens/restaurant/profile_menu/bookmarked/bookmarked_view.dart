import 'package:choice_app/screens/restaurant/profile_menu/profile_menu_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../appColors/colors.dart';
import '../../../../customWidgets/common_app_bar.dart';
import '../../../../res/res.dart';

class BookmarkedView extends StatefulWidget {
  const BookmarkedView({super.key});

  @override
  State<BookmarkedView> createState() => _BookmarkedViewState();
}

class _BookmarkedViewState extends State<BookmarkedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Bookmarked"),
      body: Column(
        children: [
          SizedBox(height: getHeight() * 0.02),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return FavouriteRestaurantCard(
                  imageUrl: '',
                  restaurantName: 'The Wholesome Fork',
                  address: 'Lyon, France',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
