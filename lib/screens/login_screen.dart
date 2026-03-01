import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  // Función para validar el login contra SQLite
  void _iniciarSesion() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // instanciar la base de datos para usar
      final db = await DatabaseHelper().database;
      
      //consultar si existe un usuario con lo que ingresa
      final List<Map<String, dynamic>> resultado = await db.query(
        'usuarios',
        where: 'correo = ? AND password = ?',
        whereArgs: [_correoCtrl.text.trim(), _passCtrl.text],
      );

      setState(() => _isLoading = false);

      if (resultado.isNotEmpty) {
        final usuarioLogueado = resultado.first;
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("¡Bienvenido ${usuarioLogueado['nombre']}!"),
              backgroundColor: Colors.green,
            ),
          );
          
          // Para posibles futuras funcionalidades seria primero esta ruta y despues redireccionar a home
          Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Correo o contraseña incorrectos"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresar'),
        backgroundColor: const Color.fromARGB(255, 67, 88, 211),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 67, 88, 211),
                  child: Icon(Icons.lock_person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:  Color.fromARGB(255, 67, 88, 211),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Campo de Correo
                TextFormField(
                  controller: _correoCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Correo Electrónico",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Ingrese su correo porfavor";
                    if (!value.contains("@")) return "Ingrese un correo válido";
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                
                // Campo de Contraseña
                TextFormField(
                  controller: _passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Ingrese su contraseña";
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                
                // Botón de Ingreso
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _iniciarSesion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromARGB(255, 67, 88, 211),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "INGRESAR",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}