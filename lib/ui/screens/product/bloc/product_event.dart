/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'product_bloc.dart';

sealed class ProductEvent {
  const ProductEvent();
}

class FetchProductsFromRemote extends ProductEvent {}

class GetProductsFromDb extends ProductEvent {
  final int productId;

  const GetProductsFromDb({required this.productId});
}
