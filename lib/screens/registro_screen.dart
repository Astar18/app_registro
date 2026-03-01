import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});
  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = DatabaseHelper();
  
  // Controladores para los nuevos campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  void _guardar() async {
    if (_formKey.currentState!.validate()) {
      await _dbHelper.insertarUsuario({
        'nombre': _nombreController.text,
        'correo': _correoController.text,
        'password': _passController.text,
        'telefono': _telController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Usuario Guardado")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nombreController, decoration: const InputDecoration(labelText: "Nombre"), validator: (v) => v!.isEmpty ? "Obligatorio" : null),
              TextFormField(controller: _correoController, decoration: const InputDecoration(labelText: "Correo"), validator: (v) => v!.isEmpty ? "Obligatorio" : null),
              TextFormField(controller: _passController, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
              TextFormField(controller: _telController, decoration: const InputDecoration(labelText: "Teléfono"), keyboardType: TextInputType.phone),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _guardar, child: const Text("Registrar Ahora"))
            ],
          ),
        ),
      ),
    );
  }
}