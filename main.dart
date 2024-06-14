import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  var database = databaseFactoryFfi;

  var db = await database.openDatabase('users.db');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY,
      name TEXT,
      email TEXT,
      age INTEGER
    )
  ''');

  Future<void> addus(String name, String email, int age) async {
    await db.insert('users', {'name': name, 'email': email, 'age': age});
  }

  Future<void> updateus(int id, String name, String email, int age) async {
    await db.update('users', {'name': name, 'email': email, 'age': age}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteus(int id) async {
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    return await db.query('users');
  }

  await addus("Pon", "example@gmail.com", 20);
  //await updateus(1, "Pon1", "example@gmail.com", 20);
  //await deleteus(1);

  List<Map<String, dynamic>> users = await getUsers();
  print('All users:');
  for (var user in users) {
    print(user);
  }

  await db.close();
}
