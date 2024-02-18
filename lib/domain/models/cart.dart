/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 17/2/2024
 */

import 'dart:convert';

import 'package:tr_store/data/db/app_database.dart';

/// id : 1
/// productQuantity : 3
/// publishedAt : ""
/// updatedAt : ""
/// productId : 3

List<Cart> cartsFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartsToJson(List<Cart> carts) =>
    json.encode(carts.map((x) => x.toJson()));

// class Cart {
//   Cart({
//     num? id,
//     num? productQuantity,
//     String? publishedAt,
//     String? updatedAt,
//     num? productId,
//   }) {
//     _id = id;
//     _productQuantity = productQuantity;
//     _publishedAt = publishedAt;
//     _updatedAt = updatedAt;
//     _productId = productId;
//   }
//
//   Cart.fromJson(dynamic json) {
//     _id = json['id'];
//     _productQuantity = json['productQuantity'];
//     _publishedAt = json['publishedAt'];
//     _updatedAt = json['updatedAt'];
//     _productId = json['productId'];
//   }
//
//   num? _id;
//   num? _productQuantity;
//   String? _publishedAt;
//   String? _updatedAt;
//   num? _productId;
//
//   Cart copyWith({
//     num? id,
//     num? productQuantity,
//     String? publishedAt,
//     String? updatedAt,
//     num? productId,
//   }) =>
//       Cart(
//         id: id ?? _id,
//         productQuantity: productQuantity ?? _productQuantity,
//         publishedAt: publishedAt ?? _publishedAt,
//         updatedAt: updatedAt ?? _updatedAt,
//         productId: productId ?? _productId,
//       );
//
//   num? get id => _id;
//
//   num? get productQuantity => _productQuantity;
//
//   String? get publishedAt => _publishedAt;
//
//   String? get updatedAt => _updatedAt;
//
//   num? get productId => _productId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['productQuantity'] = _productQuantity;
//     map['publishedAt'] = _publishedAt;
//     map['updatedAt'] = _updatedAt;
//     map['productId'] = _productId;
//     return map;
//   }
//
// }

final dummyCarts = [
  const Cart(
    id: 1,
    productQuantity: 2,
    // publishedAt: DateTime.now(),
    // updatedAt: DateTime.now(),
    productId: 1,
  ),
  const Cart(
    id: 2,
    productQuantity: 1,
    // publishedAt: DateTime.now(),
    // updatedAt: DateTime.now(),
    productId: 3,
  ),
  const Cart(
    id: 3,
    productQuantity: 4,
    // publishedAt: DateTime.now(),
    // updatedAt: DateTime.now(),
    productId: 2,
  ),
];

class CartWithProduct {
  final Cart cart;
  final Product product;

  CartWithProduct({required this.cart, required this.product});
}
