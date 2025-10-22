import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../appAssets/app_assets.dart';
import '../../../../customWidgets/custom_text.dart';
import '../../../../customWidgets/custom_textfield.dart';
import '../../../../res/res.dart';
import '../../../../routes/routes.dart';
import '../choice_provider.dart';

class SubChoiceSelection extends StatefulWidget {
  final String selectedChoice;

  const SubChoiceSelection({super.key, required this.selectedChoice});

  @override
  _SubChoiceSelectionState createState() => _SubChoiceSelectionState();
}

class _SubChoiceSelectionState extends State<SubChoiceSelection> {
  String searchText = 'Olivia';
  String selectedRestaurant = 'Olivia';
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CustomerChoiceProvider>(
        context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = GoRouterState.of(context).extra as Map<String, dynamic>?;
      final producerType = data?["title"].toLowerCase();
      provider.getProducerPlaces(producerType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final provider = Provider.of<CustomerChoiceProvider>(
        context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Choice'),

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            _buildSelectedTypeCard(name: data?["title"], icon: data?["icon"]),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child:CustomText(
                text: data?["description"],
                fontFamily: Assets.onsetMedium,
                fontSize: sizes?.fontSize14,
              ),
            ),
            const SizedBox(height: 12),
            CustomField(
              borderColor: AppColors.greyBordersColor,
              hint: "Search for a restaurant...",
              prefixIconSvg: Assets.searchIcon,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                // itemCount: filtered.length,
                itemCount:provider.placesResponse. data?.length??0,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final r = provider.placesResponse. data?[index];
                  // final r = filtered[index];
                  final isSelected = selectedRestaurant == r?.name;
                  return ListTile(
                    title:CustomText(
                      text:  r?.name??"nil",
                      fontSize: sizes?.fontSize14,
                    ),
                    subtitle: CustomText(
                      text:r?.address??"nil",
                      fontSize: sizes?.fontSize12,
                    ),
                    trailing: Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                    onTap: (){
                      setState(() => selectedRestaurant = r?.name??"nil",);
                      selectedIndex = index;
                    }
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.black),
                    ),
                    child: CustomText(
                      text: "Back",
                      fontFamily: Assets.onsetSemiBold,
                      fontSize: sizes?.fontSize16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(Routes.createChoiceRoute, extra: {
                        "title": data?["title"],
                        "icon": data?["icon"],
                        "description": data?["description"],
                        "placeId":provider.placesResponse.data?[selectedIndex].id,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child:CustomText(
                      text: "Next",
                      fontFamily: Assets.onsetSemiBold,
                      fontSize: sizes?.fontSize16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTypeCard({required String name, required String icon,}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBordersColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SvgPicture.asset(icon,),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:name?? "Restaurant",
                  fontFamily: Assets.onsetMedium,
                  fontSize: sizes?.fontSize14,
                ),
                CustomText(
                  text: "Lorem ipsum dolor sit amet ",
                  fontSize: sizes?.fontSize12,
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                  },
                  child: CustomText(
                    text: "Change Type",
                    fontSize: sizes?.fontSize14,
                    fontFamily: Assets.onsetMedium,
                    color: AppColors.userPrimaryColor,
                    textDecoration: TextDecoration.underline,
                    decorationColor: AppColors.userPrimaryColor,
                    giveLinesAsText: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) => setState(() => searchText = value),
      controller: TextEditingController(text: searchText),
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
