import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ListaUsuariosScreen extends StatefulWidget {
  const ListaUsuariosScreen({super.key});

  @override
  State<ListaUsuariosScreen> createState() => _ListaUsuariosScreenState();
}

class _ListaUsuariosScreenState extends State<ListaUsuariosScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _usuarios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  // Función para consultar SQLite
  Future<void> _cargarUsuarios() async {
    final usuarios = await _dbHelper.obtenerUsuarios();
    setState(() {
      _usuarios = usuarios;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personas Registradas'),
        backgroundColor: const Color.fromARGB(255, 67, 88, 211),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _usuarios.isEmpty
              ? const Center(
                  child: Text(
                    'No hay usuarios registrados aún.',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 51, 147, 207)),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _usuarios.length,
                  itemBuilder: (context, index) {
                    final usuario = _usuarios[index];
                    
                    // Extraer la primera letra para el Avatar
                    String inicial = usuario['nombre'] != null && usuario['nombre'].toString().isNotEmpty
                        ? usuario['nombre'].toString().substring(0, 1).toUpperCase()
                        : '?';

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        
                        // Uso de CircleAvatar (Requisito)
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color.fromARGB(255, 79, 97, 203),
                          foregroundColor: Colors.white,
                          child: Text(
                            inicial,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        
                        title: Text(
                          usuario['nombre'] ?? 'Sin nombre',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.email, size: 14, color: Color.fromARGB(255, 51, 147, 207)),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    usuario['correo'] ?? 'Sin correo',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            // Mostrar teléfono solo si existe en la base de datos
                            if (usuario['telefono'] != null && usuario['telefono'].toString().isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(Icons.phone, size: 14, color: Color.fromARGB(255, 51, 147, 207)),
                                  const SizedBox(width: 5),
                                  Text(usuario['telefono']),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}