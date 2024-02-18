/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().unique()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  TextColumn get image => text()();

  TextColumn get thumbnail => text()();

  TextColumn get publishedAt => text().nullable()();

  TextColumn get updatedAt => text().nullable()();

  IntColumn get userId => integer()();
}

