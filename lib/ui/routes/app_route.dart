/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/ui/screens/cart/cart_screen.dart';
import 'package:tr_store/ui/screens/home/bloc/product_bloc.dart';
import 'package:tr_store/ui/screens/bloc/product_cart_bloc.dart';
import 'package:tr_store/ui/screens/home/home_screens.dart';
import 'package:tr_store/utils/app_constants.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(create: (context) => getIt<ProductCartBloc>()),
            BlocProvider(
                create: (context) =>
                    getIt<ProductBloc>()..add(FetchProductsFromRemote())),
          ], child: const HomeScreen(title: AppString.appTitle)),
        );
      case RoutePath.cart:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProductCartBloc>(),
            child: const CartScreen(),
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
