/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:tr_store/domain/models/cart_with_product.dart';

abstract class CartRepo {

  Stream<int?> getCartsCount();

  Future<int> updateProductQuantity(int productId, int newProductQuantity);

  Future<void> insertCart(int productId, int productQuantity);

  Future<int> deleteCart(cartId);

  Future<List<CartWithProduct>> getCartsWithProducts();
}
