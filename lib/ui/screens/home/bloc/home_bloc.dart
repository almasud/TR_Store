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

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepo productRepo;

  HomeBloc({required this.productRepo}) : super(const HomeState()) {
    on<FetchProductsFromRemote>(_onFetchProductsFromRemote);
  }

  Future<FutureOr<void>> _onFetchProductsFromRemote(
      FetchProductsFromRemote event, Emitter<HomeState> emit) async {
    // Set loading before fetching data from remote
    emit(state.copyWith(uiStatus: HomeUiStatus.loading));

    try {
      await productRepo.getProductsFromDb().then((products) => emit(
          state.copyWith(uiStatus: HomeUiStatus.success, products: products)));
    } on Exception catch (e) {
      emit(
          state.copyWith(uiStatus: HomeUiStatus.failed, message: e.toString()));
    }
  }
}
