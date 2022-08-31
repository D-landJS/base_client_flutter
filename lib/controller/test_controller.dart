import 'dart:convert';

import 'package:test_page/controller/base_controller.dart';
import 'package:test_page/helper/dialog_helper.dart';
import 'package:test_page/services/app_exceptions.dart';
import 'package:test_page/services/base_client.dart';
import 'package:test_page/services/dio_client.dart';

class TestController with BaseController {
  void getData() async {
    showLoading('Fetching data');
    var res = await BaseClient()
        .get('https://jsonplaceholder.typicode.com', '/todos/1')
        .catchError(handleError);
    if (res == null) return;
    hideLoading();
    print(res);
  }

  void postData() async {
    var request = {'message': 'Codex sucks!!'};
    showLoading('Posting data...');
    var res = await BaseClient()
        .post('https://jsonplaceholder.typicode.com', '/posts', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });
    if (res == null) return;
    hideLoading();
    print(res);
  }
}
