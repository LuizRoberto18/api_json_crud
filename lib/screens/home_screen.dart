import 'dart:convert';

import 'package:api_crud/data/api.dart';
import 'package:api_crud/screens/detalhes_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_crud/screens/update_screen.dart';

import 'package:api_crud/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List> futureUsuarios;
  final List<User> listaUsuarios = [];
  final Api api = Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureUsuarios = api.pegarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuarios"),
      ),
      body: FutureBuilder<List>(
        future: futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("${snapshot.data![index]['id']}"),
                        ),
                        title: Text("${snapshot.data![index]['username']}"),
                        subtitle: Text("${snapshot.data![index]['email']}"),
                        trailing: IconButton(
                          onPressed: () {
                            api.deletarUsuario(context,
                                user: snapshot.data![index]);
                          },
                          icon: const Icon(Icons.clear),
                          color: Colors.redAccent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                /* Navigator.of(context).pushReplacementNamed(
                                        RoutesApp.detalhesUser);*/
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return DetalhesScreen(
                                        usuario: snapshot.data![index],
                                      );
                                    }),
                                  ),
                                );
                              },
                              child: const Text("Detalhes"),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: ((context) {
                                      return UpdateScreen(
                                        user: snapshot.data![index],
                                      );
                                    }),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar dados"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
