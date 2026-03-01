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
  
  // Controladores para los campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _generoCrontroller = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  // Expresiones regulares para validaciones
  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp _telefonoRegex = RegExp(r'^[0-9]{10,}$');

  String? _validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return "El nombre es obligatorio";
    }
    if (value.length < 3) {
      return "El nombre debe tener al menos 3 caracteres";
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return "El nombre solo debe contener letras";
    }
    return null;
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return "El correo es obligatorio";
    }
    if (!_emailRegex.hasMatch(value)) {
      return "Ingresa un correo válido";
    }
    return null;
  }

  String? _validarPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "La contraseña es obligatoria";
    }
    if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "La contraseña debe contener al menos un número";
    }
    return null;
  }

  String? _validarConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirma tu contraseña";
    }
    if (value != _passController.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String? _validarTelefono(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    if (!_telefonoRegex.hasMatch(value)) {
      return "Ingresa un teléfono válido (mínimo 10 dígitos)";
    }
    return null;
  }

  void _guardar() async {
    if (_formKey.currentState!.validate()) {
      await _dbHelper.insertarUsuario({
        'nombre': _nombreController.text.trim(),
        'correo': _correoController.text.trim(),
        'password': _passController.text,
        'telefono': _telController.text.trim(),
        'fecha_nacimiento': _fechaNacimientoController.text,
        'genero': _generoCrontroller.text,
        'direccion': _direccionController.text.trim(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuario Guardado Exitosamente"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _telController.dispose();
    _fechaNacimientoController.dispose();
    _generoCrontroller.dispose();
    _direccionController.dispose();
    super.dispose();
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
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre Completo",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: _validarNombre,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: "Correo Electrónico",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validarCorreo,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validarPassword,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  labelText: "Confirmar Contraseña",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validarConfirmPassword,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(
                  labelText: "Teléfono (Opcional)",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: _validarTelefono,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fechaNacimientoController,
                decoration: const InputDecoration(
                  labelText: "Fecha de Nacimiento (Opcional)",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  hintText: "DD/MM/YYYY",
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _generoCrontroller,
                decoration: const InputDecoration(
                  labelText: "Género (Opcional)",
                  prefixIcon: Icon(Icons.wc),
                  border: OutlineInputBorder(),
                  hintText: "Masculino / Femenino / Otro",
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  labelText: "Dirección (Opcional)",
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 65, 128, 200),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Registrar Ahora",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}