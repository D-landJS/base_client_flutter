import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_page/services/app_exceptions.dart';

class BaseClient {
  static const int timeOutDuration = 20;
  // GET
  Future get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var res =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));

      return _processRes(res);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  // POST
  Future post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    try {
      var res = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      throw BadRequestException(
        '{"reason":"Your message is incorrect" , "reason_code": "invalid_message" }',
        res.request!.url.toString(),
      );
      return _processRes(res);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }
  // DELETE
  // OTHER

  _processRes(http.Response res) {
    switch (res.statusCode) {
      case 200:
        var resJson = utf8.decode(res.bodyBytes);
        return resJson;
      case 201:
        var responseJson = utf8.decode(res.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 500:
        throw BadRequestException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      default:
        throw FetchDataException('Error ocurred with code : ${res.statusCode}',
            res.request!.url.toString());
    }
  }
}
