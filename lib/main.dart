import 'package:flutter/material.dart';
import 'package:tr_store/domain/models/product.dart';
import 'package:tr_store/ui/routes/app_route.dart';
import 'package:tr_store/ui/routes/route_path.dart';

import 'data/db/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  // database.delete(database.product).go();

  debugPrint("database: $database");

  database.productDao.insertProducts(dummyProducts);
  final products = database.productDao.getProducts();
  products.listen((event) {
    debugPrint('items size: ${event.length}');
    debugPrint('items in database: $event');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TR Store Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        initialRoute: RoutePath.home);
  }
}
