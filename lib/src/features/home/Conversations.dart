
import 'package:chatterlink/src/models/ConversationModel.dart';
import 'package:flutter/material.dart';

class Conversations extends StatefulWidget {
  // Adicionando o parâmetro chave ao construtor
  const Conversations({Key? key}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversations> {
  List<ConversationModel> listConversations = [
    ConversationModel(
      "Roberto Pereira",
      "Seu projeto em Flutter tá maneiro!",
      "https://randomuser.me/api/portraits/men/1.jpg",
    ),  
    ConversationModel(
      "Ana Clara",
      "Oi! Como você está hoje?",
      "https://randomuser.me/api/portraits/women/22.jpg",
    ),
    ConversationModel(
      "Carlos Silva",
      "Você viu as novidades do projeto?",
      "https://randomuser.me/api/portraits/men/15.jpg",
    ),
    ConversationModel(
      "Juliana Pereira",
      "Vamos marcar uma reunião para discutir isso.",
      "https://randomuser.me/api/portraits/women/34.jpg",
    ),
    ConversationModel(
      "Felipe Rocha",
      "Tenho uma ideia que gostaria de compartilhar.",
      "https://randomuser.me/api/portraits/men/45.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listConversations.length,
      itemBuilder: (context, index) {
        ConversationModel conversation = listConversations[index];
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversation.pathPhoto),
          ),
          title: Text(
            conversation.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            conversation.message,
          ),
        );
      },
    );
  }
}
