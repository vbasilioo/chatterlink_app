import 'dart:io';
import 'dart:typed_data';
import 'package:chatterlink/src/features/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Configuration extends StatefulWidget {
  final String username;

  Configuration({required this.username});

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  File? _image;
  ImageProvider? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      columns: ['profile_image'],
      where: 'username = ?',
      whereArgs: [widget.username],
    );

    if (results.isNotEmpty) {
      final imageBytes = results.first['profile_image'] as Uint8List?;
      if (imageBytes != null) {
        setState(() {
          _profileImage = MemoryImage(imageBytes);
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await _saveImageToDatabase(_image!);
      _loadProfileImage();
    }
  }

  Future<void> _saveImageToDatabase(File image) async {
    final byteData = await image.readAsBytes();
    final imageBytes = byteData.toList();

    final db = await DatabaseHelper().database;
    await db.update(
      'users',
      {'profile_image': imageBytes},
      where: 'username = ?',
      whereArgs: [widget.username],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: const Color.fromARGB(100, 0, 85, 224),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "+55 (12) 98309-6471",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: _profileImage ??
                      const NetworkImage(
                        "https://www.upload.ee/image/17067837/Screenshot_1.png",
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      },
                      child: const Text("Câmera"),
                    ),
                    TextButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text("Galeria"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
