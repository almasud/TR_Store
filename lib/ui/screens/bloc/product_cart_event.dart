/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();
}

class AddProductToCart extends ProductCartEvent {
  final Product product;

  const AddProductToCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class FetchCartWithProduct extends ProductCartEvent {
  final List<CartWithProduct> cartsWithProducts;

  const FetchCartWithProduct({required this.cartsWithProducts});

  @override
  List<Object?> get props => [cartsWithProducts];
}

class UpdateProductQuantityToCart extends ProductCartEvent {
  final int productId;
  final int newProductQuantity;

  const UpdateProductQuantityToCart(
      {required this.productId, required this.newProductQuantity});

  @override
  List<Object?> get props => [productId, newProductQuantity];
}

class DeleteProductsFromCart extends ProductCartEvent {
  final int cartId;

  const DeleteProductsFromCart({required this.cartId});

  @override
  List<Object?> get props => [cartId];
}
