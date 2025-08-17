import 'package:choice_app/screens/onboarding/slot_management/slot_management_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../appColors/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../res/res.dart';
import 'gallery_widgets.dart';


class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final ImagePicker imgPicker = ImagePicker();

  ScrollController scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Gallery"),
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
                        ...List.generate(3, (index) {

                          return GalleryCard(
                            isMainImage: index == 0,
                            imageFile: null,
                            onSetMainImage: () {
                              // handle set as main image
                            },
                            onRemoveImage: () {
                              // handle remove image
                            },
                          );
                        }),
                        AddImageCard(
                          onAddImages: () {
                            // handle add image
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
                  buttonText: 'Save Changes',
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



