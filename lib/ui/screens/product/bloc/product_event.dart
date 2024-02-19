/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class FetchProductsFromRemote extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetProductsFromDb extends ProductEvent {
  final int productId;

  const GetProductsFromDb({required this.productId});

  @override
  List<Object?> get props => [productId];
}
