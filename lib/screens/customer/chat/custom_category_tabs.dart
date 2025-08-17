import 'package:flutter/material.dart';
import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../res/res.dart';

class CustomCategoryTabs extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final Widget Function(Map<String, dynamic> category) builder;

  const CustomCategoryTabs({
    super.key,
    required this.categories,
    required this.builder,
  });

  @override
  State<CustomCategoryTabs> createState() => _CustomCategoryTabsState();
}

class _CustomCategoryTabsState extends State<CustomCategoryTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getHeightRatio() * 40,
          padding: EdgeInsets.symmetric(vertical: getHeightRatio() * 6),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.getPrimaryColorFromContext(context),
            unselectedLabelColor: AppColors.greyBordersColor,
            indicatorColor: AppColors.getPrimaryColorFromContext(context),
            indicatorWeight: 2.0,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: sizes?.fontSize14,
              fontFamily: Assets.onsetMedium,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: widget.categories
                .map((cat) => Tab(text: cat['label']))
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.categories
                .map((cat) => widget.builder(cat))
                .toList(),
          ),
        ),
      ],
    );
  }
}

