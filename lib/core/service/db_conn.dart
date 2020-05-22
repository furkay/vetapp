import 'package:mysql1/mysql1.dart';

class DBConn {
  static final DBConn _instance = DBConn._();
  static MySqlConnection _mySqlConnection;
  DBConn._();
  factory DBConn() {
    return _instance;
  }

  static Future<MySqlConnection> get db async {
    if (_mySqlConnection != null) {
      return _mySqlConnection;
    }
    _mySqlConnection = await init();

    return _mySqlConnection;
  }

  static Future<MySqlConnection> init() async {
    var settings = ConnectionSettings(
      db: 'test',
      user: 'root',
      host: '10.0.2.2',
    );

    final conn = await MySqlConnection.connect(settings);

    return conn;
  }
}
