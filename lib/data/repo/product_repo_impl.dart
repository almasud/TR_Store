/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/domain/repo/product_repo.dart';
import 'package:tr_store/main.dart';
import 'package:tr_store/utils/app_constants.dart';
import 'package:http/http.dart';

final dummyProducts = [
  const Product(
      id: 1,
      title: "Product 1",
      content:
          "This the content of the Product 1 sdk sldkjs sdk sdjlskjlsd s sdkjfslkdjf sdjklsdkjfsd  sdljlsjf",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 1,
      publishedAt: "04/02/2023 13:25:21",
      updatedAt: "14/03/2023 17:22:20"),
  const Product(
      id: 2,
      title: "Product 2",
      content: "This the content of the Product 2",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 2,
      publishedAt: "05/02/2023 13:25:21",
      updatedAt: "14/03/2023 17:22:20"),
  const Product(
      id: 3,
      title: "Product 3",
      content: "This the content of the Product 3",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 3,
      publishedAt: "06/02/2023 13:25:21",
      updatedAt: "14/03/2023 18:22:20"),
  const Product(
      id: 4,
      title: "Product 4",
      content: "This the content of the Product 4",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 4,
      publishedAt: "07/02/2023 13:25:21",
      updatedAt: "15/03/2023 18:22:20"),
  const Product(
      id: 5,
      title: "Product 5",
      content: "This the content of the Product 5",
      image: "https://picsum.photos/seed/picsum/150/250",
      thumbnail: "https://picsum.photos/seed/picsum/200/300",
      userId: 5,
      publishedAt: "08/02/2023 14:25:21",
      updatedAt: "16/03/2023 19:22:20"),
];

List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> products) =>
    json.encode(products.map((x) => x.toJson()).toList());

class ProductRepoImpl extends ProductRepo {
  static const String _productsUrl = "posts";

  @override
  Future<List<Product>> getProductsFromDb() async {
    await loadProductsFromRemote();
    return appDatabase.productDao.getProducts();
  }

  @override
  Future<void> loadProductsFromRemote() async {
    try {
      const url = '${AppConstant.baseUrl}/$_productsUrl';
      final Uri uri = Uri.parse(url);
      debugPrint("loadProductsFromRemote: uri: $uri");
      Response response = await get(uri);
      // debugPrint("getRepoIssues: response: ${response.body}");

      switch (response.statusCode) {
        case 200:
          appDatabase.productDao
              .insertProducts(productsFromJson(response.body));
        default:
          debugPrint("getRepoIssues: error: ${response.reasonPhrase}");
        // throw "error: ${response.reasonPhrase}";
      }
    } on HttpException catch (e) {
      debugPrint("getRepoIssues: HttpException: ${e.message}");
      // throw "error: ${e.toString()}";
    } on Exception catch (e) {
      debugPrint("getRepoIssues: Exception: ${e.toString()}");
      // throw "error: ${e.toString()}";
    }
  }

  @override
  Future<void> insertProductsToDb(List<Product> products) async {
    await appDatabase.productDao.insertProducts(products);
  }

  @override
  Future<Product> getProductFromDb(int id) async {
    return await appDatabase.productDao.getProduct(id);
  }
}
