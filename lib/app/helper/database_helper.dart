import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper._internal();

  Future<Database> initDatabase() async {
    // 데이터베이스 경로 가져오기
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'sylph.db');

    // 데이터베이스 열기
    return openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database db, int version) async {

          debugPrint("database 생성 initDatabase");

          //관리 전화번호 테이블 생성 쿼리
          String createCallHistoryTableQuery = '''
          CREATE TABLE IF NOT EXISTS Phone (
          No INTEGER PRIMARY KEY AUTOINCREMENT,
          PhoneNumber TEXT
          );
          ''';

          await db.execute(createCallHistoryTableQuery);
          debugPrint("createCallHistory table create");

        }
    );
  }

  // 데이터 삽입
  Future<int> insert(Map<String, dynamic> data, String table) async {
    Database? db = await database;
    return db!.insert(table, data);
  }

  // 데이터 조회
  Future<List<Map<String, dynamic>>> query(String table) async {
    Database? db = await database;
    return db!.query(table);
  }

  // 데이터 수정
  Future<int> update(Map<String, dynamic> data, String table,
      {required String where, required List<dynamic> whereArgs}) async {
    Database? db = await database;
    return db!.update(table, data, where: where, whereArgs: whereArgs);
  }

  // 데이터 삭제
  Future<int> delete(String table,
      {required String where, required List<dynamic> whereArgs}) async {
    Database? db = await database;
    return db!.delete(table, where: where, whereArgs: whereArgs);
  }

  // 기간 내의 데이터 검색
  Future<List<Map<String, dynamic>>> searchByPeriod(
      String table, DateTime startDate, DateTime endDate) async {
    Database? db = await database;
    String query = '''
      SELECT *
      FROM $table
      WHERE StartTime BETWEEN ? AND ?
    ''';
    return db!.rawQuery(query, [startDate.toIso8601String(), endDate.toIso8601String()]);
  }

  // 기간 내의 데이터와 전화번호로 검색하여 존재 여부 확인
  Future<bool> checkDataExistsByPeriodAndPhoneNumber(
      String table, DateTime startDate, DateTime endDate, String docID) async {
    Database? db = await database;
    String query = '''
      SELECT COUNT(*) AS count
      FROM $table
      WHERE CallDate BETWEEN ? AND ?
      AND DocID = ?
    ''';
    List<Map<String, dynamic>> result = await db!.rawQuery(query, [
      // startDate.toIso8601String().substring(0, 10),
      // endDate.toIso8601String().substring(0, 10),
      startDate,
      endDate,
      docID,
    ]);
    int count = result.isNotEmpty ? result.first['count'] : 0;
    return count > 0;
  }

  // 데이터베이스 삭제
  Future<void> deleteDatabase() async {
    try {
      // 데이터베이스 경로 가져오기
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'sylph.db');

      // 데이터베이스 파일 삭제
      File dbFile = File(dbPath);
      await dbFile.delete();

      print('데이터베이스가 삭제되었습니다.');
    } catch (e) {
      print('데이터베이스 삭제 오류: $e');
    }
  }
}

/*// 데이터 삽입
await dbHelper.insert(
{'id': 1, 'name': 'John', 'age': 25},
'MyTable',
);

// 데이터 조회
List<Map<String, dynamic>> result = await dbHelper.query('MyTable');
print(result);

// 데이터 수정
await dbHelper.update(
{'age': 26},
'MyTable',
where: 'id = ?',
whereArgs: [1],
);

// 데이터 삭제
await dbHelper.delete(
'MyTable',
where: 'id = ?',
whereArgs: [1],
);*/
