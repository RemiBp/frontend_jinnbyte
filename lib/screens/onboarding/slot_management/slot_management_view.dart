import 'package:choice_app/screens/onboarding/slot_management/slot_management_widgets.dart';
import 'package:flutter/material.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_drop_down.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../res/res.dart';
import '../day_off/days_off_view.dart';


class SlotManagementView extends StatefulWidget {
  final bool? isHomeFlow;
  final bool? isEdit;
  const SlotManagementView({super.key, this.isHomeFlow, this.isEdit});

  @override
  State<SlotManagementView> createState() => _SlotManagementViewState();
}

class _SlotManagementViewState extends State<SlotManagementView> {
  List<int> hoursList = [1, 2, 3, 4];
  int? selectedHour;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  bool isEdit = true;

  final dummySlotsData = [
    {
      "day": "Monday",
      "slots": [
        Slots(id: 1, startTime: "09:00", endTime: "10:00"),
        Slots(id: 2, startTime: "10:00", endTime: "11:00"),
        Slots(id: 3, startTime: "11:00", endTime: "12:00"),
        Slots(id: 4, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Tuesday",
      "slots": [
        Slots(id: 5, startTime: "09:00", endTime: "10:00"),
        Slots(id: 6, startTime: "10:00", endTime: "11:00"),
        Slots(id: 7, startTime: "11:00", endTime: "12:00"),
        Slots(id: 8, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Wednesday",
      "slots": [
        Slots(id: 9, startTime: "09:00", endTime: "10:00"),
        Slots(id: 10, startTime: "10:00", endTime: "11:00"),
        Slots(id: 11, startTime: "11:00", endTime: "12:00"),
        Slots(id: 12, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Thursday",
      "slots": [
        Slots(id: 13, startTime: "09:00", endTime: "10:00"),
        Slots(id: 14, startTime: "10:00", endTime: "11:00"),
        Slots(id: 15, startTime: "11:00", endTime: "12:00"),
        Slots(id: 16, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Friday",
      "slots": [
        Slots(id: 17, startTime: "09:00", endTime: "10:00"),
        Slots(id: 18, startTime: "10:00", endTime: "11:00"),
        Slots(id: 19, startTime: "11:00", endTime: "12:00"),
        Slots(id: 20, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Saturday",
      "slots": [
        Slots(id: 21, startTime: "09:00", endTime: "10:00"),
        Slots(id: 22, startTime: "10:00", endTime: "11:00"),
        Slots(id: 23, startTime: "11:00", endTime: "12:00"),
        Slots(id: 24, startTime: "12:00", endTime: "01:00"),
      ]
    },
    {
      "day": "Sunday",
      "slots": [
        Slots(id: 25, startTime: "09:00", endTime: "10:00"),
        Slots(id: 26, startTime: "10:00", endTime: "11:00"),
        Slots(id: 27, startTime: "11:00", endTime: "12:00"),
        Slots(id: 28, startTime: "12:00", endTime: "01:00"),
      ]
    },
  ];


  Map<String, List<int>> selectedDayWiseSlots = {};




  // @override
  // void initState() {
  //   super.initState();
  //   isEdit = widget.isEdit??false;
  // }

  @override
  void initState() {
    super.initState();
    isEdit = widget.isEdit??false;
    for (var item in dummySlotsData) {
      final day = item['day'] as String;
      selectedDayWiseSlots[day] = []; // initialize empty selections
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Slot Management",
        showEditButton: isEdit,
        onEdit: (){
          setState(() {
            isEdit = false;
          });
        },
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: sizes.pagePadding),
        child:
        Form(
          // key: provider.slotManagementFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeightRatio() * 16),
              if(!isEdit)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                  child: const TextFieldLabel(
                    label: "Slot Duration",
                  ),
                ),
              if(!isEdit)
              // provider.isDurationFetched?
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                  child: CustomDropdown(
                    items: hoursList.map((hour) {
                      return DropdownMenuItem<int>(
                        value: hour,
                        child: CustomText(
                          text: "$hour hour ",
                          fontWeight: FontWeight.w400,
                          fontSize: sizes?.fontSize16,
                          lines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedHour,
                    // selectedValue: provider.getDurationResponse.slotDuration != null ? double.parse(provider.getDurationResponse.slotDuration!).toInt() : selectedHour,
                    hintText: 'Select duration',
                    onChanged: (id) async{
                      // bool isSuccess = await provider.setDurationAPI(
                      //     context: context,
                      //     duration: id??0
                      // );
                      // if(isSuccess){
                      //   setState(() {
                      //     selectedHour = id!;
                      //     provider.slotManagementFormKey.currentState?.validate();
                      //   });
                      //   slotManagementProvider.getSlotsEndPointAPI();
                      // }
                    },
                    validator: (id) => id == null ? 'Please select duration' : null,
                  ),
                ),
              //   :const Center(
              //   child: CircularProgressIndicator(),
              // ),
              SizedBox(height: getHeightRatio() * 16),
              if(isEdit)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                  child: CustomText(
                    text: "Mark Your Unavailable Time Slots",
                    fontSize: sizes?.fontSize18,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if(isEdit)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                  child: CustomText(
                    text: "Select the time slots when you're not available each day. You can choose individual slots or use Select All to mark the entire day as unavailable. Tap Save Changes to apply your preferences.",
                    fontSize: sizes?.fontSize14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              SizedBox(height: getHeightRatio() * 16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: dummySlotsData.length,
                  itemBuilder: (context, index) {
                    final currentDay = dummySlotsData[index]["day"] as String;
                    final allSlotsOfDay = dummySlotsData[index]["slots"] as List<Slots>;
                    final selectedIds = selectedDayWiseSlots[currentDay] ?? [];

                    final isChecked = selectedIds.length == allSlotsOfDay.length &&
                        allSlotsOfDay.every((slot) => selectedIds.contains(slot.id));


                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                          child: EditDaysTile(
                            label: currentDay,
                            isChecked: isChecked,
                            isEdit: isEdit,
                            onSelectAll: () {
                              setState(() {
                                if (isChecked) {
                                  selectedDayWiseSlots[currentDay] = [];
                                } else {
                                  selectedDayWiseSlots[currentDay] =
                                      allSlotsOfDay.map((slot) => slot.id).toList();
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: getHeightRatio() * 6),
                        MultiSlotSelection(
                          options: allSlotsOfDay,
                          isEdit: isEdit,
                          initialSelection: allSlotsOfDay
                              .where((slot) => selectedIds.contains(slot.id))
                              .toList(),
                          onSelectionChanged: (selectedSlots) {
                            setState(() {
                              selectedDayWiseSlots[currentDay] =
                                  selectedSlots.map((slot) => slot.id).toList();
                            });
                            // setState(() {
                            //   // selectedSlots.cast<Slots>().map((slot) => slot.id).toList();
                            //   selectedDayWiseSlots[currentDay] =
                            //       selectedSlots.map((slot) => slot.id).toList();
                            // });
                          },
                          chipPadding: const EdgeInsets.all(8),
                        ),
                        SizedBox(height: getHeightRatio() * 16),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: getHeight() * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonText: 'Cancel',
                      onTap: () {
                        Navigator.pop(context);
                      },
                      buttonWidth: getWidth() * .42,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.blackColor,
                      textColor: AppColors.blackColor,
                      textFontWeight: FontWeight.w700,
                    ),
                    CustomButton(
                      buttonText: 'Continue',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DaysOffView()),
                        );
                      },
                      buttonWidth: getWidth() * .42,
                      backgroundColor: AppColors.getPrimaryColorFromContext(context),
                      borderColor: Colors.transparent,
                      textColor: Colors.white,
                      textFontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizedBox(height: getHeightRatio() * 16),
            ],
          ),
        ),
      )
      // Consumer<SlotManagementProvider>(
      //     builder: (context,provider,_) {
      //       return ;
      //     }
      // ),
    );
  }


  void _toggleDayValue(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        monday = !monday;
        break;
      case 'tuesday':
        tuesday = !tuesday;
        break;
      case 'wednesday':
        wednesday = !wednesday;
        break;
      case 'thursday':
        thursday = !thursday;
        break;
      case 'friday':
        friday = !friday;
        break;
      case 'saturday':
        saturday = !saturday;
        break;
      case 'sunday':
        sunday = !sunday;
        break;
    }
  }


}



class Slots {
  final int id;
  final String startTime;
  final String endTime;

  Slots({required this.id, required this.startTime, required this.endTime});
}
