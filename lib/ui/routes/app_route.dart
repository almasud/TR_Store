/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:flutter/material.dart';
import 'package:tr_store/domain/models/cart.dart';
import 'package:tr_store/domain/models/product.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/ui/screens/cart/cart_screen.dart';
import 'package:tr_store/ui/screens/home/home_screens.dart';
import 'package:tr_store/ui/utils/app_strings.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(title: AppString.appTitle),
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
