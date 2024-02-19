/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'dart:convert';

import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/domain/models/cart_with_product.dart';
import 'package:tr_store/domain/repo/cart_repo.dart';
import 'package:tr_store/main.dart';

final dummyCarts = [
  const Cart(
    id: 1,
    productQuantity: 2,
    // updatedAt: DateTime.now(),
    productId: 1,
  ),
  const Cart(
    id: 2,
    productQuantity: 1,
    // updatedAt: DateTime.now(),
    productId: 3,
  ),
  const Cart(
    id: 3,
    productQuantity: 4,
    // updatedAt: DateTime.now(),
    productId: 2,
  ),
];

List<Cart> cartsFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartsToJson(List<Cart> carts) =>
    json.encode(carts.map((x) => x.toJson()));

class CartRepoImpl extends CartRepo {
  @override
  Future<void> deleteCart(cartId) async {
    appDatabase.cartDao.deleteCart(cartId);
  }

  @override
  Stream<int?> getCartsCount() {
    return appDatabase.cartDao.getCartsCount();
  }

  @override
  Stream<List<CartWithProduct>> getCartsWithProducts() {
    return appDatabase.cartDao.getCartsWithProducts();
  }

  @override
  Future<int> insertCart(int productId, int productQuantity) {
    return appDatabase.cartDao.insertCart(productId, productQuantity);
  }

  @override
  Future<int> updateProductQuantity(int productId, int newProductQuantity) {
    return appDatabase.cartDao
        .updateProductQuantity(productId, newProductQuantity);
  }
}
