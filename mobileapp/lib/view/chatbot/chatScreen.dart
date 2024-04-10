import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

// Chat screen that uses DialogFlowtter for message handling
class ChatScreen extends StatefulWidget {
  static String routeName = "/Chatbot";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor1,
        title: Text('ChatBot', style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                initialItemCount: messages.length,
                itemBuilder: (context, index, animation) =>
                    _buildMessage(index, animation),
              ),
            ),
            // Input field and send button
            _buildQuickReplies(), // Display quick replies above the input field
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(int index, Animation<double> animation) {
    final message = messages[index];
    bool isUserMessage = message['isUserMessage'];
    return SizeTransition(
      sizeFactor: animation,
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isUserMessage) ...[
              Icon(Icons.android, color: Colors.green), // Chatbot icon
              SizedBox(width: 8),
            ],
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: isUserMessage
                    ? AppColors.primaryColor1
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message['message'].text.text[0],
                style: TextStyle(
                  color: isUserMessage ? Colors.white : Colors.black87,
                  fontSize: 12,
                ),
              ),
            ),
            if (isUserMessage) ...[
              SizedBox(width: 8),
              Icon(Icons.person, color: AppColors.primaryColor1), // User icon
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.grayColor),
                ),
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
            IconButton(
              onPressed: () {
                sendMessage(_controller.text);
                _controller.clear();
              },
              icon: Icon(Icons.send, color: AppColors.primaryColor1),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
      return;
    }

    // Adding user message to the chat
    final userMessage = {
      'message': Message(text: DialogText(text: [text])),
      'isUserMessage': true,
    };

    setState(() {
      messages.add(userMessage);
      _listKey.currentState?.insertItem(messages.length - 1);
    });

    // Simulating a chatbot response that echoes the user's message
    final botMessage = {
      'message': Message(text: DialogText(text: ["You said: $text"])),
      'isUserMessage': false,
    };

    // Add a slight delay to simulate the chatbot "typing"
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      messages.add(botMessage);
      _listKey.currentState?.insertItem(messages.length - 1);
    });
  }

  // Define a list of quick replies (outside your build method)
  final List<String> quickReplies = [
    "What's the weather today?",
    "Give me a productivity tip",
    "How many glasses of water should I drink daily?",
  ];

// Build method to display quick replies
  Widget _buildQuickReplies() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            quickReplies.map((reply) => _quickReplyButton(reply)).toList(),
      ),
    );
  }

  Widget _quickReplyButton(String reply) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: () => sendMessage(reply),
        child: Text(reply, style: TextStyle(color: AppColors.primaryColor1)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primaryColor1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  // AddMessage function is now integrated into sendMessage with animation
}
