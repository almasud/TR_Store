/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

part of 'product_cart_bloc.dart';

class ProductCartState extends Equatable {
  final ProductCartStatus uiStatus;
  final int? cartId;
  final String? message;
  final List<CartWithProduct> cartsWithProducts;

  const ProductCartState._(
      {this.uiStatus = ProductCartStatus.loading,
      this.cartId,
      this.message = AppString.failedToLoadData,
      this.cartsWithProducts = const []});

  const ProductCartState.initial() : this._();

  const ProductCartState.addToCartSuccess(int cartId)
      : this._(cartId: cartId, uiStatus: ProductCartStatus.addToCartSuccess);

  const ProductCartState.addToCartFailed(String? message)
      : this._(message: message, uiStatus: ProductCartStatus.addToCartFailed);

  const ProductCartState.fetchCartsWithProductsSuccess(
      List<CartWithProduct> cartsWithProducts)
      : this._(
            cartsWithProducts: cartsWithProducts,
            uiStatus: ProductCartStatus.fetchCartsWithProductsSuccess,
            message: AppString.addToCartSuccess);

  const ProductCartState.cartsWithProductsFailed(String? message)
      : this._(
            message: message,
            uiStatus: ProductCartStatus.fetchCartsWithProductsFailed);

  @override
  List<Object?> get props => [uiStatus, cartId, message, cartsWithProducts];
}

enum ProductCartStatus {
  loading,
  addToCartSuccess,
  addToCartFailed,
  fetchCartsWithProductsSuccess,
  fetchCartsWithProductsFailed
}
