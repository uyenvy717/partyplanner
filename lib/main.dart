import 'package:flutter/material.dart';
import 'package:partyplanflutter/route/route_generator.dart';
import 'package:partyplanflutter/screens/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const Rootpage(),
    );
  }
}
