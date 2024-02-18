/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:get_it/get_it.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/repo/cart_repo_impl.dart';
import 'package:tr_store/data/repo/product_repo_impl.dart';
import 'package:tr_store/domain/repo/cart_repo.dart';
import 'package:tr_store/domain/repo/product_repo.dart';

final getIt = GetIt.instance;

class AppComponent {
  Future<void> init() async {
    getIt.registerFactory<ProductRepo>(() => ProductRepoImpl());
    getIt.registerFactory<CartRepo>(() => CartRepoImpl());
    getIt.registerFactory<AppDatabase>(() => AppDatabase());
  }
}
