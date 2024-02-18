/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'package:drift/drift.dart';
import 'package:tr_store/data/db/product/products.dart';

class Carts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productQuantity => integer()();

  DateTimeColumn get publishedAt => dateTime().nullable().check(publishedAt.isNull()).withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable().withDefault(currentDateAndTime)();

  IntColumn get productId => integer().references(Products, #id)();
}

