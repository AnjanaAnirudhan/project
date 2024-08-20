import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_model.dart';
import 'dart:convert'; // For utf8 encoding
import 'dart:math'; // For generating random values
 // For generating SHA256 hash

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('stegovision.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE users (
        id $idType,
        username $textType,
        email TEXT NOT NULL UNIQUE,
        password $textType
      )
    ''');
    // Create the password_resets table
    await db.execute('''
    CREATE TABLE password_resets (
      id $idType,
      email TEXT NOT NULL UNIQUE,
      token TEXT NOT NULL,
      created_at TEXT NOT NULL
    )
  ''');
  }

  Future<bool> isEmailRegistered(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'lower(email) = ?',
      whereArgs: [email.toLowerCase()],
    );
    return result.isNotEmpty;
  }

  Future<bool> insertUser(User user) async {
    final db = await instance.database;

    if (await isEmailRegistered(user.email)) {
      throw Exception('Email already registered');
    }

    await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return true;
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Generates a secure random token
  String generateToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  // Method to store reset token in the database
  Future<void> storeResetToken(String email, String token) async {
    final db = await instance.database;

    // Assuming you have a 'password_resets' table to store the tokens
    await db.insert(
      'password_resets',
      {
        'email': email,
        'token': token,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
