/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/domain/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final _appDatabase = getIt<AppDatabase>();

  @override
  Stream<List<Product>> getProductsFromDb() {
    return _appDatabase.productDao.getProducts();
  }

  @override
  Future<List<Product>> getProductsFromRemote() {
    // TODO: implement getProductsFromRemote
    throw UnimplementedError();
  }

  @override
  Future<void> insertProductsToDb(List<Product> products) async {
    await _appDatabase.productDao.insertProducts(products);
  }
}
