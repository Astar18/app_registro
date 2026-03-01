import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido al sistema de Alex'),
        backgroundColor: const Color.fromARGB(255, 65, 128, 200),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user,
              size: 100,
              color: Color.fromARGB(255, 58, 116, 183),
            ),
            const SizedBox(height: 40),
            const Text(
              'Sistema de Registro Local',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 58, 106, 183),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Gestiona el registro de usuarios de forma local y segura mediante SQLite.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Navega a la pantalla de registro
                Navigator.pushNamed(context, '/registro');
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Comenzar Registro'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 65, 128, 200),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                // Navega a la pantalla de lista de usuarios
                Navigator.pushNamed(context, '/lista');
              },
              icon: const Icon(Icons.people),
              label: const Text('Ver Usuarios Registrados'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 65, 128, 200),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}