import 'package:flutter/material.dart';
import 'package:test_page/controller/test_controller.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  final controller = TestController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TestPage')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async {
                  controller.getData();
                },
                child: const Text(
                  'Get Data',
                  style: TextStyle(fontSize: 24),
                )),
            ElevatedButton(
                onPressed: () async {
                  controller.postData();
                },
                child: const Text(
                  'Post Data',
                  style: TextStyle(fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }
}
