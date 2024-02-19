/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/domain/repo/product_repo.dart';
import 'package:tr_store/utils/app_constants.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  ProductBloc({required this.productRepo})
      : super(const ProductState.initial()) {
    on<FetchProductsFromRemote>(_onFetchProductsFromRemote);
  }

  Future<FutureOr<void>> _onFetchProductsFromRemote(
      FetchProductsFromRemote event, Emitter<ProductState> emit) async {
    // Set loading before fetching data from remote
    emit(const ProductState.initial());

    try {
      await productRepo
          .getProductsFromDb()
          .then((products) => emit(ProductState.success(products)));
    } on Exception catch (e) {
      emit(ProductState.failed(e.toString()));
    }
  }
}
