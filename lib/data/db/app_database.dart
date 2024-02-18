/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:tr_store/data/db/product/product_dao.dart';
import 'package:tr_store/data/db/product/products.dart';

import 'cart/cart_dao.dart';
import 'cart/carts.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Carts,
  Products,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Define a getter to access the Dao (s)
  ProductDao get productDao => ProductDao(this);

  CartDao get cartDao => CartDao(this);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file =
        File(p.join(dbFolder.path, 'tr_store.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cacheBase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cacheBase;

    if (kDebugMode) {
      print("db file: $file");
    }

    return NativeDatabase.createInBackground(file);
  });
}
