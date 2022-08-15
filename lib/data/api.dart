import 'package:api_crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future<dynamic> criarUsuario(user, context) async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    const Map<String, String> API_HEADERS = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    try {
      if (user != null) {
        final resposta = await http.post(
          url,
          headers: API_HEADERS,
          body: jsonEncode(
            <String, String>{
              'name': user.name,
            },
          ),
        );
        if (resposta.statusCode == 200) {
          User.fromJson(json.decode(resposta.body));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("Usuario criado com sucesso"),
            ),
          );
          Navigator.pop(context);
        } else {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("Erro ao criar usuario"),
            ),
          );
        }
      }
    } catch (error) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Erro ao criar usuario ' + error.toString()),
        ),
      );
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Erro ao criar usuario"),
      ),
    );
  }

  Future<List> pegarUsuarios() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var resposta = await http.get(url);
    if (resposta.statusCode == 200) {
      return json.decode(resposta.body).map((user) => user).toList();
    } else {
      return throw Exception("Erro ao carregar usuarios");
    }
  }

  void deletarUsuario(context, {required Map<String, dynamic> user}) async {
    var url =
        Uri.parse("https://jsonplaceholder.typicode.com/users/${user['id']}");
    var resposta = await http.delete(url);
    if (resposta.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("${user['name']} deletado com sucesso"),
        ),
      );
    }
  }

  void atualizarUser(context, {required int id}) async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users/$id");
    var respota = await http.put(url);
    if (respota.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text("Usuario atualizado com sucesso"),
        ),
      );
      Navigator.pop(context);
    }
  }
}
