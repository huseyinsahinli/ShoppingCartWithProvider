import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:trying/model/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDatabase();
      return _db;
    }
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'basket.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE basket (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,productInitialPrice INTEGER, productPrice DOUBLE , productStock INTEGER, productQuantity INTEGER, productImage TEXT )');
  }

  Future<Product> insert(Product product) async {
    var dbClient = await db;
    await dbClient!.insert('basket', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return product;
  }

  Future<List<Product>> getBasketList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('basket');

    return queryResult.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('basket', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuanity(Product product) async {
    var dbClient = await db;
    return await dbClient!.update('basket', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }
}
