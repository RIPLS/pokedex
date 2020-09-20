import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  //Get
  Future<dynamic> get(String url, {Map<String, String> headers}) {
    if (headers == null) {
      headers = {};
    }
    headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';

    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
