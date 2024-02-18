/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/data/repo/cart_repo_impl.dart';
import 'package:tr_store/data/repo/product_repo_impl.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/ui/screens/cart/cart_screen.dart';
import 'package:tr_store/ui/screens/home/bloc/home_bloc.dart';
import 'package:tr_store/ui/screens/home/home_screens.dart';
import 'package:tr_store/utils/app_constants.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<HomeBloc>()..add(FetchProductsFromRemote()),
              child: const HomeScreen(title: AppString.appTitle)),
        );
      case RoutePath.cart:
        return MaterialPageRoute(
          builder: (_) => CartScreen(
            carts: dummyCarts,
            products: dummyProducts,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
                  body: Center(
                    child: Text(
                        "${AppString.noRouteDefineFor} ${routeSettings.name!}"),
                  ),
                ));
    }
  }
}
