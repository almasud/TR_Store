import 'package:flutter/material.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/ui/routes/app_route.dart';
import 'package:tr_store/ui/routes/route_path.dart';

import 'data/db/app_database.dart';

late AppDatabase appDatabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppComponent().init();
  appDatabase = AppDatabase();
  // database.delete(database.product).go();
  debugPrint("database: $appDatabase");

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
