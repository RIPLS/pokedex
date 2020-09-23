import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  static http.Client _client;

  NetworkUtil.internal();

  factory NetworkUtil(http.Client client) {
    _client = client;
    return _instance;
  }

  final JsonDecoder _decoder = new JsonDecoder();

  //Get
  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
    }
    headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';

    final response = await _client.get(url, headers: headers);

    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return _decoder.convert(res);
  }
}
