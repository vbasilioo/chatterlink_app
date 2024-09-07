import 'dart:io';
import 'package:chatterlink/src/features/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Cadaster extends StatefulWidget {
  @override
  _CadasterState createState() => _CadasterState();
}

class _CadasterState extends State<Cadaster> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  File? _profileImage;

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }

    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }

    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void _validatorFields() {
    if (_formKey.currentState?.validate() ?? false) {
      _cadasterUser();
    }
  }

  void _cadasterUser() async {
    String username = _controllerUsername.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    Map<String, dynamic> user = {
      'username': username,
      'email': email,
      'password': password,
      'profile_image': _profileImage != null
          ? _profileImage!.readAsBytesSync()
          : null,
    };

    int result = await DatabaseHelper().insertUser(user);

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar usuário.')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(100, 0, 85, 224)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26),
                    child: _profileImage != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: FileImage(_profileImage!),
                          )
                        : CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              color: Colors.white,
                              onPressed: _pickImage,
                            ),
                          ),
                  ),
                  const Text(
                    'Cadastro',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: _controllerUsername,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Nome",
                        border: UnderlineInputBorder(),
                      ),
                      validator: _validateUsername,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        border: UnderlineInputBorder(),
                      ),
                      validator: _validateEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        border: UnderlineInputBorder(),
                      ),
                      validator: _validatePassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 4),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validatorFields,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(100, 0, 87, 224),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text("Cadastrar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
