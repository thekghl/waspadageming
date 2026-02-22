import 'package:postgres/postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  // ⚠️ INACTIVE: Reverted to API setup due to connectivity issues.
  // This service is kept for future reference but not called by the app.
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Connection? _connection;

  Future<void> connect() async {
    if (_connection != null && _connection!.isOpen) return;

    final host = dotenv.env['DB_HOST'] ?? 'localhost';
    final port = int.tryParse(dotenv.env['DB_PORT'] ?? '5432') ?? 5432;
    final user = dotenv.env['DB_USER'] ?? 'postgres';
    final password = dotenv.env['DB_PASSWORD'] ?? 'password';
    final dbName = dotenv.env['DB_NAME'] ?? 'earthquake_db';

    try {
      debugPrint('Connecting to Database at $host:$port...');
      _connection = await Connection.open(
        Endpoint(
          host: host,
          database: dbName,
          username: user,
          password: password,
          port: port,
        ),
        settings: const ConnectionSettings(sslMode: SslMode.require),
      );
      debugPrint('✅ Database Connected successfully.');
    } catch (e) {
      debugPrint('❌ Database Connection Error: $e');
      rethrow;
    }
  }

  Future<Result> query(
    String sql, {
    Map<String, dynamic>? substitutionValues,
  }) async {
    await connect();
    try {
      return await _connection!.execute(
        Sql.named(sql),
        parameters: substitutionValues,
      );
    } catch (e) {
      debugPrint('❌ SQL Query Error: $e');
      rethrow;
    }
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
