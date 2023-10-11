import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    try {
      await database.execute(""" 
    CREATE TABLE favorite(
      id TEXT UNIQUE,
      title TEXT,
      image_url TEXT
    )
    """);
      await database.execute("""
      CREATE TABLE download(
      id TEXT UNIQUE,
      title TEXT,
      image_url TEXT
    )
    """);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while creating tables. Kindly try again later');
    }
  }

  static Future<sql.Database> db() async {
    try {
      sql.Database db = await sql.openDatabase('blogexplorer.db', version: 1,
          onCreate: (sql.Database database, int version) async {
        await createTables(database);
      });
      return db;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while opening DB. Kindly try again later');
    }
  }

  static Future<void> addFavorite(
      String id, String title, String imageUrl) async {
    try {
      final db = await SQLHelper.db();

      final data = {'id': id, 'title': title, 'image_url': imageUrl};

      await db.insert('favorite', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while adding favorite. Kindly try again later');
    }
  }

  static Future<void> addDownload(
      String id, String title, String imageUrl) async {
    try {
      final db = await SQLHelper.db();

      final data = {'id': id, 'title': title, 'image_url': imageUrl};

      await db.insert('download', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while adding download. Kindly try again later');
    }
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final db = await SQLHelper.db();

      return db.query('favorite');
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while fetching favorites. Kindly try again later');
    }
  }

  static Future<List<Map<String, dynamic>>> getDownloads() async {
    try {
      final db = await SQLHelper.db();

      return db.query('download');
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while fetching downloads. Kindly try again later');
    }
  }

  static Future<void> deleteDownload(String id) async {
    try {
      final db = await SQLHelper.db();

      await db.delete('download', where: 'id=?', whereArgs: [id]);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while deleting download. Kindly try again later');
    }
  }

  static Future<void> deleteFavorite(String id) async {
    try {
      final db = await SQLHelper.db();

      await db.delete('favorite', where: 'id=?', whereArgs: [id]);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:SQLH; Error occured while removing favorite. Kindly try again later');
    }
  }
}
