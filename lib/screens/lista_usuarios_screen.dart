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

  // Widget helper para mostrar datos con icono
  Widget _buildDataRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color.fromARGB(255, 65, 128, 200)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personas Registradas'),
        backgroundColor: const Color.fromARGB(255, 65, 128, 200),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _usuarios.isEmpty
              ? const Center(
                  child: Text(
                    'No hay usuarios registrados aún.',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 65, 128, 200)),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Encabezado con Avatar y nombre
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color.fromARGB(255, 65, 128, 200),
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    inicial,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        usuario['nombre'] ?? 'Sin nombre',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      if (usuario['fecha_registro'] != null)
                                        Text(
                                          'Registrado: ${usuario['fecha_registro']}',
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 20),
                            // Otros datos
                            _buildDataRow(Icons.email, "Correo", usuario['correo'] ?? 'Sin correo'),
                            const SizedBox(height: 10),
                            if (usuario['telefono'] != null && usuario['telefono'].toString().isNotEmpty)
                              _buildDataRow(Icons.phone, "Teléfono", usuario['telefono']),
                            if (usuario['telefono'] != null && usuario['telefono'].toString().isNotEmpty)
                              const SizedBox(height: 10),
                            if (usuario['fecha_nacimiento'] != null && usuario['fecha_nacimiento'].toString().isNotEmpty)
                              _buildDataRow(Icons.calendar_today, "Fecha Nacimiento", usuario['fecha_nacimiento']),
                            if (usuario['fecha_nacimiento'] != null && usuario['fecha_nacimiento'].toString().isNotEmpty)
                              const SizedBox(height: 10),
                            if (usuario['genero'] != null && usuario['genero'].toString().isNotEmpty)
                              _buildDataRow(Icons.wc, "Género", usuario['genero']),
                            if (usuario['genero'] != null && usuario['genero'].toString().isNotEmpty)
                              const SizedBox(height: 10),
                            if (usuario['direccion'] != null && usuario['direccion'].toString().isNotEmpty)
                              _buildDataRow(Icons.location_on, "Dirección", usuario['direccion']),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}