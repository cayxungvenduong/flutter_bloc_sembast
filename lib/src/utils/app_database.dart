import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'dart:async';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDir = await getExternalStorageDirectory();
    final dbPath = join(appDir.path, 'demo.db');
    final Database db=await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(db);
  }
}
