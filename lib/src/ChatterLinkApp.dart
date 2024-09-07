import 'package:chatterlink/src/features/login/Login.dart';
import 'package:chatterlink/src/routes/RouteGenerator.dart';
import 'package:flutter/material.dart';

class ChatterLinkApp extends StatelessWidget {
  const ChatterLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}