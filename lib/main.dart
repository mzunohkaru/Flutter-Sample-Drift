import 'package:drift_sample/pages/home_page.dart';
import 'package:drift_sample/src/drift/todos.dart';
import 'package:flutter/material.dart';

void main() {
  final database = MyDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final MyDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // データベースインスタンスを親から子に受け渡します
      home: DriftSample(database: database),
    );
  }
}

