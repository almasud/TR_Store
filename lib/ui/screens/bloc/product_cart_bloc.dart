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

  ProductCartBloc({required this.cartRepo}) : super(const ProductCartState()) {
    // Listen the cartsWithProducts source stream
    _cartsWithProductsSubscription =
        cartRepo.getCartsWithProducts().listen((cartsWithProducts) {
      // When new cartsWithProducts is received, emit a new state
      add(FetchCartWithProduct(cartsWithProducts: cartsWithProducts));
    });

    on<AddProductToCart>(_onAddProductToCart);
    on<FetchCartWithProduct>(_onFetchCartsWithProducts);
    on<UpdateProductQuantityToCart>(_onUpdateProductQuantityToCart);
    on<DeleteProductsFromCart>(_onDeleteProductsFromCart);
  }

  @override
  Future<void> close() {
    _cartsWithProductsSubscription
        .cancel(); // Cancel the subscription when closing the bloc
    return super.close();
  }

  FutureOr<void> _onAddProductToCart(
      AddProductToCart event, Emitter<ProductCartState> emit) async {
    try {
      int cartId = await cartRepo.insertCart(event.product.id, 1);
      emit(state.copyWith(
          cartId: cartId,
          productCartStatus: ProductCartStatus.addToCartSuccess,
          message: AppString.addToCartSuccess));
    } on Exception catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          productCartStatus: ProductCartStatus.addToCartFailed));
    }
  }

  FutureOr<void> _onFetchCartsWithProducts(
      FetchCartWithProduct event, Emitter<ProductCartState> emit) {
    try {
      List<CartWithProduct> cartsWithProducts = event.cartsWithProducts;
      debugPrint("_onFetchCartsWithProducts: ${cartsWithProducts.length}");
      if (cartsWithProducts.isNotEmpty) {
        emit(state.copyWith(
            cartsWithProducts: cartsWithProducts,
            productCartStatus: ProductCartStatus.fetchCartsWithProductsSuccess,
            message: AppString.success));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          productCartStatus: ProductCartStatus.fetchCartsWithProductsFailed));
    }
  }

  Future<FutureOr<void>> _onUpdateProductQuantityToCart(
      UpdateProductQuantityToCart event, Emitter<ProductCartState> emit) async {
    try {
      int cartId = await cartRepo.updateProductQuantity(
          event.productId, event.newProductQuantity);
      debugPrint(
          "_onUpdateProductQuantityToCart: cartId: $cartId and newProductQuantity: ${event.newProductQuantity}");

      emit(state.copyWith(
          cartId: cartId,
          productCartStatus:
              ProductCartStatus.updateProductQuantityToCartSuccess,
          message: AppString.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          productCartStatus:
              ProductCartStatus.updateProductQuantityToCartFailed));
    }
  }

  Future<FutureOr<void>> _onDeleteProductsFromCart(
      DeleteProductsFromCart event, Emitter<ProductCartState> emit) async {
    try {
      await cartRepo.deleteCart(event.cartId);
      debugPrint("_onDeleteProductsFromCart: executed");

      emit(state.copyWith(
          productCartStatus: ProductCartStatus.deleteProductFromCartSuccess,
          message: AppString.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          productCartStatus: ProductCartStatus.deleteProductFromCartFailed));
    }
  }
}
