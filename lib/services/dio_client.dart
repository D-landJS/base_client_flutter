import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_page/services/app_exceptions.dart';

class DioClient {
  static const int timeOutDuration = 20;
  // GET
  Future get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var res = await Dio()
          .get(baseUrl + api)
          .timeout(const Duration(seconds: timeOutDuration));
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
      var res = await Dio()
          .post(baseUrl + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
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

  _processRes(res) {
    switch (res.statusCode) {
      case 200:
      case 201:
        return res.data;
      case 400:
        throw BadRequestException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(res.bodyBytes), res.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('Error ocurred with code : ${res.statusCode}',
            res.request!.url.toString());
    }
  }
}
