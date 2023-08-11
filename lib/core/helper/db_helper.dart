import 'package:sqflite/sqflite.dart';
import 'package:todo_app/features/todo/model/task_model.dart';

class DBHelper {
  const DBHelper._();

  static Future<void> createTables(Database database) async {
    await database.execute(
      'CREATE TABLE tasks('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title STRING, '
      'description TEXT, '
      'date STRING, '
      'startTime STRING, '
      'endTime STRING, '
      'remind INTEGER, '
      'isComplete INTEGER, '
      'repeat INTEGER'
      ')',
    );

    await database.execute('CREATE TABLE users('
        'id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0, '
        'isVerified INTEGER DEFAULT 0'
        ')');
  }

  static Future<Database> db() async {
    return openDatabase(
      'to_do.db',
      version: 1,
      onCreate: (database, _) async {
        await createTables(database);
      },
    );
  }

//USERS
  static Future<void> createUser({required bool isVerified}) async {
    final localDB = await db();

    final data = {'id': 1, 'isVerified': isVerified ? 1 : 0};

    await localDB.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<bool> userExists() async {
    final localDB = await db();
    final userData = await localDB.query('users');
    return userData.isNotEmpty;
  }

  static Future<void> deleteUser() async {
    final localDB = await db();
    localDB.delete('users');
  }

//TASKS

  static Future<void> addTask(TaskModel task) async {
    final localDB = await db();
    await localDB.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteTask(int taskId) async {
    final localDB = await db();
    await localDB.delete('tasks', where: "id = ?", whereArgs: [taskId]);
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final localDB = await db();
    return localDB.query('tasks', orderBy: "id");
  }

  static Future<Map<String, dynamic>> getTaskById(int taskId) async {
    final localDB = await db();
    final task = await localDB.query('tasks',
        where: "id = ?", whereArgs: [taskId], limit: 1);
    return task.first;
  }

  static Future<void> updateTask(TaskModel task) async {
    final localDB = await db();
    await localDB
        .update('tasks', task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }
}
