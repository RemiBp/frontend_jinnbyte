import 'package:choice_app/screens/restaurant/profile_menu/profile_menu_widgets.dart';
import 'package:choice_app/screens/restaurant/profile_menu/restaurant_choice_view.dart';
import 'package:choice_app/screens/restaurant/profile_menu/restaurant_posts_view.dart';
import 'package:choice_app/screens/restaurant/setting/setting_view.dart';
import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../res/res.dart';

class ProfileMenuView extends StatefulWidget {
  const ProfileMenuView({super.key});

  @override
  State<ProfileMenuView> createState() => _ProfileMenuViewState();
}

class _ProfileMenuViewState extends State<ProfileMenuView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging || _tabController.index != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color getTabColor(int tabIndex) {
    return _selectedTabIndex == tabIndex
        ? AppColors.getPrimaryColorFromContext(context)
        : AppColors.inputHintColor;
  }

  Color getImageColor(int tabIndex) {
    return _selectedTabIndex == tabIndex
        ? AppColors.getPrimaryColorFromContext(context)
        : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: ProfileMenuAppBar(
        onSwitchAccount: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SwitchAccountBottomSheet(context: context);
            },
          );
        },
        onSetting: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingView()),
          );
        },
      ),
      body: Column(
        children: [
          SizedBox(height: getHeight() * 0.02),
          // RestaurantProfileHeader(),
          CustomerProfileHeader(),
          SizedBox(height: getHeight() * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomText(
              text: 'Lorem ipsum dolor sit amet consectetur. Nunc aliquam eu risus nibh quis consectetur.',
              textOverflow: TextOverflow.ellipsis,
              fontSize: sizes?.fontSize16,
              color: AppColors.primarySlateColor,
              fontWeight: FontWeight.w400,
              giveLinesAsText: true,
            ),
          ),
          SizedBox(height: getHeight() * 0.01),
          Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              border: const Border(
                bottom: BorderSide(color: Color(0xFFEFEFEF)),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.getPrimaryColorFromContext(context),
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.getPrimaryColorFromContext(context),
              padding: EdgeInsets.zero,
              tabs: [
                ProfileTabItem(
                  iconPath: Assets.calenderIcon,
                  label: 'Choices',
                  tabIndex: 0,
                  selectedTabIndex: _selectedTabIndex,
                ),
                ProfileTabItem(
                  iconPath: Assets.priceIcon,
                  label: 'Interest',
                  tabIndex: 1,
                  selectedTabIndex: _selectedTabIndex,
                ),
                // ProfileTabItem(
                //   iconPath: Assets.guestsIcon,
                //   label: 'About',
                //   tabIndex: 2,
                //   selectedTabIndex: _selectedTabIndex,
                // ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                RestaurantChoiceView(enableOnTap: true,),
                RestaurantPostsView(),
                // RestaurantAboutView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

