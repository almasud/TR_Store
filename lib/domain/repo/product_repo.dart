/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:tr_store/data/db/app_database.dart';

abstract class ProductRepo {
  Stream<List<Product>> getProductsFromDb();

  Future<List<Product>> getProductsFromRemote();

  Future<void> insertProductsToDb(List<Product> products);
}
