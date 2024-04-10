import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      itemBuilder: (context, index) {
        final message = messages[index];
        bool isUserMessage = message['isUserMessage'];
        return Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isUserMessage ? AppColors.primaryG : AppColors.secondaryG,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
              ],
            ),
            child: Text(
              message['message'].text.text[0],
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
