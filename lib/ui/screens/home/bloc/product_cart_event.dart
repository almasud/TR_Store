/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();
}

class AddProductToCartRequest extends ProductCartEvent {
  final Product product;

  const AddProductToCartRequest({required this.product});

  @override
  List<Object?> get props => [product];
}

class FetchCartWithProduct extends ProductCartEvent {
  final List<CartWithProduct> cartsWithProducts;

  const FetchCartWithProduct({required this.cartsWithProducts});

  @override
  List<Object?> get props => [cartsWithProducts];
}
