import 'package:choice_app/screens/restaurant/dashboard/home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/text_field_label.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../slot_management/slot_management_view.dart';
import '../slot_management/slot_management_widgets.dart';
import 'days_off_widgets.dart';


class DaysOffView extends StatefulWidget {
  const DaysOffView({super.key});

  @override
  State<DaysOffView> createState() => _DaysOffViewState();
}

class _DaysOffViewState extends State<DaysOffView> {
  TextEditingController leaveDateController=TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      // DaysOffProvider technicianReviewsProvider = Provider.of<DaysOffProvider>(context, listen: false);
      DateTime parsedDate = DateFormat('MM/dd/yyyy').parse(leaveDateController.text);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      // technicianReviewsProvider.getSlotsByDateEndPointAPI(date: formattedDate);
    });
  }


  bool isChecked = false;
  bool isDataFetched = true;

  List<Slots> allSlots = [
    Slots(id: 1, startTime: "09:00", endTime: "10:00"),
    Slots(id: 2, startTime: "10:00", endTime: "11:00"),
    Slots(id: 3, startTime: "11:00", endTime: "12:00"),
    Slots(id: 4, startTime: "12:00", endTime: "13:00"),
  ];

  List<int> selectedSlotIds = [];
  bool isSelectAllChecked = false;

  @override
  void dispose() {
    super.dispose();
    leaveDateController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.unavailability),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth() * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: getHeightRatio() * 16),
                   TextFieldLabel(
                    label: al.date,
                  ),
                  GestureDetector(
                    onTap: (){
                      // _selectDate(
                      //     context: context,
                      //     daysOffProvider: daysOffProvider
                      // );
                    },
                    child: AbsorbPointer(
                      child: DatePickerTile(
                        hintText:  al.selectDates,
                        controller: leaveDateController,
                        // validator: (value) => CustomValidator.validationEmptyText("Date", value)
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight() * 0.02),
                  EditDaysTile(
                    label: al.selectTimeSlots,
                    isChecked: isSelectAllChecked,
                    isEdit: true,
                    onSelectAll: () {
                      final allSlotIds = allSlots.map((slot) => slot.id!).toList();

                      if (selectedSlotIds.length == allSlotIds.length) {
                        selectedSlotIds.clear();
                        isSelectAllChecked = false;
                      } else {
                        selectedSlotIds
                          ..clear()
                          ..addAll(allSlotIds);
                        isSelectAllChecked = true;
                      }

                      setState(() {});
                    },
                  ),
                  SizedBox(height: getHeightRatio() * 6),
                  isDataFetched && allSlots.isNotEmpty
                      ? ChipGroupMultiSelect(
                    options: allSlots,
                    initialSelection: selectedSlotIds.map((id) {
                      try {
                        return allSlots.firstWhere((slot) => slot.id == id);
                      } catch (e) {
                        return null;
                      }
                    }).whereType<Slots>().toList(),
                    onSelectionChanged: (selectedSlots) {
                      selectedSlotIds = selectedSlots.map((slot) => slot.id ?? 0).toList();
                      setState(() {});
                    },
                    chipPadding: const EdgeInsets.all(8),
                  )
                      : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: CustomText(
                        text: al.noTimeSlotsFound,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),


                  //     :const Center(child: Padding(
                  //   padding: EdgeInsets.only(top: 18.0),
                  //   child: CircularProgressIndicator(),
                  // ),
                  // ),
                  // const Spacer(),
                ],
              ),
            ),
            Row(
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
                  },
                  buttonWidth: getWidth() * .42,
                  backgroundColor: AppColors.getPrimaryColorFromContext(context),
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  textFontWeight: FontWeight.w700,
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: CustomOutlinedButton(
            //         text: "Back",
            //         onPressed: (){
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //     SizedBox(
            //       width: getWidthRatio() * 12,
            //     ),
            //     Expanded(
            //       child: CustomButton(
            //         buttonText: "Continue",
            //         onTap: () async{
            //           DateTime parsedDate = DateFormat('MM/dd/yyyy').parse(leaveDateController.text.trim());
            //           String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
            //           bool success = await daysOffProvider.addUnavailableSlotAPI(context: context, date: formattedDate);
            //           if(success){
            //             Navigator.pop(context);
            //           }
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: getHeightRatio() * 16),
          ],
        ),
      ),
    );
    //   Consumer<DaysOffProvider>(
    //     builder: (context,daysOffProvider,_) {
    //       return ;
    //     }
    // );
  }

  // Future<DateTime?> _selectDate({
  //   required BuildContext context,
  //   required DaysOffProvider daysOffProvider,
  // }) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2050),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: AppColors.btnBgColor,
  //             onPrimary: AppColors.textFieldColor,
  //             surface: AppColors.textFieldColor,
  //             onSurface: AppColors.whiteColor,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: AppColors.btnBgColor,
  //             ),
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  //           child: child!,
  //         ),
  //       );
  //     },
  //   );
  //   if (picked != null ) {
  //
  //     String formattedDisplayDate = DateFormat('MM/dd/yyyy').format(picked);
  //     String formattedApiDate = DateFormat('yyyy-MM-dd').format(picked);
  //     leaveDateController.text = formattedDisplayDate;
  //
  //     daysOffProvider.slots = [];
  //     daysOffProvider.getSlotsByDateEndPointAPI(date: formattedApiDate);
  //
  //   }
  //   return picked;
  // }

}
