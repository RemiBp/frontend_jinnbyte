import 'dart:io';

import 'package:choice_app/appColors/colors.dart';
import 'package:choice_app/network/network_provider.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../appAssets/app_assets.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text.dart';
import '../../../customWidgets/custom_textfield.dart';
import '../../../res/res.dart';
import '../../../utilities/extensions.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  NetworkProvider networkProvider = NetworkProvider();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    networkProvider.context = context;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        leading: BackButton(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * .05,
          vertical: getHeight() * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Photos",
                  fontFamily: Assets.onsetMedium,
                  fontSize: sizes?.fontSize16,
                ),
                CustomText(
                  text: "File supported: PNG, JPG",
                  fontSize: sizes?.fontSize12,
                ),
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: getHeight() * .2,
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.greyBordersColor,
                        )
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Choose a file",
                              fontFamily: Assets.onsetMedium,
                              fontSize: sizes?.fontSize14,
                            ),
                            CustomText(
                              text: "Up to 5 images",
                              fontSize: sizes?.fontSize14,
                              color: HexColor.fromHex("#686A82"),
                            ),

                          ],
                        )
                    ),
                  ),
                )
                , Wrap(
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

            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: titleController,
              borderColor: AppColors.greyBordersColor,
              hint: "e.g Sunday Brunch at The Maple House",
              label: "Title",
            ),
            SizedBox(height: getHeight() * .02),

            CustomField(
              textEditingController: descriptionController,
              height: getHeight() * .1,
              borderColor: AppColors.greyBordersColor,
              hint: "Describe your event...",
              label: "Description",
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: tagsController,
              borderColor: AppColors.greyBordersColor,
              hint: "e.g: #cozy, #outdoor_seating",
              label: "Tags",
            ),
            SizedBox(height: getHeight() * .02),
            CustomField(
              textEditingController: locationController,
              borderColor: AppColors.greyBordersColor,
              hint: "Add location",
              label: "Location",
              suffixIcon:Icons.location_on,
              obscure: true,
            ),
            SizedBox(height: getHeight() * .02),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getHeight() * .02,
                horizontal: getWidth() * .05,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: getHeight() * .055,
                      backgroundColor: Colors.transparent,
                      buttonText: "Cancel",
                      textColor: Colors.black,
                      borderColor: Colors.black,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: getHeight() * .055,
                      buttonText: "Publish",
                      onTap: () async{
                        final title = titleController.text.trim();
                        final description = descriptionController.text.trim();
                        final tags = tagsController.text.trim();
                        final location = locationController.text.trim();
                        if (images.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please Select at least one image");
                        } else if (title.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please Enter title");
                        }else if (description.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please Enter description");
                        }else if (tags.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please Enter relative tags");
                        }else if (location.isEmpty) {
                          Toasts.getErrorToast(
                              text: "Please Enter address");
                        }else{
                          for (var i in images) {
                            final bytes = await i.readAsBytes();
                            final fileUrl = await networkProvider.getUrlForFileUpload(bytes);
                            debugPrint("file url is : $fileUrl");
                            if (fileUrl != null) {
                              imageUrls.add(fileUrl);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
