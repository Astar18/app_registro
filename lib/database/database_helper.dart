import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'usuarios.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE usuarios("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "nombre TEXT NOT NULL, "
          "correo TEXT NOT NULL, "
          "password TEXT NOT NULL, "
          "telefono TEXT, "
          "fecha_nacimiento TEXT, "
          "genero TEXT, "
          "direccion TEXT, "
          "fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP"
          ")",
        );
      },
    );
  }

  Future<int> insertarUsuario(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('usuarios', row);
  }

  Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
    Database db = await database;
    return await db.query('usuarios');
  }
}