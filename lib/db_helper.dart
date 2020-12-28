import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:provider_ass/task_model.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'isComplete';

  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);

      //اول ما ينشئ الداتابيز ينشئ الجدول و الاعمدة-------------------------------------------------
      Database database = await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
            $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskNameColumnName TEXT NOT NULL,
            $taskIsCompleteColumnName INTEGER
          )''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task2 task) async {
    try {
      database = await initDatabase();
      int x = await database.insert(tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task2>> selectAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      List<Task2> tasks = result.map((e) => Task2.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Task2>> selectSpeciphicTask(int isComplete) async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName,
          where: '$taskIsCompleteColumnName=?', whereArgs: [isComplete]);
      List<Task2> tasks = result.map((e) => Task2.fromJson(e)).toList();
      return tasks;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  updateTask(
    Task2 task,
  ) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJson(),
          where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task2 task) async {
    try {
      database = await initDatabase();
      int result = await database.delete(tableName,
          where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
