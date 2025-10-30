import 'package:choice_app/models/get_producer_slots_response.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/onboarding/slot_management/slot_management_widgets.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_drop_down.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../day_off/days_off_view.dart';


class SlotManagementView extends StatefulWidget {
  final bool? isHomeFlow;
  final bool isEdit;
  const SlotManagementView({super.key, this.isHomeFlow, this.isEdit = false});

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

  Map<String, List<int>> selectedDayWiseSlots = {};
  List<Map<String, dynamic>> slotsData = [];

  List<Map<String, dynamic>> _generateSlotsForDuration(int duration) {
    List<Map<String, dynamic>> generatedSlots = [];
    List<String> days = [
      al.monday,
      al.tuesday,
      al.wednesday,
      al.thursday,
      al.friday,
      al.saturday,
      al.sunday
    ];
    
    for (String day in days) {
      List<Slots> daySlots = [];
      int slotId = 1;
      
      // Generate slots from 9:00 AM to 6:00 PM (9 hours)
      for (int hour = 9; hour < 18; hour += duration) {
        String startTime = "${hour.toString().padLeft(2, '0')}:00";
        int endHour = hour + duration;
        String endTime = "${endHour.toString().padLeft(2, '0')}:00";
        
        daySlots.add(Slots(
          id: slotId,
          startTime: startTime,
          endTime: endTime,
        ));
        slotId++;
      }
      
      generatedSlots.add({
        "day": day,
        "slots": daySlots,
      });
    }
    
    return generatedSlots;
  }

  @override
  void initState() {
    super.initState();
    isEdit = widget.isEdit;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isEdit) {
        _loadProducerSlots();
      }
    });
  }

  void _loadProducerSlots() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.init(context);
    await provider.getProducerSlots();
    _initializeSlotsDataFromApi(provider);
  }

  void _initializeSlotsData() {
    // Initialize with default 1-hour slots
    slotsData = _generateSlotsForDuration(1);
    _initializeSelectedSlots();
  }

  void _initializeSlotsDataFromApi(ProfileProvider provider) {
    if (provider.getProducerSlotsResponse != null) {
      slotsData = _convertApiDataToSlotsData(provider.getProducerSlotsResponse!);
    } else {
      // Fallback to default data if API data is not available
      slotsData = _generateSlotsForDuration(1);
    }
    _initializeSelectedSlots();
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> _convertApiDataToSlotsData(GetProducerSlotsResponse apiResponse) {
    List<Map<String, dynamic>> convertedData = [];
    
    for (var daySlot in apiResponse.data) {
      List<Slots> convertedSlots = [];
      
      for (var apiSlot in daySlot.slots) {
        convertedSlots.add(Slots(
          id: apiSlot.id,
          startTime: apiSlot.startTime,
          endTime: apiSlot.endTime,
        ));
      }
      
      convertedData.add({
        "day": daySlot.day,
        "slots": convertedSlots,
      });
    }
    
    return convertedData;
  }

  void _initializeSelectedSlots() {
    selectedDayWiseSlots.clear();
    for (var item in slotsData) {
      final day = item['day'] as String;
      selectedDayWiseSlots[day] = []; // initialize empty selections
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: al.slotManagement,
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
                  child: TextFieldLabel(
                    label: al.slotDuration,
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
                          text: "$hour  " + al.hour,
                          fontWeight: FontWeight.w400,
                          fontSize: sizes?.fontSize16,
                          lines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    selectedValue: selectedHour,
                    // selectedValue: provider.getDurationResponse.slotDuration != null ? double.parse(provider.getDurationResponse.slotDuration!).toInt() : selectedHour,
                    hintText: al.selectDuration,
                    onChanged: (id) async {
                      setState(() {
                        selectedHour = id!;
                        // Regenerate slots based on selected duration
                        slotsData = _generateSlotsForDuration(id!);
                        _initializeSelectedSlots();
                      });
                      
                      // Call API to set slot duration
                      final provider = Provider.of<ProfileProvider>(context, listen: false);
                      provider.init(context);
                      await provider.setSlotDuration(slotDuration: id!);
                      await provider.getProducerSlots();
                      
                      // Update slots data with fresh API data
                      _initializeSlotsDataFromApi(provider);
                    },
                    validator: (id) => id == null ? al.pleaseSelectDuration : null,
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
                    text: al.markUnavailableSlots,
                    fontSize: sizes?.fontSize18,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if(isEdit)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
                  child: CustomText(
                    text: al.unavailableSlotsDescription,
                    fontSize: sizes?.fontSize14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              SizedBox(height: getHeightRatio() * 16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: slotsData.length,
                  itemBuilder: (context, index) {
                    final currentDay = slotsData[index]["day"] as String;
                    final allSlotsOfDay = slotsData[index]["slots"] as List<Slots>;
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
                          key: ValueKey('${currentDay}_${selectedHour ?? 1}'),
                          options: allSlotsOfDay,
                          isEdit: isEdit,
                          initialSelection: selectedIds.isEmpty 
                              ? <Slots>[]
                              : allSlotsOfDay.where((slot) => selectedIds.contains(slot.id)).toList(),
                          onSelectionChanged: (selectedSlots) {
                            setState(() {
                              selectedDayWiseSlots[currentDay] =
                                  selectedSlots.map((slot) => slot.id).toList();
                            });
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
                      buttonText: al.cancel,
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
                      buttonText: al.saveChanges,
                      onTap: () {
                        _saveSlotSelections();
                        if(isEdit) {
                          context.pop();
                        }
                        context.go(Routes.restaurantBottomTabRoute);
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

  void _saveSlotSelections() {
    debugPrint('=== SLOT SELECTIONS SAVED ===');
    debugPrint('Selected Duration: ${selectedHour ?? 'Not selected'} hours');
    debugPrint('Selected Slots:');
    
    for (String day in selectedDayWiseSlots.keys) {
      List<int> selectedSlots = selectedDayWiseSlots[day] ?? [];
      if (selectedSlots.isNotEmpty) {
        debugPrint('$day: ${selectedSlots.length} slots selected');
        
        // Get the actual slot details
        var dayData = slotsData.firstWhere((item) => item['day'] == day);
        List<Slots> allSlots = dayData['slots'] as List<Slots>;
        
        for (int slotId in selectedSlots) {
          var slot = allSlots.firstWhere((s) => s.id == slotId);
          debugPrint('  - ${slot.startTime} to ${slot.endTime}');
        }
      } else {
        debugPrint('$day: No slots selected');
      }
    }
    debugPrint('=============================');
    
    // TODO: Implement API call to save slot selections
    // For now, just show success message and navigate back
    Navigator.pop(context);
  }


}



class Slots {
  final int id;
  final String startTime;
  final String endTime;

  Slots({required this.id, required this.startTime, required this.endTime});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Slots && other.id == id && other.startTime == startTime && other.endTime == endTime;
  }

  @override
  int get hashCode => id.hashCode ^ startTime.hashCode ^ endTime.hashCode;
}
