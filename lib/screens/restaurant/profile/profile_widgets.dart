import 'dart:io';

import 'package:choice_app/network/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l18n.dart';
import '../../../res/res.dart';

Future<File?> bottomSheet(BuildContext context) async {
  final provider = Provider.of<NetworkProvider>(context, listen: false);

  File? pickedImage;

  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: getHeight() * .13,
        width: getWidth(),
        margin: EdgeInsets.symmetric(
          horizontal: getWidth() * .02,
          vertical: getHeight() * .02,
        ),
        child: Column(
          children: <Widget>[
            Text(
              al.chooseYourPhoto,
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(height: getHeight() * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () async {
                    final image = await provider.getImage(isCamera: true);
                    Navigator.pop(context, image); // return image
                  },
                  label: Text(al.camera),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image_outlined),
                  onPressed: () async {
                    final image = await provider.getImage(isCamera: false);
                    Navigator.pop(context, image); // return image
                  },
                  label: Text(al.gallery),
                ),
              ],
            )
          ],
        ),
      );
    },
  ).then((value) {
    pickedImage = value;
  });

  return pickedImage;
}
