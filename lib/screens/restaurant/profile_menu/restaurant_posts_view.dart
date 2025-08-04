import 'package:flutter/cupertino.dart';

import '../../../res/res.dart';
import '../../customer/home/home_widgets.dart';

class RestaurantPostsView extends StatefulWidget {
  const RestaurantPostsView({super.key});

  @override
  State<RestaurantPostsView> createState() => _RestaurantPostsViewState();
}

class _RestaurantPostsViewState extends State<RestaurantPostsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return PostCard();
      },
    );
  }
}
