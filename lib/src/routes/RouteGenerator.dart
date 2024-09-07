import 'package:chatterlink/src/features/Messages/Message.dart';
import 'package:chatterlink/src/features/configurations/Configuration.dart';
import 'package:chatterlink/src/features/home/Home.dart';
import 'package:chatterlink/src/features/login/Cadaster.dart';
import 'package:chatterlink/src/features/login/Login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (_) => Home(username: args?['username'] ?? ''),
        );
      case "/cadaster":
        return MaterialPageRoute(
          builder: (_) => Cadaster(),
        );
      case "/configuration":
        return MaterialPageRoute(
          builder: (_) => Configuration(username: args?['username'] ?? ''),
        );
      case "/message":
        return MaterialPageRoute(
          builder: (_) => Message(
            username: args?['username'] ?? '',
          ),
        );
      default:
        return _404();
    }
  }

  static Route<dynamic> _404() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tela não encontrada."),
          ),
          body: const Center(
            child: Text("Tela não encontrada."),
          ),
        );
      },
    );
  }
}
