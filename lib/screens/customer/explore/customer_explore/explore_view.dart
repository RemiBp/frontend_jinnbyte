import 'package:choice_app/screens/customer/explore/restaurant_explore_details/restaurant_explore_details.dart';
import 'package:flutter/material.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../customWidgets/custom_textfield.dart';
import '../../../../l18n.dart';
import '../../../../res/res.dart';
import '../../../restaurant/profile_menu/profile_menu_widgets.dart';
import '../../maps/customer_maps/customer_maps_view.dart';
import 'explore_widgets.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.only(top: getHeight() * .07),
        child: Column(
          children: [
            //  HEADER stays fixed
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Choice",
                        fontSize: sizes?.fontSize28,
                        fontFamily: Assets.onsetSemiBold,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_sharp,
                              color: AppColors.userPrimaryColor),
                          CustomText(
                            text: "Lyon, France",
                            fontSize: sizes?.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.userPrimaryColor,
                          ),
                          Icon(Icons.keyboard_arrow_down,
                              color: AppColors.userPrimaryColor),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomIconButton(
                    svgString: Assets.mapIcon,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerMapsView()),
                      );
                    },
                  ),
                  SizedBox(width: getWidth() * .02),
                  CustomIconButton(svgString: Assets.chatIcon),
                  SizedBox(width: getWidth() * .02),
                  CustomIconButton(svgString: Assets.notificationIcon),
                ],
              ),
            ),
            SizedBox(height: getHeight() * .02),

            //  SEARCH stays fixed
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
              child: CustomField(
                borderColor: AppColors.greyBordersColor,
                hint: al.searchPlaceholder,
                prefixIconSvg: Assets.searchIcon,
              ),
            ),
            SizedBox(height: getHeight() * .02),

            // SCROLLABLE CONTENT
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //  Browse by Category
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                    child: BrowseCategoryWidget(
                      imagePaths: [
                        Assets.restaurantImage,
                        Assets.wellnessImage,
                        Assets.leisureImage,
                      ],
                      labels: [
                        "Restaurants",
                        "Wellness",
                        "Leisure",
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                    child: SeeMoreWidget(header: al.eventsNearYou),
                  ),

                  SizedBox(height: getHeight() * 0.015),

                  SizedBox(
                    height: getHeight() * 0.48,
                    child: ListView.builder(
                      padding:
                      EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyEvents.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: getWidth() * 0.75,
                          child: ExploreEventsCard(
                            event: dummyEvents[index],
                            margin: EdgeInsets.only(
                              top: getHeight() * 0.01,
                              bottom: getHeight() * 0.01,
                              right: getWidth() * 0.03,
                            ),
                            onDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantExploreDetails(
                                        tag: dummyEvents[index].tag,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: getHeight() * 0.02),

                  //  Surprise Me
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                    child: SeeMoreWidget(header: al.surpriseMe),
                  ),

                  SizedBox(height: getHeight() * 0.015),

                  SizedBox(
                    height: getHeight() * 0.28,
                    child: ListView.builder(
                      padding:
                      EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: getWidth() * 0.75,
                          child: FavouriteRestaurantCard(
                            imageUrl:
                            "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
                            restaurantName: "Restaurant ${index + 1}",
                            address: "123 Main Street, City",
                            isFavourite: index % 2 == 0,
                            margin: EdgeInsets.only(
                              top: getHeight() * 0.01,
                              bottom: getHeight() * 0.01,
                              right: getWidth() * 0.03,
                            ),
                            onFavouriteTap: () {},
                            onRestaurantTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Event> dummyEvents = [
    Event(
      title: "Wine & Dine Evening",
      tag: "Restaurant",
      location: "Lyon, France",
      dateTime: "June 20, 10:00 PM – 12:00 PM",
      price: "\$30.00",
      imageUrl:
      "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
    ),
    Event(
      title: "Beach Leisure Party",
      tag: "Leisure",
      location: "Nice, France",
      dateTime: "July 15, 6:00 PM – 11:00 PM",
      price: "\$45.00",
      imageUrl:
      "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
    ),
    Event(
      title: "Romantic Dinner Night",
      tag: "Restaurant",
      location: "Paris, France",
      dateTime: "Aug 5, 8:00 PM – 11:00 PM",
      price: "\$55.00",
      imageUrl:
      "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
    ),
    Event(
      title: "Wellness Yoga Camp",
      tag: "Wellness",
      location: "Bali, Indonesia",
      dateTime: "Sep 1, 7:00 AM – 6:00 PM",
      price: "\$90.00",
      imageUrl:
      "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
    ),
  ];
}


class Event {
  final String title;
  final String tag;
  final String location;
  final String dateTime;
  final String price;
  final String imageUrl;

  Event({
    required this.title,
    required this.tag,
    required this.location,
    required this.dateTime,
    required this.price,
    required this.imageUrl,
  });
}
