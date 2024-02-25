import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'TIS',
      theme: ThemeData(
        primaryColor: Colors.indigo
        ),
    );
  }
}
