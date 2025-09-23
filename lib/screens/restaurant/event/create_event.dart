import 'dart:io';

import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _eventNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _venueController = TextEditingController();
  final _addressController = TextEditingController();
  final _capacityController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  Future<void> _pickImages() async {
    if (_images.length >= 5) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  // Remove image
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  // Date picker
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // Time picker
  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? const TimeOfDay(hour: 0, minute: 0)) // default 12 AM
          : (_endTime ?? TimeOfDay.now()), //end time stays as it is
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: CustomText(
        text: title,
        fontSize: sizes?.fontSize16,
        fontFamily: Assets.onsetSemiBold,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getHeight() * .01),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth() * .04,
        vertical: getHeight() * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text("Create Event", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        // For Divider
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppColors.greyBordersColor, // use your app's border color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Event Details
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Event Details"),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      borderColor: AppColors.greyBordersColor,
                      hint: "E.g: Brochette boeuf...",
                      label: "Event Name",
                    ),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      height: getHeight() * .1,
                      borderColor: AppColors.greyBordersColor,
                      hint: "Describe your event...",
                      label: "Description",
                    ),
                  ],
                ),
              ),

              // Event Gallery
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Event Gallery"),
                    CustomText(
                      text: "Upload Event Images*",
                      fontSize: sizes?.fontSize14,
                      fontFamily: Assets.onsetMedium,
                    ),
                    CustomText(
                      text: "Upload up to 5 images",
                      fontSize: sizes?.fontSize12,
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: _pickImages,
                      child: DottedBorderContainer(),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(_images.length, (index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_images[index].path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () => _removeImage(index),
                                child: CircleAvatar(
                                  radius: getHeight() * .018,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.close,
                                    size: getHeight() * .022,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Location
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Location"),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      borderColor: AppColors.greyBordersColor,
                      hint: "Restaurant name or venue",
                      label: "Venue Name",
                    ),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      borderColor: AppColors.greyBordersColor,
                      hint: "Address of venue",
                      label: "Address",
                    ),
                  ],
                ),
              ),

              // Capacity & Pricing
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Capacity & Pricing"),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      borderColor: AppColors.greyBordersColor,
                      hint: "Maximum number of persons",
                      label: "Maximum Capacity",
                    ),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      borderColor: AppColors.greyBordersColor,
                      hint: "\$ 0.00",
                      label: "Price per person",
                    ),
                  ],
                ),
              ),

              // Schedule
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Schedule"),
                    SizedBox(height: getHeight() * .02),
                    InkWell(
                      onTap: _pickDate,
                      child: AbsorbPointer(
                        child: CustomField(
                          borderColor: AppColors.greyBordersColor,
                          hint: "Select date",
                          label: "Event Date",
                          suffixIcon: Icons.calendar_month_rounded,
                          obscure: true,
                          textEditingController: TextEditingController(
                            text:
                                _selectedDate == null
                                    ? ""
                                    : DateFormat.yMMMMd().format(
                                      _selectedDate!,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(true),
                            child: AbsorbPointer(
                              child: CustomField(
                                borderColor: AppColors.greyBordersColor,
                                hint: "",
                                label: "Start Time",
                                suffixIconSvg: Assets.clockSvg,
                                textEditingController: TextEditingController(
                                  text: (_startTime ?? const TimeOfDay(hour: 0, minute: 0)) // fallback
                                      .format(context),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickTime(false),
                            child: AbsorbPointer(
                              child: CustomField(
                                borderColor: AppColors.greyBordersColor,
                                hint: "",
                                label: "End Time",
                                suffixIconSvg: Assets.clockSvg,
                                textEditingController: TextEditingController(
                                  text: _endTime?.format(context) ?? "",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding:  EdgeInsets.symmetric(vertical: getHeight()*.03),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Colors.transparent,
                        buttonText: "Save as Draft",
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(buttonText: "Publish", onTap: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable upload container
class DottedBorderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: DottedBorder(
        options: RectDottedBorderOptions(
          padding: EdgeInsets.all(22),
          dashPattern: [10, 10],
          color: AppColors.inputHintColor,
        ),
        child: SizedBox(
          width: getWidth(),
          height: getHeight() * .13,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.imageIcon),
                SizedBox(height: 8),
                CustomText(
                  text: "Tap to upload image",
                  fontSize: sizes?.fontSize14,
                  fontFamily: Assets.onsetMedium,
                ),
                CustomText(
                  text: "PNG, JPG or JPEG (MAX. 5MB each)",
                  fontSize: sizes?.fontSize12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
