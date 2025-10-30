import 'package:choice_app/network/network_provider.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:choice_app/routes/routes.dart';
import 'package:choice_app/screens/restaurant/profile/profile_provider.dart';
import 'package:choice_app/userRole/role_provider.dart';
import 'package:choice_app/userRole/user_role.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../l18n.dart';
import '../../../res/res.dart';
import 'gallery_widgets.dart';


class GalleryView extends StatefulWidget {
  const GalleryView({super.key, this.fromSettings = false});

  final bool fromSettings;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final ImagePicker imgPicker = ImagePicker();
  List<XFile> selectedImages = [];

  ScrollController scrollController = ScrollController();
  NetworkProvider networkProvider = NetworkProvider();

  @override
  void initState() {
    super.initState();

    networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    networkProvider.context = context;
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await imgPicker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          selectedImages.addAll(images);
        });
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void setMainImage(int index) {
    if (index > 0) {
      setState(() {
        final XFile mainImage = selectedImages[index];
        selectedImages.removeAt(index);
        selectedImages.insert(0, mainImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.gallery),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding),
        child:Column(
          children: [
            SizedBox(height: getHeightRatio() * 16),
            Expanded(
                child:
                // provider.isDataFetched?
                ListView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    vertical: getHeight() * 0.02,
                  ),
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...selectedImages.asMap().entries.map((entry) {
                          final index = entry.key;
                          final imageFile = entry.value;
                          return GalleryCard(
                            isMainImage: index == 0,
                            imageFile: imageFile.path,
                            onSetMainImage: () {
                              setMainImage(index);
                            },
                            onRemoveImage: () {
                              removeImage(index);
                            },
                          );
                        }),
                        AddImageCard(
                          onAddImages: () {
                            pickImages();
                          },
                        ),
                      ],
                    )
                    // Wrap(
                    //   spacing: 8,
                    //   runSpacing: 8,
                    //   children: [
                    //     if(provider.restaurantImagesResponse.images!.isNotEmpty)
                    //     ...provider.restaurantImagesResponse.images!.asMap().entries.map((entry) {
                    //       final index = entry.key;
                    //       String url = entry.value.imageUrl??"";
                    //
                    //       return GalleryCard(
                    //         isMainImage: index == 0,
                    //         imageFile: url,
                    //         onSetMainImage: (){
                    //         },
                    //         onRemoveImage: () {
                    //         },
                    //       );
                    //     }),
                    //     AddImageCard(
                    //         onAddImages: (){},
                    //     ),
                    //   ],
                    // ),
                  ],
                )
              //     :const Center(
              //   child: CircularProgressIndicator(),
              // ),
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
                  onTap: () async {
                    if(selectedImages.isEmpty) {
                      Toasts.getErrorToast(text: al.pleasePickImage);
                      return;
                    }
                    List<String> urls = [];
                    for(final image in selectedImages) {
                      final bytes = await image.readAsBytes();
                      final fileUrl = await networkProvider.getUrlForFileUpload(
                        bytes,
                      );
                      debugPrint('Uploaded file URL: $fileUrl');
                      if(fileUrl != null) {
                        urls.add(fileUrl);
                      }
                    }

                    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                    final success = await profileProvider.setGalleryImages(imageUrls: urls,context: context);
                    if(success) {
                      final role = context.read<RoleProvider>().role;
                      if(role == UserRole.restaurant) {
                        context.push(Routes.restaurantMenuViewRoute);
                      } else {
                        context.push(Routes.slotManagementViewRoute);
                      }
                    }
                  },
                  buttonWidth: getWidth() * .42,
                  backgroundColor: AppColors.getPrimaryColorFromContext(context),
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  textFontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(height: getHeightRatio() * 16),
          ],
        ),
        // Consumer<GalleryProvider>(
        //   builder: (_, provider, __) {
        //     return
        //   },
        // ),
      ),
    );
  }
}



