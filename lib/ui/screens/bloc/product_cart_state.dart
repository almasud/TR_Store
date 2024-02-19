/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

part of 'product_cart_bloc.dart';

class ProductCartState extends Equatable {
  final ProductCartStatus productCartStatus;
  final int? cartId;
  final String? message;
  final List<CartWithProduct>? cartsWithProducts;

  const ProductCartState(
      {this.productCartStatus = ProductCartStatus.loading,
      this.cartId,
      this.message = AppString.failedToLoadData,
      this.cartsWithProducts});

  ProductCartState copyWith(
      {required ProductCartStatus productCartStatus,
      int? cartId,
      String? message,
      List<CartWithProduct>? cartsWithProducts}) {
    return ProductCartState(
        productCartStatus: productCartStatus,
        cartId: cartId,
        message: message ?? this.message,
        cartsWithProducts: cartsWithProducts ?? this.cartsWithProducts);
  }

  @override
  List<Object?> get props =>
      [productCartStatus, cartId, message, cartsWithProducts];
}

enum ProductCartStatus {
  loading,
  addToCartSuccess,
  addToCartFailed,
  fetchCartsWithProductsSuccess,
  fetchCartsWithProductsFailed,
  deleteProductFromCartSuccess,
  deleteProductFromCartFailed,
  updateProductQuantityToCartSuccess,
  updateProductQuantityToCartFailed,
}
