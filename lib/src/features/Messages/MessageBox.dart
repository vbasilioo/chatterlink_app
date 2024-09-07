import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageBox({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController _controllerMessage = TextEditingController();

  void _sendMessage() {
    if (_controllerMessage.text.isNotEmpty) {
      widget.onSendMessage(_controllerMessage.text);
      _controllerMessage.clear();
    }
  }

  void _sendPhoto() {
    print("Enviando foto.");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMessage,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  hintText: "Mensagem",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  prefixIcon: IconButton(
                    onPressed: _sendPhoto,
                    icon: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(100, 0, 85, 224),
            child: const Icon(Icons.send_rounded, color: Colors.white),
            mini: true,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
