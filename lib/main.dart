import 'package:app_registro/screens/home_screen.dart';
import 'package:app_registro/screens/lista_usuarios_screen.dart';
import 'package:app_registro/screens/login_screen.dart';
import 'package:app_registro/screens/registro_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Registro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 65, 128, 200)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/lista': (context) => const ListaUsuariosScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}