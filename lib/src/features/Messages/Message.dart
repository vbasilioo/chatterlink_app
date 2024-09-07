import 'package:chatterlink/src/features/Messages/MessageBox.dart';
import 'package:chatterlink/src/features/Messages/MessageView.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final String username;

  const Message({Key? key, required this.username}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<String> messages = [];

  void _addMessage(String message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username.isNotEmpty ? widget.username : 'Usuário Desconhecido'),
        backgroundColor: const Color.fromARGB(100, 0, 85, 224),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/assets/hdbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                MessageView(messages: messages),
                MessageBox(onSendMessage: _addMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
