/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:flutter/material.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/ui/screens/home/home_screens.dart';
import 'package:tr_store/ui/utils/app_strings.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(title: AppString.appTitle),
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
