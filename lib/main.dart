import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_page/test_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}
