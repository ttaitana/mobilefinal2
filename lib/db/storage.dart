import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnUseId = 'user_id';
final String columnName = 'name';
final String columnAge = 'age';
final String columnPassword = 'password';
final String columnQuote = 'quote';

class Storage {
  int id;
  String user;
  int age;
  String password;
  String quote;
  String name;

  Storage();

  Storage.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.user = map[columnUseId];
    this.age = map[columnAge];
    this.name = map[columnName];
    this.password = map[columnPassword];
    this.quote = map[columnQuote];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnUseId: user,
      columnAge: age,
      columnName: name,
      columnPassword: password,
      columnQuote: quote,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'id: ${this.id}, userid:  ${this.user}, name:  ${this.name}, age:  ${this.age}, password:  ${this.password}, quote:  ${this.quote}';
  }
}

class StorageProvider {
  Database db;

  Future open(String path) async {
    print('Oppening');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableTodo(
          $columnId integer primary key autoincrement,
          $columnUseId text not null UNIQUE,
          $columnAge int not null,
          $columnName text not null,
          $columnPassword text not null,
          $columnQuote text
        )
      ''');
    });
  }

  Future<Storage> insert(Storage data) async {
    data.id = await db.insert(tableTodo, data.toMap());
    return data;
  }

  Future<Storage> getData(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnUseId, columnName, columnQuote, columnAge],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return new Storage.formMap(maps.first);
    }
    return null;
  }

  Future<int> update(Storage data) async {
    return await db.update(tableTodo, data.toMap(),
        where: '$columnId = ?', whereArgs: [data.id]);
  }

  Future<bool> logins(String username, String password) async {
    print('get int');
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnUseId, columnName, columnQuote, columnAge],
        where: '$columnUseId = ?',
        whereArgs: [username]);
    print(maps);
    // if(data.length > 0){
    //   return true;
    // }else{
    //   return false;
    // }
    // return data;
  }

  Future close() async => db.close();
}
