import 'package:chatterlink/src/features/configurations/Configuration.dart';
import 'package:chatterlink/src/features/home/Contacts.dart';
import 'package:chatterlink/src/features/home/Conversations.dart';
import 'package:chatterlink/src/features/login/Login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String username;

  Home({required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> menuItens = [
    "Configurações", "Sair"
  ];

  void _changeMenuItem(String item){
    switch(item){
      case "Configurações": 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Configuration(username: widget.username),
          ),
        );
        break;
      case "Sair":
        _logout();
        break;
    }
  }

  void _logout(){
    Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (_) => Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatterlink'),
        backgroundColor: const Color.fromARGB(100, 0, 85, 224),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const <Widget>[
            Tab(text: "Conversas"),
            Tab(text: "Contatos"),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _changeMenuItem,
            itemBuilder: (context){
              return menuItens.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const Conversations(),
          Contacts(),
        ],
      ),
    );
  }
}
