/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchProductsFromRemote extends HomeEvent {
  @override
  List<Object?> get props => [];
}
