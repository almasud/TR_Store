/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final List<Product>? products;
  final Product? product;
  final String? message;

  const ProductState(
      {this.productStatus = ProductStatus.loading,
      this.products,
      this.product,
      this.message = AppString.failedToLoadData});

  ProductState copyWith(
      {required ProductStatus productStatus,
      List<Product>? products,
      Product? product,
      String? message}) {
    return ProductState(
        productStatus: productStatus,
        products: products ?? this.products,
        product: product ?? this.product,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [productStatus, products, message];
}

enum ProductStatus {
  loading,
  fetchProductsSuccess,
  fetchProductsFailed,
  getProductSuccess,
  getProductFailed
}
