import 'package:api_crud/data/api.dart';
import 'package:api_crud/models/user.dart';
import 'package:api_crud/screens/detalhes_screen.dart';
import 'package:api_crud/screens/update_screen.dart';
import 'package:api_crud/screens/home_screen.dart';
import 'package:api_crud/utils/routes_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //late Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        RoutesApp.home: (ctx) => HomeScreen(),
        //RoutesApp.detalhesUser: (ctx) => DetalhesScreen(usuario: user),
        //RoutesApp.updeteUser: (ctx) => DetalhesScreen(user: widget.user['id']),
      },
    );
  }
}
