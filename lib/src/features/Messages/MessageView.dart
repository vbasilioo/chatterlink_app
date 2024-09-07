import 'package:flutter/material.dart';

class MessageView extends StatefulWidget {
  final List<String> messages;

  const MessageView({Key? key, required this.messages}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (context, i) {
          Alignment alignment = Alignment.centerRight;
          Color color = const Color.fromARGB(98, 125, 167, 235);
          if (i % 2 == 0) {
            color = Colors.white;
            alignment = Alignment.centerLeft;
          }

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
                  widget.messages[i],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
