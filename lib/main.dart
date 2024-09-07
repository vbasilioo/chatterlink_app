import 'package:chatterlink/src/ChatterLinkApp.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: 'Chatterlink',
      home: ChatterLinkApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main(){
  runApp(const App());
}