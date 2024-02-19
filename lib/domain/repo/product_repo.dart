/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:tr_store/data/db/app_database.dart';

abstract class ProductRepo {
  Future<List<Product>> getProductsFromDb();

  Future<Product> getProductFromDb(int id);

  Future<void> loadProductsFromRemote();

  Future<void> insertProductsToDb(List<Product> products);
}
