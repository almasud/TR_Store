/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeUiStatus uiStatus;
  final List<Product>? products;
  final String? message;

  const HomeState(
      {this.uiStatus = HomeUiStatus.loading, this.products, this.message});

  HomeState copyWith(
      {required HomeUiStatus uiStatus,
      List<Product>? products,
      String? message}) {
    return HomeState(
        uiStatus: uiStatus,
        products: products ?? this.products,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [uiStatus, products, message];
}

enum HomeUiStatus { loading, success, failed }
