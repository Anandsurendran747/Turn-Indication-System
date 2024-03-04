import 'package:flutter/material.dart';
import 'package:tis/pages/map_page.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building MyHomePage widget");
    return MaterialApp(
        title: 'TIM',
        theme: ThemeData(primaryColor: Colors.indigo),
        home: const MapPage());
  }
}
