class Usuario {
  final int? id;
  final String nombre;
  final String correo;
  final String password;
  final String? telefono;
  final String? fechaNacimiento;
  final String? genero;
  final String? direccion;

  Usuario({
    this.id, required this.nombre, required this.correo, required this.password,
    this.telefono, this.fechaNacimiento, this.genero, this.direccion
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, 'nombre': nombre, 'correo': correo, 'password': password,
      'telefono': telefono, 'fecha_nacimiento': fechaNacimiento,
      'genero': genero, 'direccion': direccion
    };
  }
}