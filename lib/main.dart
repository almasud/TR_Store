import 'package:flutter/material.dart';
import 'package:tr_store/ui/routes/app_route.dart';
import 'package:tr_store/ui/routes/route_path.dart';

void main() {
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
      initialRoute: RoutePath.home
    );
  }
}

