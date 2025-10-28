import 'package:choice_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../appColors/colors.dart';
import '../../../../customWidgets/custom_button.dart';
import '../../../../res/res.dart';
import '../../customWidgets/custom_text.dart';
import '../../l18n.dart';

class ChatBotHome extends StatefulWidget {
  const ChatBotHome({super.key});

  @override
  State<ChatBotHome> createState() => _ChatBotHomeState();
}

class _ChatBotHomeState extends State<ChatBotHome> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = []; // 👈 start empty

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": messageController.text.trim(),
        "isUser": true,
      });

      // Simulated AI reply (just for demo)
      messages.add({
        "text": "Got it! I’ll process your request soon 😊",
        "isUser": false,
      });
    });

    messageController.clear();

    // After UI update, scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Show Upgrade Dialog after 5 user messages
    final userMessages =
        messages.where((msg) => msg["isUser"] == true).length;
    if (userMessages == 5) {
      Future.delayed(const Duration(milliseconds: 300), _showUpgradeDialog);
    }
  }


  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.getPrimaryColorFromContext(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "AI Copilot",
          style: TextStyle(
            fontSize: sizes?.fontSize18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat / Welcome Area
          Expanded(
            child: messages.isEmpty
                ? _buildWelcomeView(themeColor)
                : ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: sizes!.pagePadding,
                vertical: getHeight() * 0.02,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg["isUser"] as bool;

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: getHeight() * 0.015,
                      left: isUser ? getWidth() * 0.15 : 0,
                      right: isUser ? 0 : getWidth() * 0.15,
                    ),
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (msg["text"] != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? themeColor
                                  : AppColors.greyColor
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(14),
                                topRight: const Radius.circular(14),
                                bottomLeft:
                                Radius.circular(isUser ? 14 : 0),
                                bottomRight:
                                Radius.circular(isUser ? 0 : 14),
                              ),
                            ),
                            child: ChatBotCustomText(
                              text: msg["text"],
                              color: isUser
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor,
                              fontSize: sizes?.fontSize14,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Divider + Input Field
          SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.greyBordersColor,
                  thickness: 1,
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizes!.pagePadding,
                    vertical: getHeight() * 0.012,
                  ),
                  color: AppColors.whiteColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: themeColor.withValues(alpha: 0.08),
                            hintText: al.typeMessage,
                            hintStyle: TextStyle(
                              color: AppColors.inputHintColor,
                              fontSize: sizes?.fontSize14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: AppColors.greyBordersColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: AppColors.greyBordersColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: themeColor,
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: getWidth() * 0.02),
                      GestureDetector(
                        onTap: sendMessage,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: themeColor,
                          child:
                          const Icon(Icons.send, color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Empty State (Welcome screen)
  Widget _buildWelcomeView(Color themeColor) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes!.pagePadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Copilot Icon + Text in one row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.copilotIcon,
                  height: 44,
                  width: 44,
                ),
                const SizedBox(width: 10),
                Text(
                  "Copilot",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    fontFamily:Assets.onsetSemiBold

                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // Subtitle
            Text(
              "Your Everyday AI Companion",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: Assets.onsetRegular
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        final themeColor = AppColors.getPrimaryColorFromContext(context);

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: getWidth() * 0.08, //  horizontal margin
          ),
          child: Container(
            width: getWidth() * 0.85, // 342px on typical phone
            height: getHeight() * 0.35, // 304px
            padding: EdgeInsets.all(getWidth() * 0.06),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(getWidth() * 0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circle container with SVG icon
                Container(
                  width: getWidth() * 0.20, // ~80px
                  height: getWidth() * 0.20,
                  decoration: BoxDecoration(
                    color: AppColors.restaurantPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(getWidth() * 0.15),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.crownIcon, // your SVG icon path
                      height: getWidth() * 0.12, // ~48px
                      width: getWidth() * 0.12,
                    ),
                  ),
                ),

                SizedBox(height: getHeight() * 0.02),

                // Title
                CustomText(
                  text: al.unlockMoreWithPlus,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: Assets.onsetSemiBold,
                ),

                SizedBox(height: getHeight() * 0.01),

                // Subtitle
                CustomText(
                  text: al.getMoreCapableModels,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: Assets.onsetRegular,
                  giveLinesAsText: true,
                ),

                const Spacer(),

                // Upgrade Button
                CustomButton(
                  buttonText: al.upgrade,
                  onTap: () {
                    context.push(Routes.subscribeRoute);
                    //  handle upgrade action here
                  },
                  backgroundColor: themeColor,
                  textColor: AppColors.whiteColor,
                  borderColor: Colors.transparent,
                  buttonWidth: double.infinity,
                  height: getHeight() * 0.055,
                  textFontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
