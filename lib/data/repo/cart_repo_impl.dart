/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/domain/models/cart.dart';
import 'package:tr_store/domain/repo/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final _appDatabase = getIt<AppDatabase>();

  @override
  Future<int> deleteCart(cartId) {
    return _appDatabase.cartDao.deleteCart(cartId);
  }

  @override
  Stream<int?> getCartsCount() {
    return _appDatabase.cartDao.getCartsCount();
  }

  @override
  Future<List<CartWithProduct>> getCartsWithProducts() {
    return _appDatabase.cartDao.getCartsWithProducts();
  }

  @override
  Future<void> insertCart(int productId, int productQuantity) {
    return _appDatabase.cartDao.insertCart(productId, productQuantity);
  }

  @override
  Future<int> updateProductQuantity(int productId, int newProductQuantity) {
    return _appDatabase.cartDao
        .updateProductQuantity(productId, newProductQuantity);
  }
}
