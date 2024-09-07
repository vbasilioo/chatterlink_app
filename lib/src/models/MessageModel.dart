import 'package:flutter/material.dart';

class MessageModel {
  final String content;
  final bool isSentByMe;

  MessageModel({required this.content, required this.isSentByMe});
}

class MessageView extends StatelessWidget {
  final List<MessageModel> messages;

  const MessageView({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, i) {
          final message = messages[i];

          Alignment alignment = message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft;
          Color color = message.isSentByMe
              ? const Color.fromARGB(98, 125, 167, 235)
              : Colors.white;

          return Align(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  message.content,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
