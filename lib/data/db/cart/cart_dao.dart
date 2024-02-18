/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'package:drift/drift.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/db/cart/carts.dart';
import 'package:tr_store/domain/models/cart_with_product.dart';

part 'cart_dao.g.dart';

@DriftAccessor(tables: [Carts])
class CartDao extends DatabaseAccessor<AppDatabase> with _$CartDaoMixin {
  CartDao(AppDatabase appDatabase) : super(appDatabase);

  Future<void> insertCart(int productId, int productQuantity) async {
    into(carts).insertOnConflictUpdate(CartsCompanion.insert(
        productQuantity: productQuantity, productId: productId));
  }

  Future<void> updateCart(Cart cart) async {
    await update(carts).replace(cart);
  }

  Future<int> updateProductQuantity(
      int productId, int newProductQuantity) async {
    return await (update(carts)
          ..where((tbl) => tbl.productId.equals(productId)))
        .write(CartsCompanion(productQuantity: Value(newProductQuantity)));
  }

  Stream<int?> getCartsCount() {
    //Create expression of count
    var countExp = carts.id.count();
    final query = selectOnly(carts)..addColumns([countExp]);

    return query.map((row) => row.read(countExp)).watchSingle();
  }

  Future<int> deleteCart(cartId) async {
    return await (delete(carts)..where((t) => t.id.equals(cartId))).go();
  }

  Future<List<CartWithProduct>> getCartsWithProducts() async {
    // Perform the join operation using the join method
    final query = select(carts).join([
      innerJoin(products, carts.productId.equalsExp(products.id)),
    ]);

    // Map the result to a custom data class
    return await query.map((row) {
      return CartWithProduct(
        cart: row.readTable(carts),
        product: row.readTable(products),
      );
    }).get();
  }
}
