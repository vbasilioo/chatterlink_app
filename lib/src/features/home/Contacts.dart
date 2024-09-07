import 'dart:typed_data';
import 'package:chatterlink/src/features/database/database_helper.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> contacts = await db.query('users');

    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          final name = contact['username'] as String;
          final profileImage = contact['profile_image'] as Uint8List?;

          return ListTile(
            onTap: () {
              final contact = _contacts[index];
              Navigator.pushNamed(
                context,
                "/message",
                arguments: {
                  'id': contact['id'],
                  'username': contact['username'],
                },
              );
            },
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: profileImage != null
                  ? MemoryImage(profileImage)
                  : const NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/17/17004.png",
                    ),
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}