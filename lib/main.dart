import 'package:flutter/material.dart';

import 'package:flutter_app1/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  //init hive
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox("mybox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
    );
  }
}
