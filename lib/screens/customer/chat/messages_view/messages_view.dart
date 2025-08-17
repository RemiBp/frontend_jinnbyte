import 'package:choice_app/appColors/colors.dart';
import 'package:flutter/material.dart';
import '../../../../appAssets/app_assets.dart';
import '../../../../res/res.dart';
import '../chat_widgets.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _ChatViewState();
}

class _ChatViewState extends State<MessagesView> {
  final List<Map<String, dynamic>> chatData = [
    {
      'type': 'date',
      'date': "Sat, 17/10",
    },
    {
      'type': 'message',
      'message': "Look at how chocho sleep in my arms!",
      'time': "16:46",
      'isSentByMe': false,
      'imageUrl': Assets.addUserIcon,
    },
    {
      'type': 'message',
      'message': "K, I'm on my way",
      'time': "16:50",
      'isSentByMe': true,
      'isRead': true,
    },
    {
      'type': 'date',
      'date': "Today",
    },
    {
      'type': 'message',
      'message': "Good morning, did you sleep well?",
      'time': "09:45",
      'isSentByMe': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        title: "Emelie",
        imageUrl: "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?fit=crop&w=200&q=80",
      ),
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: getHeight() * 0.02),
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                final item = chatData[index];
                if (item['type'] == 'date') {
                  return DateDivider(date: item['date']);
                } else if (item['type'] == 'message') {
                  return MessageBubble(
                    message: item['message'],
                    time: item['time'],
                    isSentByMe: item['isSentByMe'],
                    isRead: item['isRead'] ?? false,
                    imageUrl: item['imageUrl'],
                  );
                }
                return const SizedBox.shrink();
              },
              separatorBuilder: (context, index) {
                final nextItem = chatData[index + 1];
                if (nextItem['type'] == 'date') {
                  return SizedBox(height: getHeightRatio() * 24.0);
                }
                return SizedBox(height: getHeightRatio() * 24.0);
              },
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}