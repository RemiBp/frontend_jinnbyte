import 'package:choice_app/screens/restaurant/profile_menu/restaurant_menu_detail_view.dart';
import 'package:flutter/material.dart';
import '../../../res/res.dart';
import '../../customer/home/home_widgets.dart';

class RestaurantChoiceView extends StatefulWidget {
  const RestaurantChoiceView({super.key});

  @override
  State<RestaurantChoiceView> createState() => _RestaurantChoiceViewState();
}

class _RestaurantChoiceViewState extends State<RestaurantChoiceView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
          horizontal: sizes!.pagePadding
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestaurantMenuDetailView()),
            );
          },
            child: PostCard(),
        );
      },
    );
  }
}

