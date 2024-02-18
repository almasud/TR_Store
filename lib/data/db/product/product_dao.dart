/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'package:drift/drift.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/db/product/products.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(AppDatabase appDatabase) : super(appDatabase);

  Future<void> insertProduct(Product product) async {
    into(products).insert(
        ProductsCompanion.insert(
            id: product.id,
            title: product.title,
            content: product.content,
            thumbnail: product.thumbnail,
            image: product.image,
            publishedAt: Value(product.publishedAt),
            updatedAt: Value(product.updatedAt),
            userId: product.userId),
        mode: InsertMode.insertOrReplace);
  }

  Future<void> insertProducts(List<Product> products) async {
    products.forEach(insertProduct);
  }

  Future<Product> getProduct(int productId) async {
    return await (select(products)
          ..where((tbl) => tbl.id.equals(productId)))
        .getSingle();
  }

  Future<List<Product>> getProducts() {
    return select(products).get();
  }
}
