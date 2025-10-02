import 'dart:io';

import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/network/network_provider.dart';
import 'package:choice_app/screens/restaurant/event/event_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import '../../../res/toasts.dart';
import '../../../userRole/role_provider.dart';
import '../../../userRole/user_role.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String? _selectedEventType;
  final _formKey = GlobalKey<FormState>();
  NetworkProvider networkProvider = NetworkProvider();

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

  List<XFile> images = [];
  List<String> imageUrls = [];
  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  Future<void> _pickImages() async {
    if (images.length >= 5) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(pickedFile);
      });
    }
  }

  // Remove image
  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
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
          :  (_endTime ?? const TimeOfDay(hour: 0, minute: 0)),   //end time stays as it is
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
    return CustomText(
      text: title,
      fontSize: sizes?.fontSize16,
      fontFamily: Assets.onsetSemiBold,
    );
  }


  Widget _buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      padding: const EdgeInsets.all(16), // equal spacing on all sides
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          const SizedBox(height: 4), // ensures bottom spacing matches top
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    networkProvider.context = context;
  }

  @override
  void dispose() {
    super.dispose();
    _eventNameController.dispose();
    _descriptionController.dispose();
    _venueController.dispose();
    _priceController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = context.read<RoleProvider>().role;
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(al.createEvent, style: TextStyle(color: Colors.black)),
        centerTitle: false,
        titleSpacing: 0,

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
                    _buildSectionTitle(al.eventDetails,),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      textEditingController: _eventNameController,
                      borderColor: AppColors.greyBordersColor,
                      hint: "E.g: Brochette boeuf...",
                      label: al.eventName,
                    ),
                    SizedBox(height: getHeight() * .02),

                    // Event Type (Dropdown Field) – only for leisure role
                    if (role == UserRole.leisure) ...[
                      CustomDropdownField(
                        label: al.eventTypeLabel,
                        hint: al.eventTypePlaceholder,
                        items: ["Conference", "Wedding", "Birthday", "Workshop"],
                        value: _selectedEventType,
                        borderColor: AppColors.inputHintColor,
                        onChanged: (value) {
                          setState(() {
                            _selectedEventType = value;
                          });
                        },
                      ),
                      SizedBox(height: getHeight() * .02),
                    ],



                    CustomField(
                      textEditingController: _descriptionController,
                      height: getHeight() * .1,
                      borderColor: AppColors.greyBordersColor,
                      hint: al.eventDescriptionPlaceholder,
                      label: al.description,
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
                    SizedBox(height: getHeight() * .02),
                    CustomText(
                      text: al.uploadEventImages,
                      fontSize: sizes?.fontSize14,
                      fontFamily: Assets.onsetMedium,
                    ),
                    CustomText(
                      text: al.uploadEventImages,
                      fontSize: sizes?.fontSize12,
                    ),
                    SizedBox(height: getHeight() * .02),
                    InkWell(

                      onTap: _pickImages,
                      child: DottedBorderContainer(),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(images.length, (index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(images[index].path),
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
                    _buildSectionTitle(al.location,),
                    SizedBox(height: getHeight() * .02),
                    if (role == UserRole.restaurant) ...[
                      CustomField(
                        textEditingController: _venueController,
                        borderColor: AppColors.greyBordersColor,
                        hint: al.restaurantOrVenue,
                        label: al.venueName,
                      ),
                      SizedBox(height: getHeight() * .02),
                    ],
                    CustomField(
                      textEditingController: _addressController,
                      borderColor: AppColors.greyBordersColor,
                      hint: al.venueAddress,
                      label: al.address,
                    ),
                  ],
                ),
              ),

              // Capacity & Pricing
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(al.capacityPricing,),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      textEditingController: _capacityController,
                      borderColor: AppColors.greyBordersColor,
                      hint: al.maxPersons,
                      label: al.maxCapacity,
                    ),
                    SizedBox(height: getHeight() * .02),
                    CustomField(
                      textEditingController: _priceController,
                      borderColor: AppColors.greyBordersColor,
                      hint: "\$ 0.00",
                      label: al.pricePerPerson,
                    ),
                  ],
                ),
              ),

              // Schedule
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(al.schedule,),
                    SizedBox(height: getHeight() * .02),
                    InkWell(
                      onTap: _pickDate,
                      child: AbsorbPointer(
                        child: CustomField(
                          borderColor: AppColors.greyBordersColor,
                          hint: al.selectDate,
                          label:al.eventDate,
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
                                label: al.startTime,
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
                                label: al.endTime,
                                suffixIconSvg: Assets.clockSvg,
                                textEditingController: TextEditingController(
                                  text: (_endTime ?? const TimeOfDay(hour: 0, minute: 0)) // fallback
                                      .format(context),
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
                        buttonText: al.saveAsDraft,
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        buttonText: al.publish, onTap: () async {
                        final eventName = _eventNameController.text.trim();
                        final description = _descriptionController.text.trim();
                        final venue = _venueController.text.trim();
                        final address = _addressController.text.trim();
                        final capacity = _capacityController.text.trim();
                        final price = _priceController.text.trim();

                        if (images.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please select at least one image.");
                        } else if (eventName.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please enter the event name.");
                        } else if (description.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please enter the event description.");
                        } else if (venue.isEmpty) {
                          Toasts.getErrorToast(text: "Please enter the venue.");
                        } else if (address.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please enter the address.");
                        } else if (capacity.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please enter the capacity.");
                        } else if (int.tryParse(capacity) == null) {
                          Toasts.getErrorToast(
                              text: "Please enter a valid number for capacity.");
                        } else if (price.isEmpty) {
                          Toasts.getErrorToast(text: "Please enter the price.");
                        } else if (double.tryParse(price) == null) {
                          Toasts.getErrorToast(
                              text: "Please enter a valid price.");
                        } else {
                          for (var i in images) {
                            final bytes = await i.readAsBytes();
                            final fileUrl = await networkProvider.getUrlForFileUpload(bytes);
                            debugPrint("file url is : $fileUrl");
                            if (fileUrl != null) {
                              imageUrls.add(fileUrl);
                            }
                          }
                          context.read<EventProvider>().createEventApi(
                            eventName: eventName,
                            description: description,
                            venue: "Restaurant",
                            address: address,
                            capacity: capacity,
                            price: price,
                            images: [],
                            date: "${_selectedDate?.day}-${_selectedDate?.month}-${_selectedDate?.year}",
                            startTime: "${_startTime?.hour}:${_startTime?.minute}",
                            endTime: "${_endTime?.hour}:${_endTime?.minute}",

                          );
                        }
                      },),
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
                  text: al.tapToUpload,
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
