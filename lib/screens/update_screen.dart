import 'package:api_crud/data/api.dart';
import 'package:api_crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  Map<String, dynamic> user;
  UpdateScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final Api api = Api();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.user['name'];
    emailController.text = widget.user['email'];
    websiteController.text = widget.user['website'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar Usuario"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              label: Text("Nome"),
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
          ),
          TextFormField(
            controller: websiteController,
            decoration: const InputDecoration(
              label: Text("Website"),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              api.atualizarUser(context, id: widget.user['id']);
            },
            child: const Text("Atualizar"),
          ),
        ],
      ),
    );
  }
}
