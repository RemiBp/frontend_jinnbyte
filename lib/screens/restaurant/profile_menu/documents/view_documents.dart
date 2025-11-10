import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:choice_app/customWidgets/common_app_bar.dart';
import 'package:choice_app/customWidgets/custom_text.dart';
import 'package:choice_app/res/res.dart';
import 'package:choice_app/res/toasts.dart';
import 'package:choice_app/appColors/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../l18n.dart';
import '../../../../network/network_provider.dart';
import '../../../restaurant/profile/profile_provider.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  Map<String, dynamic>? documentsData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProfileProvider>();
    provider.context = context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDocuments();
    });
  }

  Future<void> fetchDocuments() async {
    final provider = context.read<ProfileProvider>();
    final response = await provider.getDocuments(context);

    debugPrint("🧾 Raw documents data: ${response?.data?.toJson()}");

    if (response != null && response.data != null) {
      setState(() {
        documentsData = response.data!.toJson();
      });
    } else {
      Toasts.getErrorToast(text: "Failed To Fetch Documents");
    }
  }

  Future<void> updateAndUploadDocument(String documentField) async {
    try {
      // Step 1 Pick a file (PDF only)
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        Toasts.getErrorToast(text: "No file selected");
        return;
      }

      final file = File(result.files.single.path!);
      final networkProvider = context.read<NetworkProvider>();
      final profileProvider = context.read<ProfileProvider>();

      // Step 2 Show uploading loader
      setState(() => isLoading = true);

      // Step 3 Get pre-signed URL and upload to S3
      final uploadedKey = await networkProvider.getUrlForDocumentUpload(
        file,
        context,
        onSendProgress: (sent, total) {
          if (total > 0) {
            debugPrint("📤 Upload Progress: ${(sent / total * 100).toStringAsFixed(1)}%");
          }
        },
      );

      if (uploadedKey == null) {
        setState(() => isLoading = false);
        Toasts.getErrorToast(text: "Failed to upload document");
        return;
      }

      // Step 4 Call updateDocument API with uploaded S3 key
      final response = await profileProvider.updateDocument(
        documentField: documentField,
        documentValue: uploadedKey,
        expiryDate: DateTime(2027, 1, 1),
      );

      setState(() => isLoading = false);

      // Step 5 Handle response
      if (response != null && response.status == 200) {
        Toasts.getSuccessToast(
          text: response.message ?? "Document updated successfully",
        );
        await fetchDocuments();
      } else {
        Toasts.getErrorToast(text: "Failed to update document");
      }
    } catch (e) {
      debugPrint("❌ updateAndUploadDocument error: $e");
      setState(() => isLoading = false);
      Toasts.getErrorToast(text: "Something went wrong");
    }
  }


  Future<void> _deleteDocument(String documentKey) async {
    final provider = context.read<ProfileProvider>();
    final success = await provider.deleteDocument(documentField: documentKey);

    if (success) {
      Toasts.getSuccessToast(text: "Document Deleted Successfully");
      setState(() {
        documentsData?[documentKey] = null;
        documentsData?["${documentKey}Expiry"] = null;
      });
    }
  }

  Future<void> _openDocument(String fileUrl) async {
    final Uri url = Uri.parse(fileUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // opens in default PDF viewer
      );
    } else {
      Toasts.getErrorToast(text: "Could not open document");
    }
  }


  List<Map<String, dynamic>> get uploadedDocuments {
    if (documentsData == null) return [];

    final docs = <Map<String, dynamic>>[];

    // Loop through keys dynamically
    documentsData!.forEach((key, value) {
      if (key.startsWith("document") &&
          !key.endsWith("Expiry") &&
          value != null &&
          value.toString().trim().isNotEmpty) {
        docs.add({
          "key": key,
          "path": value,
          "expiry": documentsData?["${key}Expiry"] ?? "N/A",
        });
      }
    });

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: al.documents),
      body: uploadedDocuments.isEmpty
          ? const SizedBox.shrink() // show nothing if no documents
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getWidth() * 0.05,
          vertical: getHeight() * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: uploadedDocuments
              .map(
                (doc) => Padding(
              padding: EdgeInsets.only(
                  bottom: getHeight() * 0.02),
              child: buildDocumentSection(
                title: _getTitleFromKey(doc["key"]),
                documentKey: doc["key"],
                filePath: doc["path"],
                expiryDate: doc["expiry"],
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  Widget buildDocumentSection({
    required String title,
    required String documentKey,
    required String filePath,
    required String expiryDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: sizes?.fontSize16,
          fontFamily: Assets.onsetSemiBold,
        ),
        SizedBox(height: getHeight() * 0.01),
        DocumentCard(
          fileName: filePath.split('/').last,
          expiryDate: expiryDate,
          onEdit: () => updateAndUploadDocument(documentKey),
          onTap: () => _openDocument(filePath), // open document on tap new
        ),
      ],
    );
  }

  // Optional helper to show human-friendly titles
  String _getTitleFromKey(String key) {
    switch (key) {
      case "document1":
        return "Business Registration Document";
      case "document2":
        return "Utility Bill or Invoice";
      default:
        return "Uploaded Document";
    }
  }
}

class DocumentCard extends StatelessWidget {
  final String fileName;
  final String expiryDate;
  final VoidCallback onEdit;
  final VoidCallback onTap; // handle opening document

  const DocumentCard({
    super.key,
    required this.fileName,
    required this.expiryDate,
    required this.onEdit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // open document on tap
      child: Container(
        padding: EdgeInsets.all(getWidth() * 0.04),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: getHeight() * 0.08,
                width: getWidth() * 0.16,
                color: AppColors.getPrimaryColorFromContext(context)
                    .withValues(alpha: 0.1),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.pdfIcon,
                    height: getWidth() * 0.08,
                    colorFilter: ColorFilter.mode(
                      AppColors.getPrimaryColorFromContext(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: getWidth() * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: fileName,
                    fontFamily: Assets.onsetMedium,
                    fontSize: sizes?.fontSize14,
                  ),
                  SizedBox(height: getHeight() * 0.005),
                  CustomText(
                    text: "120 KB",
                    fontSize: sizes?.fontSize12,
                    color: AppColors.inputHintColor,
                  ),
                  SizedBox(height: getHeight() * 0.005),
                  CustomText(
                    text: "Expiry Date: $expiryDate",
                    fontSize: sizes?.fontSize12,
                    color: AppColors.inputHintColor,
                  ),
                ],
              ),
            ),
            // ✅ Only edit button remains
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit,
                color: Colors.green,
                size: getWidth() * 0.055,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

