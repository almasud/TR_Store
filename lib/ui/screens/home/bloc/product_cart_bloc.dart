/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/domain/models/cart_with_product.dart';
import 'package:tr_store/domain/repo/cart_repo.dart';
import 'package:tr_store/utils/app_constants.dart';

part 'product_cart_event.dart';

part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  final CartRepo cartRepo;
  late StreamSubscription<List<CartWithProduct>> _cartsWithProductsSubscription;

  ProductCartBloc({required this.cartRepo}) : super(const ProductCartState.initial()) {
    // Listen the numOfCarts source stream
    _cartsWithProductsSubscription = cartRepo.getCartsWithProducts().listen((cartsWithProducts) {
      // When new cartsWithProducts is received, emit a new state
      add(FetchCartWithProduct(cartsWithProducts: cartsWithProducts));
    });

    on<AddProductToCartRequest>(_onAddProductToCart);
    on<FetchCartWithProduct>(_onFetchCartsWithProducts);
  }

  @override
  Future<void> close() {
    _cartsWithProductsSubscription
        .cancel(); // Cancel the subscription when closing the bloc
    return super.close();
  }

  FutureOr<void> _onAddProductToCart(
      AddProductToCartRequest event, Emitter<ProductCartState> emit) async {
    // Set loading before adding product to cart
    emit(const ProductCartState.initial());

    try {
      int cartId = await cartRepo.insertCart(event.product.id, 1);
      emit(ProductCartState.addToCartSuccess(cartId));
    } on Exception catch (e) {
      emit(ProductCartState.addToCartFailed(e.toString()));
    }
  }

  FutureOr<void> _onFetchCartsWithProducts(
      FetchCartWithProduct event, Emitter<ProductCartState> emit) {
    try {
      List<CartWithProduct> cartsWithProducts = event.cartsWithProducts;
      debugPrint("_onFetchCartsWithProducts: ${cartsWithProducts.length}");
      if (cartsWithProducts.isNotEmpty) {
        emit(ProductCartState.fetchCartsWithProductsSuccess(cartsWithProducts));
      }
    } on Exception catch (e) {
      emit(ProductCartState.cartsWithProductsFailed(e.toString()));
    }
  }
}
