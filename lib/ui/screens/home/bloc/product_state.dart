/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ProductStatus uiStatus;
  final List<Product> products;
  final String? message;

  const ProductState._(
      {this.uiStatus = ProductStatus.loading,
      this.products = const [],
      this.message = AppString.failedToLoadData});

  const ProductState.initial() : this._();

  const ProductState.success(List<Product> products)
      : this._(products: products, uiStatus: ProductStatus.success);

  const ProductState.failed(String? message)
      : this._(message: message, uiStatus: ProductStatus.failed);

  @override
  List<Object?> get props => [uiStatus, products, message];
}

enum ProductStatus { loading, success, failed }
